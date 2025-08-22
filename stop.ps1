try {
    docker compose down
} catch {
    Write-Host "Failed to stop Docker Compose services."
    exit 1
}
