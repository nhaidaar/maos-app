import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/fontstyles.dart';
import '../common/themes.dart';

void showSnackbar({
  required String message,
  bool isError = false,
}) {
  Get.snackbar(
    'title',
    message,
    titleText: const SizedBox.shrink(),
    messageText: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            message,
            style: mediumTS,
          ),
        ),
        const SizedBox(width: 6),
        Icon(
          isError ? Icons.error_rounded : Icons.check_circle_rounded,
          color: isError ? Color(0xffEA4335) : Color(0xff00A47D),
          size: 20,
        ),
      ],
    ),
    borderRadius: 10,
    borderWidth: 1,
    borderColor: Get.theme.appColors.neutral20,
    backgroundColor: Get.theme.scaffoldBackgroundColor,
  );
}
