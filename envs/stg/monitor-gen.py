import re

resource_file = "modules/cloud_run/main.tf"
output_file = "monitoring_autogen.tf"

module_template = """
module "monitoring_{resource}" {{
  source         = "./modules/monitoring/cloudrun-dev"
  monitor_cpu    = true
  resource_type  = "{resource_type}"
  resource_name  = "{resource_name}"
}}
"""

with open(resource_file, "r") as f:
    tf = f.read()

matches = re.findall(r'resource\s+"google_cloud_run_v2_service"\s+"(.*?)"\s+\{(.*?)\}', tf, re.DOTALL)

generated_modules = []

for name, block in matches:
    if 'monitor_cpu' in block and '"true"' in block:
        # Try to get the "name" field value (might contain interpolation)
        name_match = re.search(r'name\s+=\s+"(.*?)"', block)
        resource_name = name_match.group(1) if name_match else name

        generated_modules.append(module_template.format(
            resource=name,
            resource_type="cloud_run",
            resource_name=resource_name
        ))

with open(output_file, "w") as f:
    f.write("// AUTO-GENERATED MONITORING MODULES\n")
    for m in generated_modules:
        f.write(m)

print(f"✅ Generated {len(generated_modules)} monitoring modules in {output_file}")
