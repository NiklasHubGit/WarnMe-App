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
    apiKey: 'AIzaSyDEi0l0wIs_5keJD-hCqhEHyNONvP2XEi0',
    appId: '1:25704674519:web:a4d58f2c24dd89598f2c92',
    messagingSenderId: '25704674519',
    projectId: 'hochwasserwarnapp',
    authDomain: 'hochwasserwarnapp.firebaseapp.com',
    storageBucket: 'hochwasserwarnapp.appspot.com',
    measurementId: 'G-N8W3G2XCP2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZSI12dqE0_jzTUns8AppdnZQK-8_fn0M',
    appId: '1:25704674519:android:1a4699e74784cea78f2c92',
    messagingSenderId: '25704674519',
    projectId: 'hochwasserwarnapp',
    storageBucket: 'hochwasserwarnapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBn6dtrUcapEiN7V9-D73D_17AnArpWF7o',
    appId: '1:25704674519:ios:53b3d88a686ae5ac8f2c92',
    messagingSenderId: '25704674519',
    projectId: 'hochwasserwarnapp',
    storageBucket: 'hochwasserwarnapp.appspot.com',
    androidClientId: '25704674519-444ii2ce3ef4ank1f39va36mmshqcsrn.apps.googleusercontent.com',
    iosBundleId: 'com.example.warnapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBn6dtrUcapEiN7V9-D73D_17AnArpWF7o',
    appId: '1:25704674519:ios:622a8750ec6ce85b8f2c92',
    messagingSenderId: '25704674519',
    projectId: 'hochwasserwarnapp',
    storageBucket: 'hochwasserwarnapp.appspot.com',
    androidClientId: '25704674519-444ii2ce3ef4ank1f39va36mmshqcsrn.apps.googleusercontent.com',
    iosBundleId: 'com.example.warnapp.RunnerTests',
  );
}