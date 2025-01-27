import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maos/core/common/themes.dart';
import 'package:maos/core/common/widgets/custom_appbar.dart';

import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_textfield.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final authController = AuthController.instance;
  final emailController = TextEditingController();
  bool isEmailEmpty = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(updateEmailState);
  }

  @override
  void dispose() {
    emailController.removeListener(updateEmailState);
    emailController.dispose();
    super.dispose();
  }

  void updateEmailState() {
    setState(() => isEmailEmpty = emailController.text.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Title
                Text(
                  'Forgot Password',
                  style: semiboldTS.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 10),
                Text(
                  'To reset your password, we have to sent link for reset password in to your active email.',
                  style: mediumTS.copyWith(color: Theme.of(context).appColors.neutral60),
                ),

                const SizedBox(height: 28),

                // Email Form
                CustomForm(
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hint: 'Type your email',
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Obx(
              () => authController.authLoading.value
                  ? CustomLoadingButton()
                  : CustomButton(
                      text: 'Done',
                      disabled: isEmailEmpty, // If one of field empty, disable the button
                      onTap: () => authController.resetPassword(email: emailController.text),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
