// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDdXFT2dpi2TSRgzpcpTFX68AepKjiEibI',
    appId: '1:127242797918:web:bf2fcc4790b72721af05cf',
    messagingSenderId: '127242797918',
    projectId: 'helpoo-4f9cf',
    authDomain: 'helpoo-4f9cf.firebaseapp.com',
    storageBucket: 'helpoo-4f9cf.appspot.com',
    measurementId: 'G-EEEHE83KXS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgMm1x2cdcfsRjcGC-YVEP4_BN5ybrjYA',
    appId: '1:127242797918:android:a29c91fcf128c53aaf05cf',
    messagingSenderId: '127242797918',
    projectId: 'helpoo-4f9cf',
    storageBucket: 'helpoo-4f9cf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANhrlzaMLT01sF3-sMiBkPlnxqza2uZ1M',
    appId: '1:127242797918:ios:43e62e183a74cb2faf05cf',
    messagingSenderId: '127242797918',
    projectId: 'helpoo-4f9cf',
    storageBucket: 'helpoo-4f9cf.appspot.com',
    androidClientId:
        '127242797918-7iodjr1mbv74v1u9prkqnhae32ffruoe.apps.googleusercontent.com',
    iosClientId:
        '127242797918-hulp0u3n0tehq2vr3qjllk58730nps1g.apps.googleusercontent.com',
    iosBundleId: 'com.helpoo.app',
  );
}
