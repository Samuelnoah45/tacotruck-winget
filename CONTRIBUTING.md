# Contributing to TacoTruck Winget Package

Thank you for your interest in contributing to the TacoTruck Winget Package repository! This document provides guidelines and instructions for contributing to this project.

## Updating the Manifest for a New Version

When a new version of TacoTruck is released, the winget manifest needs to be updated. There are two ways to do this:

### 1. Using the GitHub Actions Workflow (Recommended)

1. Go to the "Actions" tab in the GitHub repository.
2. Select the "Update Winget Manifest" workflow.
3. Click "Run workflow".
4. Enter the following information:
   - **Version**: The new version of TacoTruck (e.g., `1.0.0-beta.28`).
   - **x64_sha256**: The SHA256 hash of the x64 Windows package.
   - **arm64_sha256**: The SHA256 hash of the ARM64 Windows package.
5. Click "Run workflow".

This will create a new branch and pull request with the updated manifest files.

### 2. Manually Updating the Manifest

1. Create Windows packages for the new version using the `scripts/create-windows-package.ps1` script:

   ```powershell
   .\scripts\create-windows-package.ps1 -Version "1.0.0-beta.28"
   ```

   This will download the binaries, create ZIP packages, and output the SHA256 hashes.

2. Update the manifest files using the `scripts/update-winget-manifest.ps1` script:

   ```powershell
   .\scripts\update-winget-manifest.ps1 -Version "1.0.0-beta.28" -X64Sha256 "hash_value_here" -Arm64Sha256 "hash_value_here"
   ```

3. Validate the manifest files:

   ```powershell
   wingetcreate validate .\manifests\t\TestFiesta\TacoTruck\1.0.0-beta.28\
   ```

4. Commit and push your changes, then create a pull request.

## Testing the Package

Before submitting a pull request, you should test the package to ensure it installs correctly:

1. Install the package using the manifest:

   ```powershell
   winget install -m .\manifests\t\TestFiesta\TacoTruck\<version>\TestFiesta.TacoTruck.installer.yaml
   ```

2. Verify that the package installs correctly and the `tacotruck` command is available.

3. Uninstall the package:

   ```powershell
   winget uninstall TestFiesta.TacoTruck
   ```

## Pull Request Process

1. Create a new branch for your changes.
2. Make your changes following the guidelines above.
3. Commit your changes with a clear and descriptive commit message.
4. Push your branch to your fork of the repository.
5. Submit a pull request to the main repository.

## Code of Conduct

Please note that this project is released with a Contributor Code of Conduct. By participating in this project, you agree to abide by its terms.

## Questions or Issues?

If you have any questions or encounter any issues, please open an issue in the repository.
