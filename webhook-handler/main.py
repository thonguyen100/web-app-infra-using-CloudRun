# main.py
import os
import requests
from flask import Flask, request, jsonify

app = Flask(__name__)

GITHUB_TOKEN = os.environ.get("GITHUB_TOKEN_FOR_DATADOG")
GITHUB_REPO  = os.environ.get("GITHUB_REPO_FOR_DATADOG")  # e.g., "your-org/your-repo"

@app.route("/", methods=["POST"])
def handle_webhook():
    data = request.json

    alert_type = data.get("alert_type", "")
    print("Received alert_type:", alert_type)

    # Decide the event type and desired scale
    if alert_type == "error":
        event_type = "scale_up"
        scale = 6
    elif alert_type == "recovery":
        event_type = "scale_down"
        scale = 3
    else:
        return jsonify({"status": "ignored"}), 200

    # Build the JSON body to POST to GitHub
    github_payload = {
        "event_type": event_type,
        "client_payload": {
            "max_instance_count": scale
        }
    }

    # Send it to GitHub Actions via repository_dispatch
    response = requests.post(
        f"https://api.github.com/repos/{GITHUB_REPO}/dispatches",
        json=github_payload,
        headers={
            "Authorization": f"Bearer {GITHUB_TOKEN}",
            "Accept": "application/vnd.github+json"
        }
    )

    if response.status_code == 204:
        return jsonify({"status": "triggered"}), 200
    else:
        print("GitHub error:", response.text)
        return jsonify({"status": "error", "details": response.text}), 500
