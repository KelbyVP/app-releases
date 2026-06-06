@echo off
title Install KVP Stock Tracker
rem Self-elevate (trusting the signing cert needs admin), then trust + install.
net session >nul 2>&1 || ( powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit /b )
echo Installing KVP Stock Tracker...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; Invoke-WebRequest 'https://raw.githubusercontent.com/KelbyVP/app-releases/main/stocktracker-win/StockTracker.cer' -OutFile \"$env:TEMP\ST.cer\"; Import-Certificate -FilePath \"$env:TEMP\ST.cer\" -CertStoreLocation Cert:\LocalMachine\TrustedPeople | Out-Null; Add-AppxPackage -AppInstallerFile 'https://raw.githubusercontent.com/KelbyVP/app-releases/main/stocktracker-win/StockTracker.appinstaller'; Write-Host 'Done - KVP Stock Tracker installed and will auto-update on launch.'"
echo.
pause
