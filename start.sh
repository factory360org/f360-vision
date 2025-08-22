#!/usr/bin/env bash
set -euo pipefail

ENV_FILE=".env"

# Check if .env file exists
if [[ ! -f "$ENV_FILE" ]]; then
  echo ".env file not found."
  exit 1
fi

# Helper function to get required env var from .env
require_env_var() {
  local name="$1"
  local val
  val=$(grep -E "^${name}=" "$ENV_FILE" | head -n1 | cut -d'=' -f2-)
  if [[ -z "$val" ]]; then
    echo "Required variable '$name' not found in $ENV_FILE"
    exit 1
  fi
  echo "$val"
}

# Extract variables
APP_PORT=$(require_env_var "APP_PORT")
VIEWER_BACKEND_PORT=$(require_env_var "VIEWER_BACKEND_PORT")
VIEWER_BACKEND_API_KEY=$(require_env_var "VIEWER_BACKEND_API_KEY")

# Pull latest Docker images
echo "Pulling latest Docker images..."
if ! docker compose pull; then
  echo "Failed to pull Docker images."
  exit 1
fi

# Run Docker Compose
echo "Running: docker compose up -d"
if ! docker compose up -d; then
  echo "Failed to run 'docker compose up -d'."
  exit 1
fi

echo ""

# Show final URLs
echo "App is available at: http://localhost:${APP_PORT}"
echo "Connect to the viewer: http://localhost:${APP_PORT}/connect?serverUrl=http://localhost:${VIEWER_BACKEND_PORT}&apiKey=${VIEWER_BACKEND_API_KEY}"
