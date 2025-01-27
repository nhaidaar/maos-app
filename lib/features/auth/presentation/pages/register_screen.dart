import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/themes.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_textfield.dart';
import '../../../../core/utils/snackbar.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  final AuthController authController;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool registerFieldsEmpty;
  const RegisterScreen({
    super.key,
    required this.authController,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.registerFieldsEmpty,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          // Name Form
          CustomForm(
            label: 'Name',
            controller: widget.nameController,
            keyboardType: TextInputType.name,
            hint: 'Type your name',
          ),

          const SizedBox(height: 20),

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

          const SizedBox(height: 24),

          Obx(
            () => widget.authController.authLoading.value
                ? CustomLoadingButton()
                : CustomButton(
                    text: 'Register',
                    disabled: widget.registerFieldsEmpty, // If one of field empty, disable the button
                    onTap: () => widget.authController.register(
                      name: widget.nameController.text,
                      email: widget.emailController.text,
                      password: widget.passwordController.text,
                    ),
                  ),
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Divider(height: 1, color: Theme.of(context).appColors.neutral10)),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Text('or', style: mediumTS.copyWith(color: Theme.of(context).appColors.neutral10)),
              ),
              Expanded(child: Divider(height: 1, color: Theme.of(context).appColors.neutral10)),
            ],
          ),
          const SizedBox(height: 12),

          CustomButton(
            icon: ImageIcon(AssetImage('assets/images/icon_google.png')),
            text: 'Register with Google',
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
