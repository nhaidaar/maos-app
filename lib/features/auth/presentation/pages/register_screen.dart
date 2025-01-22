import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/themes.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_textfield.dart';
import '../../../../core/utils/snackbar.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _authController = AuthController.instance;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _areFieldsEmpty = true;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(updateFieldState);
    _emailController.addListener(updateFieldState);
    _passwordController.addListener(updateFieldState);
  }

  @override
  void dispose() {
    _nameController.removeListener(updateFieldState);
    _emailController.removeListener(updateFieldState);
    _passwordController.removeListener(updateFieldState);
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void updateFieldState() {
    setState(() => _areFieldsEmpty =
        _emailController.text.isEmpty || _passwordController.text.isEmpty || _nameController.text.isEmpty);
  }

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
            controller: _nameController,
            keyboardType: TextInputType.name,
            hint: 'Type your name',
          ),

          const SizedBox(height: 20),

          // Email Form
          CustomForm(
            label: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hint: 'Type your email',
          ),

          const SizedBox(height: 20),

          // Password Form
          CustomForm(
            label: 'Password',
            controller: _passwordController,
            isPassword: true,
            hint: 'Type your password',
          ),

          const SizedBox(height: 24),

          Obx(
            () => _authController.authLoading.value
                ? CustomLoadingButton()
                : CustomButton(
                    text: 'Register',
                    disabled: _areFieldsEmpty, // If one of field empty, disable the button
                    onTap: () => _authController.register(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
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
