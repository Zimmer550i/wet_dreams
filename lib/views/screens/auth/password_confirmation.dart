import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/screens/auth/login.dart';

class PasswordConfirmation extends StatelessWidget {
  const PasswordConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Spacer(),
              CustomSvg(asset: AppIcons.success),
              const SizedBox(height: 30),
              Text(
                "password_changed".tr,
                style: AppTexts.dsmb.copyWith(color: AppColors.black[50]),
              ),
              const SizedBox(height: 8),
              Text(
                "your_password_has_been_changed_successfully".tr,
                textAlign: TextAlign.center,
                style: AppTexts.tmdr.copyWith(color: AppColors.black[50]),
              ),
              Spacer(),
              CustomButton(
                text: "continue".tr,
                onTap: () => Get.off(() => Login()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
