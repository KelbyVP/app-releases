@echo off
title Install KVPAI
rem Self-elevate (trusting the signing cert needs admin), then trust + install.
net session >nul 2>&1 || ( powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit /b )
echo Installing KVPAI...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; Invoke-WebRequest 'https://raw.githubusercontent.com/KelbyVP/app-releases/main/kvpai/KVPAI.cer' -OutFile \"$env:TEMP\KVPAI.cer\"; Import-Certificate -FilePath \"$env:TEMP\KVPAI.cer\" -CertStoreLocation Cert:\LocalMachine\TrustedPeople | Out-Null; Add-AppxPackage -AppInstallerFile 'https://raw.githubusercontent.com/KelbyVP/app-releases/main/kvpai/KVPAI.appinstaller'; Write-Host 'Done - KVPAI is installed and will auto-update on launch.'"
echo.
pause
