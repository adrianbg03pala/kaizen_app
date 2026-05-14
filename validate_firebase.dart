// Firebase Configuration Validator
// Run this after updating firebase_options.dart to verify it matches google-services.json
// Usage: dart validate_firebase.dart

import 'dart:io';
import 'dart:convert';

void main() {
  print('🔍 Firebase Configuration Validator\n');

  // Read google-services.json
  File googleServicesFile = File('android/app/google-services.json');
  if (!googleServicesFile.existsSync()) {
    print('❌ google-services.json not found at android/app/google-services.json');
    return;
  }

  try {
    String googleServicesContent = googleServicesFile.readAsStringSync();
    Map<String, dynamic> googleServices = jsonDecode(googleServicesContent);

    String projectId = googleServices['project_info']['project_id'];
    String projectNumber = googleServices['project_info']['project_number'].toString();
    String apiKey = googleServices['client'][0]['api_key'][0]['current_key'];
    String appId = googleServices['client'][0]['client_info']['mobilesdk_app_id'];

    print('📋 Values from google-services.json:');
    print('   Project ID: $projectId');
    print('   Project Number: $projectNumber');
    print('   API Key: ${apiKey.substring(0, 20)}...');
    print('   App ID: $appId\n');

    // Check if it's the real project
    if (projectId == 'kaizen-tfg-real') {
      print('✅ Using REAL Firebase project (kaizen-tfg-real)');
    } else if (projectId == 'kaizen-tfg') {
      print('⚠️  WARNING: Still using DUMMY Firebase project (kaizen-tfg)');
      print('   Update google-services.json from kaizen-tfg-real\n');
    }

    // Recommendations
    print('\n📝 Next steps:');
    print('1. Update lib/firebase_options.dart with these values:');
    print('   - apiKey: "$apiKey"');
    print('   - appId: "$appId"');
    print('   - projectId: "$projectId"');
    print('\n2. Run: flutter clean && flutter pub get');
    print('3. Run: flutter run');
    print('\n4. Test Google Sign-In on your device');

  } catch (e) {
    print('❌ Error reading google-services.json: $e');
  }
}
