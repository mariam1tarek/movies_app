
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDfnIUhSU5JubiuKoa_Mn-NgiRPhgGopcM',
    appId: '1:430547554492:web:7d455de7880e599f7c80b9',
    messagingSenderId: '430547554492',
    projectId: 'movies-app-a3967',
    authDomain: 'movies-app-a3967.firebaseapp.com',
    storageBucket: 'movies-app-a3967.firebasestorage.app',
    measurementId: 'G-M4F3JYE9Y7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgfrcHXqXkbMIK9TxOnEiQ_tn9pn5LTsE',
    appId: '1:430547554492:android:2d080a1a4ed4d8847c80b9',
    messagingSenderId: '430547554492',
    projectId: 'movies-app-a3967',
    storageBucket: 'movies-app-a3967.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_AypXNKZNEkpZIaNXi1AE8DpVnfzyL44',
    appId: '1:430547554492:ios:a3de03533f3e68167c80b9',
    messagingSenderId: '430547554492',
    projectId: 'movies-app-a3967',
    storageBucket: 'movies-app-a3967.firebasestorage.app',
    androidClientId: '430547554492-s7vv5cv99j01iqs4p8mu2bua37tjg01r.apps.googleusercontent.com',
    iosClientId: '430547554492-14h80aub0ahn7fj973jbj498sp40hc1j.apps.googleusercontent.com',
    iosBundleId: 'com.example.moviesApp',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB_AypXNKZNEkpZIaNXi1AE8DpVnfzyL44',
    appId: '1:430547554492:ios:a3de03533f3e68167c80b9',
    messagingSenderId: '430547554492',
    projectId: 'movies-app-a3967',
    storageBucket: 'movies-app-a3967.firebasestorage.app',
    androidClientId: '430547554492-s7vv5cv99j01iqs4p8mu2bua37tjg01r.apps.googleusercontent.com',
    iosClientId: '430547554492-14h80aub0ahn7fj973jbj498sp40hc1j.apps.googleusercontent.com',
    iosBundleId: 'com.example.moviesApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDfnIUhSU5JubiuKoa_Mn-NgiRPhgGopcM',
    appId: '1:430547554492:web:f1d4ce1636b1421c7c80b9',
    messagingSenderId: '430547554492',
    projectId: 'movies-app-a3967',
    authDomain: 'movies-app-a3967.firebaseapp.com',
    storageBucket: 'movies-app-a3967.firebasestorage.app',
    measurementId: 'G-6HPMQMZDHJ',
  );
}
