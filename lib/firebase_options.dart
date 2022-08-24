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
    apiKey: 'AIzaSyDpyT3jASbQ8asspifnp3j_lWnCL_qpeKs',
    appId: '1:991883845658:web:6ee504bfe059d5680c71a3',
    messagingSenderId: '991883845658',
    projectId: 'bloc-photo-library-two',
    authDomain: 'bloc-photo-library-two.firebaseapp.com',
    storageBucket: 'bloc-photo-library-two.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBC-xROAAKKr8dJ9X7puPQYc1GBu-CvcWQ',
    appId: '1:991883845658:android:57d0b9e7ac55cbd60c71a3',
    messagingSenderId: '991883845658',
    projectId: 'bloc-photo-library-two',
    storageBucket: 'bloc-photo-library-two.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHbLZLh2FQhogJUetDCjQJ42Eewg1KD0s',
    appId: '1:991883845658:ios:2362fa9d20ffa5440c71a3',
    messagingSenderId: '991883845658',
    projectId: 'bloc-photo-library-two',
    storageBucket: 'bloc-photo-library-two.appspot.com',
    iosClientId: '991883845658-l6qqlecik1qg7f58o6aqill979dq222i.apps.googleusercontent.com',
    iosBundleId: 'com.example.blocTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHbLZLh2FQhogJUetDCjQJ42Eewg1KD0s',
    appId: '1:991883845658:ios:2362fa9d20ffa5440c71a3',
    messagingSenderId: '991883845658',
    projectId: 'bloc-photo-library-two',
    storageBucket: 'bloc-photo-library-two.appspot.com',
    iosClientId: '991883845658-l6qqlecik1qg7f58o6aqill979dq222i.apps.googleusercontent.com',
    iosBundleId: 'com.example.blocTest',
  );
}
