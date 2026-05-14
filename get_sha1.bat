@echo off
REM Script to get SHA-1 fingerprint of Android debug keystore
REM This is needed to register in Firebase Console for Google Sign-In

echo Getting SHA-1 fingerprint of debug keystore...
echo.

keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

echo.
echo Copy the SHA1 value above and register it in Firebase Console:
echo https://console.firebase.google.com -> Settings -> Your Apps -> Android App -> SHA certificate fingerprints
