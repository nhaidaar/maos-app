import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/themes.dart';
import '../controllers/auth_controller.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final authController = Get.find<AuthController>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loginFieldsEmpty = true;
  bool registerFieldsEmpty = true;

  @override
  void initState() {
    super.initState();
    nameController.addListener(updateFieldState);
    emailController.addListener(updateFieldState);
    passwordController.addListener(updateFieldState);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void updateFieldState() {
    setState(() {
      loginFieldsEmpty = emailController.text.isEmpty || passwordController.text.isEmpty;
      registerFieldsEmpty =
          emailController.text.isEmpty || passwordController.text.isEmpty || nameController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Logo
                        Image.asset(
                          Theme.of(context).brightness == Brightness.light
                              ? 'assets/images/logo_light.png'
                              : 'assets/images/logo_dark.png',
                          scale: 6,
                        ),

                        const Spacer(),

                        // Skip Auth Button
                        Obx(
                          () => authController.guestAuthLoading.value
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : GestureDetector(
                                  onTap: () => authController.loginAsGuest(),
                                  child: Text('Skip', style: mediumTS),
                                ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Title
                    Text(
                      'Hi, Welcome Back!',
                      style: semiboldTS.copyWith(fontSize: 32),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'We\'re happy to see you again!, please login or register to continue your reading.',
                      style: mediumTS.copyWith(color: Theme.of(context).appColors.neutral60),
                    ),

                    const SizedBox(height: 24),

                    // Buat Akun dan Masuk (Tab Bar)
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Theme.of(context).appColors.neutral10),
                      ),
                      child: TabBar(
                        labelStyle: semiboldTS.copyWith(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary),
                        unselectedLabelStyle: semiboldTS.copyWith(fontSize: 16),
                        indicator: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        splashBorderRadius: BorderRadius.circular(100),
                        dividerHeight: 0,
                        tabs: const [
                          Tab(text: 'Login'),
                          Tab(text: 'Register'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    LoginScreen(
                      authController: authController,
                      emailController: emailController,
                      passwordController: passwordController,
                      loginFieldsEmpty: loginFieldsEmpty,
                    ),
                    RegisterScreen(
                      authController: authController,
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      registerFieldsEmpty: registerFieldsEmpty,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
