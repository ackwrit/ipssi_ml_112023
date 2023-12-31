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
    apiKey: 'AIzaSyDyex2Rma2KK_iL9j245sKvhiAnS3skDBc',
    appId: '1:800420039680:web:f2d78218d59b618bc61ce5',
    messagingSenderId: '800420039680',
    projectId: 'mlipssi112023',
    authDomain: 'mlipssi112023.firebaseapp.com',
    storageBucket: 'mlipssi112023.appspot.com',
    measurementId: 'G-CHNY024YD2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDe3La17Bzx2nATB8WGyCKjbX8fi4CTBNE',
    appId: '1:800420039680:android:225d04efb71f7b69c61ce5',
    messagingSenderId: '800420039680',
    projectId: 'mlipssi112023',
    storageBucket: 'mlipssi112023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZ8ucLR5E_JnBYYFfxdQ6Q9f6sg_Lwg_k',
    appId: '1:800420039680:ios:cf292333c5a1be4cc61ce5',
    messagingSenderId: '800420039680',
    projectId: 'mlipssi112023',
    storageBucket: 'mlipssi112023.appspot.com',
    iosBundleId: 'com.example.mlearningIppsi112023',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAZ8ucLR5E_JnBYYFfxdQ6Q9f6sg_Lwg_k',
    appId: '1:800420039680:ios:228a9002c5757b7dc61ce5',
    messagingSenderId: '800420039680',
    projectId: 'mlipssi112023',
    storageBucket: 'mlipssi112023.appspot.com',
    iosBundleId: 'com.example.mlearningIppsi112023.RunnerTests',
  );
}
