@echo off
title Install KVP Stock Tracker
rem Self-elevate. Trusting the signing cert for every account on this PC needs admin.
net session >nul 2>&1 || ( powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit /b )
echo Installing KVP Stock Tracker...
rem cmd stops at exit /b. The elevated PowerShell runs the script after the marker.
set "ST_INSTALLER=%~f0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$m=':STOCKTRACKER_INSTALL_PS:'; $t=Get-Content -LiteralPath $env:ST_INSTALLER -Raw; $i=$t.LastIndexOf($m); if ($i -lt 0) { throw 'Installer script marker missing.' }; $script=$t.Substring($i + $m.Length); if ($script -notlike '*Add-AppxPackage*') { throw 'Installer script was not found after the marker.' }; Invoke-Expression $script"
echo.
pause
exit /b

:STOCKTRACKER_INSTALL_PS:
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

# Pinned to the cert that signs the published MSIX (CN=kelby, expires 2031-06-05).
# Package identity Publisher stays CN=kelby. Do not trust a different thumbprint.
$expected = 'D113E38785198138EFEDD2D197B43BD8446C6A84'
$cer = Join-Path $env:TEMP 'ST.cer'
Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/KelbyVP/app-releases/main/stocktracker-win/StockTracker.cer' -OutFile $cer

$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $cer
if ($cert.Thumbprint -ne $expected) {
    throw "Refusing to trust StockTracker.cer. Expected thumbprint $expected, got $($cert.Thumbprint)."
}

# Self-signed, so this cert is the root of the signature chain. In-app MSIX
# updates fail with 0x87E80034 / 0x800B0109 ("root certificate ... must be
# trusted") and Get-AuthenticodeSignature stays UntrustedRoot while it is only
# in TrustedPeople. App Installer ignores CurrentUser stores, so CurrentUser\Root
# does not fix other accounts. LocalMachine\Root is the machine trusted-root
# store Add-AppxPackage and App Installer actually require. TrustedPeople stays
# so the sideload publisher trust is still there.
foreach ($location in @('Cert:\LocalMachine\Root', 'Cert:\LocalMachine\TrustedPeople')) {
    $imported = @(Import-Certificate -FilePath $cer -CertStoreLocation $location)
    $present = @($imported | Where-Object { $_.Thumbprint -eq $expected })
    if ($present.Count -lt 1) {
        throw "Signing cert $expected was not imported into $location."
    }
}

Remove-Item -LiteralPath $cer -Force
Write-Host "Trusted CN=kelby ($expected) for every user on this PC."
Write-Host 'Stores: Cert:\LocalMachine\Root and Cert:\LocalMachine\TrustedPeople.'

try {
    Add-AppxPackage -AppInstallerFile 'https://raw.githubusercontent.com/KelbyVP/app-releases/main/stocktracker-win/StockTracker.appinstaller'
    Write-Host 'Done - KVP Stock Tracker installed and will auto-update on launch.'
} catch {
    $detail = $_ | Out-String
    # Trust is already in place. These HRESULTs mean there is nothing further to
    # install right now (app is open, or this version is already installed).
    if ($detail -match '80073D02') {
        Write-Host 'The certificate is trusted. KVP Stock Tracker is open, so Windows could not replace it yet.'
        Write-Host 'Close it and open it again. The in-app update can install now.'
        return
    }
    if ($detail -match '80073CFB|80073D06') {
        Write-Host 'The certificate is trusted. KVP Stock Tracker is already installed.'
        Write-Host 'The next launch can install updates.'
        return
    }
    throw
}
