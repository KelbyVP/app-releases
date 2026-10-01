# KVP Stock Tracker — WINDOWS

This folder holds the **Windows** build only — a signed MSIX
(`KVPStockTracker_x64.msix`) installed/updated through Windows App Installer
(`StockTracker.appinstaller`). To install, run `Install-StockTracker.cmd`.

That installer trusts signing cert CN=kelby (thumbprint
`D113E38785198138EFEDD2D197B43BD8446C6A84`) in Local Machine Trusted Root and
Trusted People, then installs. In-app updates fail with 0x800B0109 until the
machine root trust is there. If the app is already installed, download this
`Install-StockTracker.cmd` again and run it once. One run covers every account
on the PC. A copy saved before this change only imports Trusted People and
leaves updates blocked.

The **Android** build (APK) is the separate [`stocktracker-android/`](../stocktracker-android/)
folder.
