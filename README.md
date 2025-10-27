# Winget TacoTruck Package

This repository contains the Windows Package Manager (winget) manifest for [TacoTruck](https://github.com/testfiesta/tacotruck), a Test/QA data pipeline CLI tool by TestFiesta.

## What is TacoTruck?

TacoTruck is a command-line interface tool designed for test and QA data pipeline management. It provides developers and QA engineers with powerful capabilities to streamline their testing workflows and data management processes.

## Installation

### Prerequisites

- Windows 10 1809 or later
- [Windows Package Manager (winget)](https://github.com/microsoft/winget-cli)

### Install TacoTruck CLI

You can install TacoTruck using winget:

```powershell
winget install TestFiesta.TacoTruck
```

### Verify Installation

After installation, verify that TacoTruck is working correctly:

```powershell
tacotruck --version
```

This should display the current version of TacoTruck CLI.

## Usage

Once installed, you can use the `tacotruck` command from anywhere in your terminal. For detailed usage instructions and available commands, refer to the [official TacoTruck documentation](https://github.com/testfiesta/tacotruck).

## Updating

To update TacoTruck to the latest version:

```powershell
winget upgrade TestFiesta.TacoTruck
```

## Uninstalling

To remove TacoTruck:

```powershell
winget uninstall TestFiesta.TacoTruck
```

## About This Repository

This repository contains the winget manifest files required to install TacoTruck CLI on Windows systems. The manifest is automatically updated when new versions of TacoTruck are released.

## Issues and Support

- For TacoTruck-specific issues: [TacoTruck GitHub Issues](https://github.com/testfiesta/tacotruck/issues)
- For winget package-related issues: Please create an issue in this repository

## License

TacoTruck is licensed under the MIT License. See the [official repository](https://github.com/testfiesta/tacotruck) for more details.
