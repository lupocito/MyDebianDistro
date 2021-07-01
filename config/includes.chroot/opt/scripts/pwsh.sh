#!/bin/bash

pwsh -Command "Install-Module PowerShellGet -MinimumVersion 2.2.3 -Force"

echo "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Set-PSRepository -Name PSGallery  -InstallationPolicy Trusted
Install-Module -Force -Name Az.BootStrapper -AllowPrerelease
Install-AzProfile -Profile 2020-09-01-hybrid -Force
Install-Module -Force -Name AzureStack -RequiredVersion 2.1.0" | pwsh -File -

