$url = "https://github.com/testfiesta/tacotruck/releases/download/v1.0.0-beta.30/tacotruck-1.0.0-beta.30-windows-x64.exe"
$outputPath = ".\tacotruck-downloaded.exe"

Write-Host "Downloading file from: $url"
try {
    Invoke-WebRequest -Uri $url -OutFile $outputPath -UseBasicParsing
    Write-Host "Download successful!"
} catch {
    Write-Host "Error downloading file: $_"
    exit 1
}

if (Test-Path $outputPath) {
    # Calculate hash in lowercase (winget expects lowercase)
    $hash = (Get-FileHash -Path $outputPath -Algorithm SHA256).Hash.ToLower()
    Write-Host ""
    Write-Host "SHA256 Hash (for manifest): $hash"
    Write-Host ""
    Write-Host "Copy this hash and update your manifest file:"
    Write-Host ""
    Write-Host "InstallerSha256: $hash"
    Write-Host ""
    
    # Create a sample command to test installation
    Write-Host "After updating the manifest, test installation with:"
    Write-Host "winget install --manifest .\manifests\t\TestFiesta\TacoTruck\1.0.0-beta.27"
} else {
    Write-Host "Failed to download file."
}

