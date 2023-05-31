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
    apiKey: 'AIzaSyBLC35i-hWTsQWN9fzWahQwFcNW8fK_Hw4',
    appId: '1:323966944582:web:69462fb90b92b935b85147',
    messagingSenderId: '323966944582',
    projectId: 'upwork-b2267',
    authDomain: 'upwork-b2267.firebaseapp.com',
    storageBucket: 'upwork-b2267.appspot.com',
    measurementId: 'G-0LF2MN72K8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChOUrilZ8EsRalIUEKnjS2Q6IQbA9qpuA',
    appId: '1:323966944582:android:a39afc0626ce4197b85147',
    messagingSenderId: '323966944582',
    projectId: 'upwork-b2267',
    storageBucket: 'upwork-b2267.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAlgulzCv-zVjU2HsRSfdh1m_4GonBf3l4',
    appId: '1:323966944582:ios:bbeb88c217aab99eb85147',
    messagingSenderId: '323966944582',
    projectId: 'upwork-b2267',
    storageBucket: 'upwork-b2267.appspot.com',
    androidClientId:
        '323966944582-a576bf1oudf3jmd1tt6mq42h6afdm1o7.apps.googleusercontent.com',
    iosClientId:
        '323966944582-nmscd96lg04ikt9vd61djgcbmu1fkn30.apps.googleusercontent.com',
    iosBundleId: 'com.example.frontend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAlgulzCv-zVjU2HsRSfdh1m_4GonBf3l4',
    appId: '1:323966944582:ios:bbeb88c217aab99eb85147',
    messagingSenderId: '323966944582',
    projectId: 'upwork-b2267',
    storageBucket: 'upwork-b2267.appspot.com',
    androidClientId:
        '323966944582-a576bf1oudf3jmd1tt6mq42h6afdm1o7.apps.googleusercontent.com',
    iosClientId:
        '323966944582-nmscd96lg04ikt9vd61djgcbmu1fkn30.apps.googleusercontent.com',
    iosBundleId: 'com.example.frontend',
  );
}
