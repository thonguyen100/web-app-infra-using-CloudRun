import json
import os
from pathlib import Path
from string import Template

# Map Terraform resource types to Datadog monitor templates
TEMPLATE_MAP = {
    "google_cloud_run_service": "cloud_run.tpl.hcl",
    "google_sql_database_instance": "mysql.tpl.hcl",
}

# Where templates are stored (relative to the project root)
TEMPLATE_DIR = Path(__file__).resolve().parents[1] / "templates"

# Output path
OUTPUT_FILE = "generated_monitors.tf"


def load_template(template_name):
    """Load a Datadog monitor template as a string."""
    template_path = TEMPLATE_DIR / template_name
    if not template_path.exists():
        raise FileNotFoundError(f"Template not found: {template_path}")
    return Template(template_path.read_text())


def detect_new_resources(plan_json):
    """Return a list of newly added resources from the Terraform plan."""
    new_resources = []
    for resource_change in plan_json.get("resource_changes", []):
        if resource_change.get("change", {}).get("actions") == ["create"]:
            res_type = resource_change["type"]
            res_name = resource_change["name"]
            res_address = resource_change["address"]
            res_values = resource_change.get("change", {}).get("after", {})

            new_resources.append({
                "type": res_type,
                "name": res_name,
                "address": res_address,
                "values": res_values
            })
    return new_resources


def render_monitors(new_resources):
    """Render Datadog monitor configs for supported resource types."""
    rendered_monitors = []

    for res in new_resources:
        resource_type = res["type"]
        resource_name = res["values"].get("name") or res["name"]

        template_file = TEMPLATE_MAP.get(resource_type)
        if not template_file:
            print(f"Skipping unsupported resource type: {resource_type}")
            continue

        template = load_template(template_file)
        monitor_code = template.substitute(resource_name=resource_name)
        rendered_monitors.append(monitor_code)

    return rendered_monitors


def main():
    plan_path = "plan.json"

    if not os.path.exists(plan_path):
        print(f"Error: {plan_path} not found. Make sure terraform plan was exported as JSON.")
        return

    with open(plan_path) as f:
        plan_data = json.load(f)

    new_resources = detect_new_resources(plan_data)
    if not new_resources:
        print("No new resources to monitor.")
        return

    rendered = render_monitors(new_resources)

    with open(OUTPUT_FILE, "w") as out:
        out.write("\n\n".join(rendered))

    print(f"Generated {len(rendered)} monitor(s) in {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
