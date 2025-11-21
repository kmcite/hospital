# Script to build Flutter web app and deploy to docs folder for GitHub Pages

Write-Host "Starting Flutter web build process..." -ForegroundColor Green

# Clean previous build artifacts
Write-Host "Cleaning previous build..." -ForegroundColor Yellow
flutter clean
flutter pub get

# Build the web app
Write-Host "Building Flutter web app..." -ForegroundColor Yellow
flutter build web --release

# Check if build was successful
if ($LASTEXITCODE -ne 0) {
    Write-Host "Flutter build failed!" -ForegroundColor Red
    exit $LASTEXITCODE
}

# Remove existing content in docs directory (except .gitkeep or other hidden files)
Write-Host "Preparing docs directory..." -ForegroundColor Yellow
$docsPath = "docs"
if (Test-Path $docsPath) {
    # Remove all content except hidden files/directories that start with .
    Get-ChildItem -Path $docsPath -Exclude ".*" | Remove-Item -Recurse -Force
} else {
    New-Item -ItemType Directory -Path $docsPath
}

# Copy build output to docs directory
Write-Host "Copying build output to docs directory..." -ForegroundColor Yellow
$buildWebPath = "build\web\*"
Copy-Item -Path $buildWebPath -Destination $docsPath -Recurse

# Create .nojekyll file for GitHub Pages (if it doesn't exist)
$noJekyllPath = "$docsPath\.nojekyll"
if (-not (Test-Path $noJekyllPath)) {
    New-Item -ItemType File -Path $noJekyllPath
}

Write-Host "Web build successfully copied to docs directory!" -ForegroundColor Green
Write-Host "You can now commit and push to GitHub to deploy to GitHub Pages." -ForegroundColor Cyan