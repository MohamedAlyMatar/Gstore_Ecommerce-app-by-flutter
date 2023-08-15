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
    apiKey: 'AIzaSyD_Idlg41TfNFUVtInlNfsny_0OYDDLc6I',
    appId: '1:512524632339:web:a058320b01e552d2549ae6',
    messagingSenderId: '512524632339',
    projectId: 'g-store-8caf4',
    authDomain: 'g-store-8caf4.firebaseapp.com',
    storageBucket: 'g-store-8caf4.appspot.com',
    measurementId: 'G-DQMHHKLZ43',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZkLwbLoGQNGN0A_4lmDzPyZXcukA_GPw',
    appId: '1:512524632339:android:9812087ad437c7e5549ae6',
    messagingSenderId: '512524632339',
    projectId: 'g-store-8caf4',
    storageBucket: 'g-store-8caf4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDs9xKQTF0gi1mf6Ym28H6YYdSUlB-3hFs',
    appId: '1:512524632339:ios:92397f7a183c0aee549ae6',
    messagingSenderId: '512524632339',
    projectId: 'g-store-8caf4',
    storageBucket: 'g-store-8caf4.appspot.com',
    iosClientId: '512524632339-e8a80ivgh30pojj5ru77r02echt9n9kk.apps.googleusercontent.com',
    iosBundleId: 'com.example.gstore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDs9xKQTF0gi1mf6Ym28H6YYdSUlB-3hFs',
    appId: '1:512524632339:ios:395185ab1681a620549ae6',
    messagingSenderId: '512524632339',
    projectId: 'g-store-8caf4',
    storageBucket: 'g-store-8caf4.appspot.com',
    iosClientId: '512524632339-gvsm9vlu7dttaaclti8tp9q6tjv950vo.apps.googleusercontent.com',
    iosBundleId: 'com.example.gstore.RunnerTests',
  );
}