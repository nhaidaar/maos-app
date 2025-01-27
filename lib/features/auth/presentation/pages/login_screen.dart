import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/themes.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_textfield.dart';
import '../../../../core/utils/snackbar.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  final AuthController authController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool loginFieldsEmpty;
  const LoginScreen({
    super.key,
    required this.authController,
    required this.emailController,
    required this.passwordController,
    required this.loginFieldsEmpty,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          // Email Form
          CustomForm(
            label: 'Email',
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            hint: 'Type your email',
          ),

          const SizedBox(height: 20),

          // Password Form
          CustomForm(
            label: 'Password',
            controller: widget.passwordController,
            isPassword: true,
            hint: 'Type your password',
          ),

          const SizedBox(height: 12),

          // Forgot Password Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Get.toNamed('/forgot-password'),
                child: Text('Forgot Password?', style: mediumTS),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Obx(
            () => widget.authController.authLoading.value
                ? CustomLoadingButton()
                : CustomButton(
                    text: 'Login',
                    disabled: widget.loginFieldsEmpty, // If one of field empty, disable the button
                    onTap: () => widget.authController.login(
                      email: widget.emailController.text,
                      password: widget.passwordController.text,
                    ),
                  ),
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Divider(height: 1, color: Theme.of(context).appColors.neutral20)),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Text('or', style: mediumTS.copyWith(color: Theme.of(context).appColors.neutral20)),
              ),
              Expanded(child: Divider(height: 1, color: Theme.of(context).appColors.neutral20)),
            ],
          ),
          const SizedBox(height: 12),

          CustomButton(
            icon: ImageIcon(AssetImage('assets/images/icon_google.png')),
            text: 'Login with Google',
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            borderColor: Theme.of(context).appColors.neutral10,
            textColor: Theme.of(context).appColors.neutral100,
            onTap: () => showSnackbar(message: 'Coming soon!'),
          ),
        ],
      ),
    );
  }
}
