import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/common/themes.dart';
import 'features/auth/presentation/controllers/auth_binding.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/auth/presentation/pages/forgot_password_page.dart';
import 'features/home/presentation/pages/main_screen.dart';
import 'features/home/presentation/pages/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Maos());
}

class Maos extends StatelessWidget {
  const Maos({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'maos',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: AuthBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const AuthPage(), transition: Transition.fade),
        GetPage(name: '/forgot-password', page: () => const ForgotPasswordPage()),
        GetPage(name: '/home', page: () => const MainScreen()),
      ],
      defaultTransition: Transition.rightToLeft,
      transitionDuration: Durations.short3,
    );
  }
}
