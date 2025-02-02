// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBzqt-rlMUNzYuPv_oc5Fp7GNaTx5kJpyg',
    appId: '1:894202944632:web:7c2f16ef743566805aa18d',
    messagingSenderId: '894202944632',
    projectId: 'food-app-69a9c',
    authDomain: 'food-app-69a9c.firebaseapp.com',
    storageBucket: 'food-app-69a9c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3Z3MSnVIA8zNvYzU4kbEqKp1rF_KJwnM',
    appId: '1:894202944632:android:51e76069cef76af75aa18d',
    messagingSenderId: '894202944632',
    projectId: 'food-app-69a9c',
    storageBucket: 'food-app-69a9c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQoJY07IF1SCX9WzxgdHq0SpiGJ7svjFc',
    appId: '1:894202944632:ios:0ca5ad6834767f4a5aa18d',
    messagingSenderId: '894202944632',
    projectId: 'food-app-69a9c',
    storageBucket: 'food-app-69a9c.appspot.com',
    iosBundleId: 'com.example.foodApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQoJY07IF1SCX9WzxgdHq0SpiGJ7svjFc',
    appId: '1:894202944632:ios:0ca5ad6834767f4a5aa18d',
    messagingSenderId: '894202944632',
    projectId: 'food-app-69a9c',
    storageBucket: 'food-app-69a9c.appspot.com',
    iosBundleId: 'com.example.foodApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBzqt-rlMUNzYuPv_oc5Fp7GNaTx5kJpyg',
    appId: '1:894202944632:web:a274ac387d2f8b565aa18d',
    messagingSenderId: '894202944632',
    projectId: 'food-app-69a9c',
    authDomain: 'food-app-69a9c.firebaseapp.com',
    storageBucket: 'food-app-69a9c.appspot.com',
  );
}