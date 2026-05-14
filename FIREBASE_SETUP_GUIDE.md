# Firebase Setup Guide - KAIZEN App

## Current Status
- ❌ google-services.json: Still has **OLD dummy credentials** (project: kaizen-tfg)
- ❌ SHA-1 fingerprint: Not registered in Firebase Console
- ❌ Google Sign-In: Will fail with error code 10 (DEVELOPER_ERROR) until SHA-1 is registered

## Step 1: Get SHA-1 Fingerprint (Windows Command Prompt)

Run the batch script in your project root:
```
get_sha1.bat
```

**What you'll see:**
A detailed certificate information including:
```
SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
```

**Copy the SHA1 value exactly** - you'll need it in the next step.

---

## Step 2: Update Firebase Console

1. Go to Firebase Console: https://console.firebase.google.com
2. Select project: **kaizen-tfg-real**
3. Go to **Project Settings** (gear icon)
4. Select **Your Apps** tab
5. Click on **KAIZEN App** (Android app)
6. Scroll to **SHA certificate fingerprints** section
7. Click **Add fingerprint**
8. Paste your SHA-1 value from Step 1
9. Click **Save**

---

## Step 3: Replace google-services.json

1. In Firebase Console, go to **Project Settings**
2. Click **Platforms** section
3. Click the Android app
4. Click **Download google-services.json** button
5. **Replace** the current file at:
   ```
   android/app/google-services.json
   ```

---

## Step 4: Verify Configuration

Check that google-services.json contains:
```json
{
  "project_info": {
    "project_id": "kaizen-tfg-real",
    ...
  }
}
```

Should show: `"project_id": "kaizen-tfg-real"` ✓
Should NOT show: `"project_id": "kaizen-tfg"` ✗

---

## Step 5: Configure Google Sign-In in Firebase Console

1. Go to Firebase Console → **Authentication**
2. Click **Get Started** (if not already set up)
3. Click on **Google** provider
4. Enable the Google provider
5. Click **Save**

---

## Step 6: Test Google Sign-In

1. Run the app:
   ```
   flutter clean
   flutter pub get
   flutter run
   ```

2. Tap **Iniciar con Google** button
3. Should redirect to Google Sign-In flow
4. On success: navigate to home screen with welcome message

---

## Troubleshooting

**Error: DEVELOPER_ERROR (code 10)**
- ✓ Solution: SHA-1 fingerprint not registered (complete Step 1 & 2)

**Error: INVALID_ACCOUNT**
- ✓ Solution: Google Cloud OAuth consent not configured
- ✓ Fix: Go to Google Cloud Console → Consent Screen → Configure

**Black screen / No navigation after login**
- ✓ Solution: Check app_router.dart configuration
- ✓ Current setup: LoginScreen is initial route

**gradle build error**
- ✓ Run: `flutter clean` then `flutter pub get`

---

## Files Modified
- ✓ `lib/main.dart` - Firebase initialization
- ✓ `lib/core/services/auth_service.dart` - Google Sign-In
- ✓ `lib/features/auth/screens/login_screen.dart` - Login UI
- ✓ `android/app/build.gradle.kts` - Google Services plugin
- ⏳ `android/app/google-services.json` - **Needs update with real credentials**
- ⏳ `lib/core/theme/app_theme.dart` - Verify theming

---

## Next Steps After Firebase Works

1. ✓ Verify Google Sign-In works end-to-end
2. ✓ Test user creation in Firestore
3. ✓ Commit to GitHub: `git add . && git commit -m "feat: firebase real configuration"`
4. ✓ Implement HomeScreen and navigation
5. ✓ Add SmartPantry, Training, Progress features

---

**Questions?** Check the error messages in the console - they're usually descriptive.
