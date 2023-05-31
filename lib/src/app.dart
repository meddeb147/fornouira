import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        theme: ThemeData(primaryColor: const Color.fromARGB(255, 255, 20, 20)),
        getPages: getPages);
  }
}
