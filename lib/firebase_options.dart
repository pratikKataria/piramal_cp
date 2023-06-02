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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAB5-LCGExJAVh1kp9pRCWmVN-tSLrfMDE',
    appId: '1:970701622319:android:fc4b63431393f64a030ada',
    messagingSenderId: '970701622319',
    projectId: 'cp-mobile-app-a7646',
    storageBucket: 'cp-mobile-app-a7646.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9PpNpiNMkyI0nnxnjgboSHLji_2jqnqw',
    appId: '1:970701622319:ios:124e18c9d426b905030ada',
    messagingSenderId: '970701622319',
    projectId: 'cp-mobile-app-a7646',
    storageBucket: 'cp-mobile-app-a7646.appspot.com',
    androidClientId: '970701622319-ju92ln7bb06k9iik45shup2vg9kou3t8.apps.googleusercontent.com',
    iosClientId: '970701622319-n34vboifjjh4ovn8asn7nnd4cps50pml.apps.googleusercontent.com',
    iosBundleId: 'com.stetig.piramalChannelPartner',
  );
}
