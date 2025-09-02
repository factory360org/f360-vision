param(
    [string]$TargetDir = (Get-Location).Path
)

$RepoUrl = "https://github.com/factory360org/f360-vision"
$Branch = "main"
$ZipName = "f360-vision.zip"

# Download repo as zip
Invoke-WebRequest -Uri "$RepoUrl/archive/$Branch.zip" -OutFile $ZipName

# Unzip to target directory
Expand-Archive -Path $ZipName -DestinationPath $TargetDir -Force

# Delete the zip
Remove-Item $ZipName -Force

# Go into target dir
Set-Location $TargetDir

$ExtractedFolder = Join-Path $TargetDir "f360-vision-$Branch"

# Move extracted repo contents into target directory
Get-ChildItem -Path $ExtractedFolder -Force | ForEach-Object {
    Move-Item -Path $_.FullName -Destination $TargetDir -Force
}

# Copy contents from winos instead of unix
$WinosFolder = Join-Path $TargetDir "winos"
if (Test-Path $WinosFolder) {
    Get-ChildItem -Path $WinosFolder -Force | ForEach-Object {
        Move-Item -Path $_.FullName -Destination $TargetDir -Force
    }
}

# Remove extracted folders
Remove-Item -Recurse -Force (Join-Path $TargetDir "f360-vision-$Branch")
Remove-Item -Recurse -Force (Join-Path $TargetDir "unix") -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force (Join-Path $TargetDir "winos") -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force (Join-Path $TargetDir "docs") -ErrorAction SilentlyContinue
Remove-Item -Force (Join-Path $TargetDir ".gitignore") -ErrorAction SilentlyContinue

# Run setup script (assuming it works with PowerShell)
$SetupScript = Join-Path $TargetDir "setup.ps1"
if (Test-Path $SetupScript) {
    Write-Host "Running setup.ps1..."
    & $SetupScript
} else {
    Write-Host "setup.ps1 not found, skipping."
}
