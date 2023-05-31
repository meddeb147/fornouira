import 'package:get/get.dart';

import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';

final getPages = [
  GetPage(name: '/login', page: () => const LoginScreen()),
  GetPage(name: '/register', page: () => const RegisterScreen()),
];
