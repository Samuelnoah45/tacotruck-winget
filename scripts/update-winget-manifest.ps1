# PowerShell script to update winget manifest files
param (
    [Parameter(Mandatory=$true)]
    [string]$Version,
    [Parameter(Mandatory=$true)]
    [string]$X64Sha256,
    [Parameter(Mandatory=$true)]
    [string]$Arm64Sha256
)

$ErrorActionPreference = "Stop"

# Configuration
$repoUrl = "https://github.com/testfiesta/tacotruck"
$manifestDir = ".\manifests\t\TestFiesta\TacoTruck\$Version"

# Create manifest directory if it doesn't exist
if (-not (Test-Path $manifestDir)) {
    New-Item -ItemType Directory -Path $manifestDir -Force | Out-Null
    Write-Host "Created manifest directory: $manifestDir"
}

# Create version manifest
$versionManifest = @"
# Created using wingetcreate 1.5.7.0
# yaml-language-server: `$schema=https://aka.ms/winget-manifest.version.1.5.0.schema.json

PackageIdentifier: TestFiesta.TacoTruck
PackageVersion: $Version
DefaultLocale: en-US
ManifestType: version
ManifestVersion: 1.5.0
"@

# Create locale manifest
$localeManifest = @"
# Created using wingetcreate 1.5.7.0
# yaml-language-server: `$schema=https://aka.ms/winget-manifest.defaultLocale.1.5.0.schema.json

PackageIdentifier: TestFiesta.TacoTruck
PackageVersion: $Version
PackageLocale: en-US
Publisher: TestFiesta
PublisherUrl: https://github.com/testfiesta
PublisherSupportUrl: https://github.com/testfiesta/tacotruck/issues
# PrivacyUrl: 
Author: TestFiesta
PackageName: TacoTruck
PackageUrl: https://github.com/testfiesta/tacotruck
License: MIT
LicenseUrl: https://github.com/testfiesta/tacotruck/blob/main/LICENSE
# Copyright: 
# CopyrightUrl: 
ShortDescription: Test/QA data pipeline CLI tool
Description: TacoTruck is a command-line interface tool designed for test and QA data pipeline management. It provides developers and QA engineers with powerful capabilities to streamline their testing workflows and data management processes.
# Moniker: 
Tags:
- cli
- qa
- testing
- data-pipeline
ReleaseNotes: TacoTruck CLI version $Version
ReleaseNotesUrl: $repoUrl/releases/tag/v$Version
# PurchaseUrl: 
# InstallationNotes: 
# Documentations: 
ManifestType: defaultLocale
ManifestVersion: 1.5.0
"@

# Create installer manifest
$installerManifest = @"
# Created using wingetcreate 1.5.7.0
# yaml-language-server: `$schema=https://aka.ms/winget-manifest.installer.1.5.0.schema.json

PackageIdentifier: TestFiesta.TacoTruck
PackageVersion: $Version
InstallerType: zip
NestedInstallerType: portable
NestedInstallerFiles:
- RelativeFilePath: tacotruck.exe
  PortableCommandAlias: tacotruck
Commands:
- tacotruck
Installers:
- Architecture: x64
  InstallerUrl: $repoUrl/releases/download/v$Version/tacotruck-$Version-win-x64.zip
  InstallerSha256: $X64Sha256
- Architecture: arm64
  InstallerUrl: $repoUrl/releases/download/v$Version/tacotruck-$Version-win-arm64.zip
  InstallerSha256: $Arm64Sha256
ManifestType: installer
ManifestVersion: 1.5.0
"@

# Write manifest files
$versionManifestPath = Join-Path $manifestDir "TestFiesta.TacoTruck.yaml"
$localeManifestPath = Join-Path $manifestDir "TestFiesta.TacoTruck.locale.en-US.yaml"
$installerManifestPath = Join-Path $manifestDir "TestFiesta.TacoTruck.installer.yaml"

Set-Content -Path $versionManifestPath -Value $versionManifest
Set-Content -Path $localeManifestPath -Value $localeManifest
Set-Content -Path $installerManifestPath -Value $installerManifest

Write-Host "Created manifest files for version $Version:"
Write-Host "- $versionManifestPath"
Write-Host "- $localeManifestPath"
Write-Host "- $installerManifestPath"

Write-Host "`nDone!"
