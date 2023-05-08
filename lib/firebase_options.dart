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
    apiKey: 'AIzaSyCYRwkH0J4YxXgKZu2zJBmb_Pr8fqP0x3I',
    appId: '1:659681102105:web:7a2afbfad27bf6735ddd88',
    messagingSenderId: '659681102105',
    projectId: 'socialapp-c6419',
    authDomain: 'socialapp-c6419.firebaseapp.com',
    storageBucket: 'socialapp-c6419.appspot.com',
    measurementId: 'G-JWDDH52Y0G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAqLdSL_-BlrMJQF9x-2rY5Z09GE3jW2EE',
    appId: '1:659681102105:android:3f808e53db22e13c5ddd88',
    messagingSenderId: '659681102105',
    projectId: 'socialapp-c6419',
    storageBucket: 'socialapp-c6419.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyLduXs1doMpu7TWj1yMNwWVu-orUr0Jk',
    appId: '1:659681102105:ios:d4e862e666afdd8e5ddd88',
    messagingSenderId: '659681102105',
    projectId: 'socialapp-c6419',
    storageBucket: 'socialapp-c6419.appspot.com',
    androidClientId: '659681102105-grolmesremmpd6ms6ph1mv009q2g0e0a.apps.googleusercontent.com',
    iosClientId: '659681102105-e16eag30jpbli0c2m5qr9d1k7om5omvs.apps.googleusercontent.com',
    iosBundleId: 'com.example.toDoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCyLduXs1doMpu7TWj1yMNwWVu-orUr0Jk',
    appId: '1:659681102105:ios:d4e862e666afdd8e5ddd88',
    messagingSenderId: '659681102105',
    projectId: 'socialapp-c6419',
    storageBucket: 'socialapp-c6419.appspot.com',
    androidClientId: '659681102105-grolmesremmpd6ms6ph1mv009q2g0e0a.apps.googleusercontent.com',
    iosClientId: '659681102105-e16eag30jpbli0c2m5qr9d1k7om5omvs.apps.googleusercontent.com',
    iosBundleId: 'com.example.toDoApp',
  );
}