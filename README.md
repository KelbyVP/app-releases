# app-releases

Public download/auto-update artifacts for Kelby's apps. **Binaries only** — the
app source lives in private repos. Each app has an **Android** build and a
**Windows** build:

| App | Platform | Folder | Install link |
|-----|----------|--------|--------------|
| **KVP Stock Tracker** | Android | [`stocktracker-android/`](stocktracker-android/) | [APK](https://raw.githubusercontent.com/KelbyVP/app-releases/main/stocktracker-android/kvp-stock-tracker-arm64.apk) |
| **KVP Stock Tracker** | Windows | [`stocktracker-win/`](stocktracker-win/) | [Install-StockTracker.cmd](https://github.com/KelbyVP/app-releases/blob/main/stocktracker-win/Install-StockTracker.cmd) |
| **KVPAI** | Android | [`kvpai-android/`](kvpai-android/) | [APK](https://raw.githubusercontent.com/KelbyVP/app-releases/main/kvpai-android/kvpai-android-arm64.apk) |
| **KVPAI** | Windows | [`kvpai-win/`](kvpai-win/) | [Install-KVPAI.cmd](https://github.com/KelbyVP/app-releases/blob/main/kvpai-win/Install-KVPAI.cmd) |

Android = `.apk` (open the link on the phone, tap to install). Windows = signed
MSIX (download the `Install-*.cmd`, double-click → Yes). All four self-update
after the first install.

> Folder names are kept as-is because installed apps check these exact URLs for
> updates — renaming would break auto-update on devices already out there.
