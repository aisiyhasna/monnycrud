import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions hanya diatur untuk Web saat ini.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBAyPfwFw6Xk8jKYJw68gI5F70dXqowel0",
    authDomain: "praktikum-crud-firebase.firebaseapp.com",
    projectId: "praktikum-crud-firebase",
    storageBucket: "praktikum-crud-firebase.firebasestorage.app",
    messagingSenderId: "998959326657",
    appId: "1:998959326657:web:82d261d90e527e2740bb40",
    measurementId: "G-F4WXHMNVG3",
  );
}