import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      // ✅ Web config — replace with your Firebase Web settings
      return FirebaseOptions(
        apiKey: "AIzaSyDzKPoXiEo2TCFWA_AliSLV8A9m1JuroWI",
        authDomain: "authapp-22a67.firebaseapp.com",
        projectId: "authapp-22a67",
        storageBucket: "authapp-22a67.firebasestorage.app",
        messagingSenderId: "243404930581",
        appId: "1:243404930581:web:c014e4c0840f43402c581c",
      );
    } else {
      // ✅ Android config — replace with your Android settings from google-services.json
      return FirebaseOptions(
        apiKey: "AIzaSyA1HrVnG0vBgH8RUtZibpTnnYjdSOjEyQE",
        appId: "1:243404930581:android:5c5c5c5c5c5c5c5c",
        messagingSenderId: "243404930581",
        projectId: "authapp-22a67",
        storageBucket: "authapp-22a67.appspot.com",
      );
    }
  }
}
