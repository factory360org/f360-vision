# Check if .env file exists
if (-Not (Test-Path ".env")) {
    Write-Host ".env file not found."
    exit 1
}

# Read .env content
$envContent = Get-Content ".env"

# Helper function to extract and validate variable
function Require-EnvVar($name) {
    $line = $envContent | Where-Object { $_ -match "^$name=" }
    if (-Not $line) {
        Write-Host "Required variable '$name' not found in .env"
        exit 1
    }
    return $line -replace "^$name=", ""
}

# Extract required variables
$appPort             = Require-EnvVar "APP_PORT"
$viewerBackendPort   = Require-EnvVar "VIEWER_BACKEND_PORT"
$viewerApiKey        = Require-EnvVar "VIEWER_BACKEND_API_KEY"

# Pull updated Docker images
Write-Host "Pulling latest Docker images..."
try {
    docker compose pull
} catch {
    Write-Host "Failed to pull Docker images."
    exit 1
}

Write-Host ""

# Run Docker Compose
Write-Host "Running: docker compose up -d"
try {
    docker compose up -d
} catch {
    Write-Host "Failed to run 'docker compose up -d'."
    exit 1
}

Write-Host ""

# Show final URLs
Write-Host "App is available at: http://localhost:${appPort}"
Write-Host "Connect to the viewer: http://localhost:${appPort}/connect?serverUrl=http://localhost:${viewerBackendPort}`&apiKey=${viewerApiKey}"
