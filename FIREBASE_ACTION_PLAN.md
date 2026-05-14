# Firebase Real Configuration - Action Plan

## 📋 Current Status

### ✅ Completed Setup
- [x] Flutter project structure created
- [x] Firebase dependencies in pubspec.yaml (firebase_core, firebase_auth, google_sign_in, cloud_firestore)
- [x] AuthService class with Google Sign-In implementation
- [x] LoginScreen UI with Google button
- [x] Google Services plugin in gradle files (Android)
- [x] Firebase initialization in main.dart with error handling
- [x] GoRouter configuration for navigation
- [x] User model for Firestore data structure

### ❌ Still Required
- [ ] SHA-1 fingerprint registration in Firebase Console
- [ ] Real google-services.json file (kaizen-tfg-real)
- [ ] Real firebase_options.dart credentials
- [ ] Google Sign-In testing and verification
- [ ] GitHub commit with working Firebase setup

---

## 🔄 Step-by-Step Execution Plan

### **PHASE 1: Get SHA-1 Fingerprint (5 minutes)**

**Action:** Run the batch script to extract your debug keystore's SHA-1 fingerprint
```bash
# Open Command Prompt and run:
C:\Projects\kaizen_app\get_sha1.bat
```

**Expected Output:**
```
Certificate fingerprints:
	 SHA1: AB:CD:EF:12:34:56:78:90:AB:CD:EF:12:34:56:78:90:AB:CD:EF:12
```

**Next:** Copy the SHA1 value exactly (without colons) for Step 2

---

### **PHASE 2: Register SHA-1 in Firebase Console (3 minutes)**

**Action:** 
1. Open Firebase Console: https://console.firebase.google.com
2. Select project: **kaizen-tfg-real**
3. Navigate to **Project Settings** (⚙️ gear icon, top-right)
4. Click **Your Apps** section
5. Select **KAIZEN App** (Android)
6. Scroll to **SHA certificate fingerprints**
7. Click **Add fingerprint**
8. Paste your SHA1 value from Phase 1
9. Save

**After this step:** Google Sign-In error code 10 will be resolved

---

### **PHASE 3: Download Real google-services.json (2 minutes)**

**Action:**
1. In Firebase Console, go to **Project Settings**
2. Click the **Android** app card under "Your Apps"
3. Click **Download google-services.json** button
4. Move the file to your project: `android/app/google-services.json`
5. **Replace** the existing file

**Verification:**
```json
{
  "project_info": {
    "project_id": "kaizen-tfg-real"  ✓ (not "kaizen-tfg")
  }
}
```

---

### **PHASE 4: Extract Real Firebase Credentials (2 minutes)**

**Action:**
1. From the downloaded google-services.json, extract the values:
   - `project_number`
   - `project_id`
   - API key from `client[0].api_key[0].current_key`
   - `mobilesdk_app_id`

2. Update `lib/firebase_options.dart` with the real values:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_REAL_API_KEY_HERE',
  appId: 'YOUR_REAL_APP_ID_HERE',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'kaizen-tfg-real',
);
```

**Note:** The API key is safe to commit to GitHub - it's not sensitive. The real security is the SHA-1 fingerprint registration.

---

### **PHASE 5: Configure Google Sign-In in Firebase Console (1 minute)**

**Action:**
1. Firebase Console → **Authentication**
2. Click **Get Started** (if not already done)
3. Select **Google** provider
4. Enable it
5. Click **Save**

---

### **PHASE 6: Run and Test (5 minutes)**

**Action:**
```bash
# In your project directory:
flutter clean
flutter pub get
flutter run
```

**Test:**
1. App should load LoginScreen
2. Tap "Iniciar con Google" button
3. Should open Google Sign-In flow
4. After successful login: should navigate to home screen
5. Should see: "¡Bienvenido, [Your Name]!" message

**If you see error code 10:**
- Go back to Phase 2 and verify SHA-1 is registered

---

### **PHASE 7: Commit to GitHub (2 minutes)**

**Action:**
```bash
git add .
git commit -m "feat: configure firebase real project with google sign-in"
git push origin main
```

**Files changed:**
- `android/app/google-services.json` (updated with real credentials)
- `lib/firebase_options.dart` (updated with real API keys)

---

## 📁 Files Ready for Update

When you complete Phases 1-3, these files will be updated:

1. **android/app/google-services.json**
   - Current: kaizen-tfg (dummy)
   - Target: kaizen-tfg-real (real)

2. **lib/firebase_options.dart**
   - Current: Dummy API keys and app IDs
   - Target: Real values from google-services.json

---

## 🧪 Testing Checklist

After Phase 6 (flutter run), verify:

- [ ] App loads without black screen
- [ ] LoginScreen displays with green "Iniciar con Google" button
- [ ] Clicking button opens Google Sign-In dialog
- [ ] Can select a Google account
- [ ] After login, navigates to home screen (or shows next screen)
- [ ] Shows welcome message with your name
- [ ] No error code 10 (DEVELOPER_ERROR)
- [ ] No "Firebase not initialized" errors in console

---

## ⏱️ Total Time Estimate
**~20 minutes** from start to working Google Sign-In

---

## 🆘 Common Issues & Fixes

| Issue | Cause | Fix |
|-------|-------|-----|
| Error code 10 | SHA-1 not registered | Complete Phase 2 |
| Black screen | Firebase init issue | Check main.dart try-catch runs without errors |
| "Developer error" | Wrong Firebase project | Verify google-services.json has kaizen-tfg-real |
| gradle errors | Dependencies missing | Run `flutter pub get` |
| App crashes on login | OAuth not enabled | Enable Google in Firebase Authentication |

---

## 📝 Notes

- **API Keys are safe to commit** - They're public Firebase configuration
- **SHA-1 fingerprint is the security boundary** - Don't share it publicly
- **google-services.json must match your Firebase project** - Mismatches cause error 10
- **Debug keystore is on your local machine** - Different machines have different SHA-1s
- **This setup is for development only** - Release builds will need different signing config

---

## ✨ After Firebase Works

Once Google Sign-In is working:
1. Create HomeScreen UI
2. Implement SmartPantry feature
3. Add Training section
4. Build Progress tracking
5. Set up proper release signing (when ready for app store)

---

**Ready to proceed? Start with Phase 1!**
