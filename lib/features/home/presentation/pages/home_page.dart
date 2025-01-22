import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/themes.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class HomePage extends GetView<AuthController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).appColors.neutral20,
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat pagi,',
                      style: mediumTS.copyWith(color: Get.theme.appColors.neutral60),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(controller.user?.displayName ?? 'Maos User')} 👋',
                      style: semiboldTS.copyWith(fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        controller.authLoading.value
            ? CustomLoadingButton()
            : CustomButton(
                text: 'Logout',
                onTap: () => controller.logout(),
              )
      ],
    );
  }
}
