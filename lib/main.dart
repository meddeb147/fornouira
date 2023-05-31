import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'src/app.dart';
import 'src/services/recaptcha.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Add Firebase Initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Only for web
  if (kIsWeb) {
    final recaptchaService = RecaptchaService();
    final recaptcha = await recaptchaService.init();
    print('recaptcha $recaptcha');
  }

  runApp(const App());
}
