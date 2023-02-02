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
    apiKey: 'AIzaSyDDAhbOBZO7XtU_zxt2nrh0DVXrrX_pOz0',
    appId: '1:158756326159:web:7ce8bff9e3f784da150c7a',
    messagingSenderId: '158756326159',
    projectId: 'todolist-986af',
    authDomain: 'todolist-986af.firebaseapp.com',
    storageBucket: 'todolist-986af.appspot.com',
    measurementId: 'G-WWS88RPWHF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJ4IYPIZGf3Vi7_JJqe9i_U_8VGqP9LH0',
    appId: '1:158756326159:android:395a39248dc42a1f150c7a',
    messagingSenderId: '158756326159',
    projectId: 'todolist-986af',
    storageBucket: 'todolist-986af.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFIvgsg_VUKPFqiw2P6JtIlNa8ht1c2bw',
    appId: '1:158756326159:ios:6a16f8f171b8a106150c7a',
    messagingSenderId: '158756326159',
    projectId: 'todolist-986af',
    storageBucket: 'todolist-986af.appspot.com',
    androidClientId: '158756326159-oilqo9j4mnfu0ch6dsm71qvc6br8il4g.apps.googleusercontent.com',
    iosClientId: '158756326159-be4662e4f6rrq6n7e2j0cg8o6l6b6vkt.apps.googleusercontent.com',
    iosBundleId: 'com.example.todolist',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAFIvgsg_VUKPFqiw2P6JtIlNa8ht1c2bw',
    appId: '1:158756326159:ios:6a16f8f171b8a106150c7a',
    messagingSenderId: '158756326159',
    projectId: 'todolist-986af',
    storageBucket: 'todolist-986af.appspot.com',
    androidClientId: '158756326159-oilqo9j4mnfu0ch6dsm71qvc6br8il4g.apps.googleusercontent.com',
    iosClientId: '158756326159-be4662e4f6rrq6n7e2j0cg8o6l6b6vkt.apps.googleusercontent.com',
    iosBundleId: 'com.example.todolist',
  );
}
