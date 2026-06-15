# Wear OS companion - manual sideload APK

`wear-release.apk` is the signed Wear OS companion for KVP Stock Tracker. Use it
only for the first install on a watch (or after deleting the watch app). Once
installed, the phone app auto-pushes future versions over Bluetooth - no further
sideloading needed.

- Package: `com.kvp.kvp_stock_tracker` (release, NOT `.debug`)
- Version: 1.10.39 (versionCode 81) - matches phone release 1.10.39
- Signer SHA-1: `36:FD:07:D1:D3:83:BF:3F:74:CD:27:62:32:59:AE:2F:75:B9:73:C9`
  (same cert as the phone release - required for Data Layer pairing)

## Install

Download the raw file - do NOT extract it (an APK is already a zip):

https://raw.githubusercontent.com/KelbyVP/app-releases/main/stocktracker-wear/wear-release.apk

With the watch in Wear OS ADB/developer mode:

    adb install -r wear-release.apk

The watch pairs only with the PRODUCTION phone (1.10.39 release); a debug phone
build will not pair with this release APK.
