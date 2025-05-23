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
    apiKey: 'AIzaSyDWk2j1Rn4oUcETsz4USwrb3L0amncuCUA',
    appId: '1:897584323697:web:c7d4cdb8994092c34f4fd0',
    messagingSenderId: '897584323697',
    projectId: 'chat-ca6ec',
    authDomain: 'chat-ca6ec.firebaseapp.com',
    storageBucket: 'chat-ca6ec.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbLXgv1u3gu3luJFmgxcA8xp4eNPwmpfw',
    appId: '1:897584323697:android:4f2b5d86e31cccf84f4fd0',
    messagingSenderId: '897584323697',
    projectId: 'chat-ca6ec',
    storageBucket: 'chat-ca6ec.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0qfncgfE6hkhIXillmgxDoDLvc05jI50',
    appId: '1:897584323697:ios:b24428c04c458e9c4f4fd0',
    messagingSenderId: '897584323697',
    projectId: 'chat-ca6ec',
    storageBucket: 'chat-ca6ec.firebasestorage.app',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB0qfncgfE6hkhIXillmgxDoDLvc05jI50',
    appId: '1:897584323697:ios:b24428c04c458e9c4f4fd0',
    messagingSenderId: '897584323697',
    projectId: 'chat-ca6ec',
    storageBucket: 'chat-ca6ec.firebasestorage.app',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDWk2j1Rn4oUcETsz4USwrb3L0amncuCUA',
    appId: '1:897584323697:web:20a1dee09f99c87d4f4fd0',
    messagingSenderId: '897584323697',
    projectId: 'chat-ca6ec',
    authDomain: 'chat-ca6ec.firebaseapp.com',
    storageBucket: 'chat-ca6ec.firebasestorage.app',
  );
}
