# Firebase Options Update Template

## How to Update `lib/firebase_options.dart`

Once you have the real `google-services.json`, follow this mapping to update `firebase_options.dart`.

---

## Step 1: Open Your google-services.json

Find and open: `android/app/google-services.json`

---

## Step 2: Find These Values

Look for these sections in your JSON file:

```json
{
  "project_info": {
    "project_id": "← FIND THIS",
    "project_number": "← FIND THIS"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "← FIND THIS"
      },
      "api_key": [
        {
          "current_key": "← FIND THIS"
        }
      ]
    }
  ]
}
```

---

## Step 3: Mapping to firebase_options.dart

Here's where each value goes:

| JSON Field | → | firebase_options.dart |
|---|---|---|
| `project_info.project_id` | → | `projectId: 'VALUE'` |
| `project_info.project_number` | → | `messagingSenderId: 'VALUE'` |
| `client[0].api_key[0].current_key` | → | `apiKey: 'VALUE'` |
| `client[0].client_info.mobilesdk_app_id` | → | `appId: 'VALUE'` |

---

## Step 4: Update the File

Edit `lib/firebase_options.dart` and update the Android section:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'PASTE_API_KEY_HERE',           // From: api_key[0].current_key
  appId: 'PASTE_APP_ID_HERE',             // From: mobilesdk_app_id
  messagingSenderId: 'PASTE_MSG_ID_HERE', // From: project_number
  projectId: 'PASTE_PROJECT_ID_HERE',     // From: project_id
);
```

---

## Example (Dummy Values)

### Your google-services.json will look like:
```json
{
  "project_info": {
    "project_number": "632432076709",
    "project_id": "kaizen-tfg-real",
    ...
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "1:632432076709:android:40f1768e6fbe01cbceaa4c",
        ...
      },
      "api_key": [
        {
          "current_key": "AIzaSyC-73XgMgC3sg3wak1Cs4p08IypINVvLxU"
        }
      ],
      ...
    }
  ],
  ...
}
```

### Update your `firebase_options.dart` to:
```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyC-73XgMgC3sg3wak1Cs4p08IypINVvLxU',
  appId: '1:632432076709:android:40f1768e6fbe01cbceaa4c',
  messagingSenderId: '632432076709',
  projectId: 'kaizen-tfg-real',
);
```

---

## Validation Checklist

After updating, verify:

- [ ] `projectId` contains **kaizen-tfg-real** (not kaizen-tfg)
- [ ] `apiKey` starts with **AIzaSy...**
- [ ] `appId` contains **android:** in the middle
- [ ] `messagingSenderId` is all numbers

---

## Automated Option

After updating google-services.json, run:

```bash
dart validate_firebase.dart
```

This will extract values and show what you need to update.

---

## Need Help?

If you're unsure about the format:

1. Look at the example above
2. Compare your google-services.json structure
3. Copy values exactly (including quotes and colons)
4. Run `validate_firebase.dart` to verify

---

**Note:** These are public Firebase configuration values, not secrets. Safe to commit to GitHub.
