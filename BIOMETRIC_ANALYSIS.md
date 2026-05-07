# Biometric Feature Analysis (Android)

## Issue Description
The biometric authentication feature is currently broken on Android devices. When attempting to use biometric login or prompt the user for biometric authentication, the feature fails to display the system biometric prompt or behaves unexpectedly.

## Probable Cause
The `local_auth` package in Flutter requires specific platform-level configuration on Android to function correctly. Specifically, it relies on Android's `FragmentActivity` to display the native biometric dialog.

Currently, the Android `MainActivity` in the project is configured to extend the standard `FlutterActivity`, which does not support the necessary Fragment transactions required by the biometric prompt.

## Faulty Code Location
The faulty code is located in the Android main activity Kotlin file:
**Path:** `android/app/src/main/kotlin/com/cropadvisory/crop_advisory/MainActivity.kt`

### Current Faulty Implementation:
```kotlin
package com.cropadvisory.crop_advisory

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()
```

### Required Fix:
To resolve this issue, the `MainActivity` must be changed to extend `FlutterFragmentActivity` instead of `FlutterActivity`.

The corrected code should look like this:
```kotlin
package com.cropadvisory.crop_advisory

import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
}
```

By making this change, the Android platform will be able to properly render the native biometric prompt required by the `local_auth` package.
