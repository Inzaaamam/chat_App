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
    apiKey: 'AIzaSyBsp9rb00W7E0Dr42hulNfoULQ7uzFpvm0',
    appId: '1:149111504788:web:b1d0fd0ec97235b9fbd981',
    messagingSenderId: '149111504788',
    projectId: 'chatapp-c4214',
    authDomain: 'chatapp-c4214.firebaseapp.com',
    storageBucket: 'chatapp-c4214.firebasestorage.app',
    measurementId: 'G-VRW5V8KMV4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCG4OrBwIrXoUJUYggHKkSCeZdCdLsqpIk',
    appId: '1:149111504788:android:19b08d923e881388fbd981',
    messagingSenderId: '149111504788',
    projectId: 'chatapp-c4214',
    storageBucket: 'chatapp-c4214.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwzmNsxcKQLDpkMX9n_JJRZ7CneJQzrM4',
    appId: '1:149111504788:ios:f58a5a4290ed399bfbd981',
    messagingSenderId: '149111504788',
    projectId: 'chatapp-c4214',
    storageBucket: 'chatapp-c4214.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAwzmNsxcKQLDpkMX9n_JJRZ7CneJQzrM4',
    appId: '1:149111504788:ios:f58a5a4290ed399bfbd981',
    messagingSenderId: '149111504788',
    projectId: 'chatapp-c4214',
    storageBucket: 'chatapp-c4214.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );
}
