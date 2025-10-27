# PowerShell script to create Windows packages for TacoTruck CLI
param (
    [Parameter(Mandatory=$true)]
    [string]$Version
)

$ErrorActionPreference = "Stop"

# Configuration
$repoUrl = "https://github.com/testfiesta/tacotruck"
$outputDir = ".\releases"
$architectures = @("x64", "arm64")

# Create output directory if it doesn't exist
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
    Write-Host "Created output directory: $outputDir"
}

# Function to download file and calculate SHA256
function Download-File {
    param (
        [string]$Url,
        [string]$OutputPath
    )
    
    Write-Host "Downloading $Url to $OutputPath..."
    
    try {
        Invoke-WebRequest -Uri $Url -OutFile $OutputPath
        
        # Calculate SHA256
        $hash = Get-FileHash -Path $OutputPath -Algorithm SHA256
        return $hash.Hash.ToLower()
    }
    catch {
        Write-Error "Failed to download $Url. Error: $_"
        exit 1
    }
}

# Function to create a Windows package
function Create-WindowsPackage {
    param (
        [string]$Architecture,
        [string]$Version
    )
    
    $tempDir = Join-Path $env:TEMP "tacotruck-$Version-$Architecture"
    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force
    }
    New-Item -ItemType Directory -Path $tempDir | Out-Null
    
    # Download the binary
    $binaryUrl = "$repoUrl/releases/download/v$Version/tacotruck-$Version-win-$Architecture"
    $binaryPath = Join-Path $tempDir "tacotruck.exe"
    
    Write-Host "Downloading TacoTruck binary for $Architecture..."
    $sha256 = Download-File -Url $binaryUrl -OutputPath $binaryPath
    
    # Make the binary executable
    if (Test-Path $binaryPath) {
        Write-Host "Binary downloaded successfully."
    } else {
        Write-Error "Failed to download binary."
        exit 1
    }
    
    # Create ZIP package
    $zipFile = Join-Path $outputDir "tacotruck-$Version-win-$Architecture.zip"
    Compress-Archive -Path "$tempDir\*" -DestinationPath $zipFile -Force
    
    Write-Host "Created package: $zipFile"
    Write-Host "SHA256: $sha256"
    
    # Clean up temp directory
    Remove-Item -Path $tempDir -Recurse -Force
    
    return @{
        Path = $zipFile
        SHA256 = $sha256
    }
}

# Main script
Write-Host "Creating Windows packages for TacoTruck CLI version $Version"

$results = @{}

foreach ($arch in $architectures) {
    Write-Host "`nProcessing $arch architecture..."
    $result = Create-WindowsPackage -Architecture $arch -Version $Version
    $results[$arch] = $result
}

# Output results
Write-Host "`n=== Package Creation Complete ==="
Write-Host "Version: $Version"

foreach ($arch in $architectures) {
    $result = $results[$arch]
    Write-Host "`nArchitecture: $arch"
    Write-Host "Package: $($result.Path)"
    Write-Host "SHA256: $($result.SHA256)"
}

# Output manifest snippet
Write-Host "`n=== Installer Manifest Snippet ==="
Write-Host "Installers:"
foreach ($arch in $architectures) {
    $result = $results[$arch]
    Write-Host "- Architecture: $arch"
    Write-Host "  InstallerUrl: $repoUrl/releases/download/v$Version/tacotruck-$Version-win-$arch.zip"
    Write-Host "  InstallerSha256: $($result.SHA256)"
}

Write-Host "`nDone!"
