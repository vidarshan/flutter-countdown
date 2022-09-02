// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCswKBaLrRCJ5GdHRWMPBry7MvfUAoZTLo',
    appId: '1:932490909760:web:b07fcc628f49cdfe45a7a5',
    messagingSenderId: '932490909760',
    projectId: 'todos-f82f8',
    authDomain: 'todos-f82f8.firebaseapp.com',
    storageBucket: 'todos-f82f8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZqjckVXmF1dIXUtwhj_al1J4r5CjaDng',
    appId: '1:932490909760:android:f9a94ea3fa453e8245a7a5',
    messagingSenderId: '932490909760',
    projectId: 'todos-f82f8',
    storageBucket: 'todos-f82f8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGfin3Dcvr-KqFV4xHTgFZid2svuLZLds',
    appId: '1:932490909760:ios:4dd5e9bdf2b9847145a7a5',
    messagingSenderId: '932490909760',
    projectId: 'todos-f82f8',
    storageBucket: 'todos-f82f8.appspot.com',
    iosClientId: '932490909760-vc9r58arb8811d76s05hpbgc19j6s7bp.apps.googleusercontent.com',
    iosBundleId: 'com.example.toDos',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBGfin3Dcvr-KqFV4xHTgFZid2svuLZLds',
    appId: '1:932490909760:ios:4dd5e9bdf2b9847145a7a5',
    messagingSenderId: '932490909760',
    projectId: 'todos-f82f8',
    storageBucket: 'todos-f82f8.appspot.com',
    iosClientId: '932490909760-vc9r58arb8811d76s05hpbgc19j6s7bp.apps.googleusercontent.com',
    iosBundleId: 'com.example.toDos',
  );
}
