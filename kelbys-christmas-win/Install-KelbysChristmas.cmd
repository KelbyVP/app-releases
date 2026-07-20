@echo off
REM Sideload helper for family pilot (Windows).
REM Prefer the published App Installer URI when available; fall back to local MSIX.
setlocal
set "ROOT=%~dp0"
set "APPINSTALLER=%ROOT%KelbysChristmas.appinstaller"
set "MSIX=%ROOT%kelbys-christmas.msix"
set "REMOTE=https://raw.githubusercontent.com/KelbyVP/app-releases/main/kelbys-christmas-win/KelbysChristmas.appinstaller"

echo Kelby's Christmas — install / update
echo.

if exist "%APPINSTALLER%" (
  echo Opening local App Installer: %APPINSTALLER%
  start "" "%APPINSTALLER%"
  goto :eof
)

if exist "%MSIX%" (
  echo Opening local MSIX: %MSIX%
  start "" "%MSIX%"
  goto :eof
)

echo No local package found. Opening published App Installer...
start "" "%REMOTE%"
endlocal
