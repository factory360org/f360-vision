# Copy .env.example to .env
Copy-Item ".env.example" ".env" -Force

# Generate a 32-byte random hex string (64 hex chars)
$randomKey = [System.Guid]::NewGuid().ToString("N") + [System.Guid]::NewGuid().ToString("N")
$randomKey = $randomKey.Substring(0,64)

# Replace or add VIEWER_BACKEND_API_KEY in .env
(Get-Content ".env") |
    ForEach-Object {
        if ($_ -match "^VIEWER_BACKEND_API_KEY=") {
            "VIEWER_BACKEND_API_KEY=$randomKey"
        } else {
            $_
        }
    } | Set-Content ".env"
