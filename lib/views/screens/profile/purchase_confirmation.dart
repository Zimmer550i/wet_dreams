import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/helpers/route.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/views/base/custom_button.dart';

class PurchaseConfirmation extends StatelessWidget {
  const PurchaseConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Spacer(),
            CustomSvg(asset: "assets/icons/confetti.svg"),
            const SizedBox(height: 24),
            Text(
              "congratulations".tr,
              style: AppTexts.dxsm.copyWith(color: AppColors.black[50]),
            ),
            const SizedBox(height: 24),
            Text(
              "purchase_success_message".tr,
              textAlign: TextAlign.center,
              style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: "back_to_profile".tr,
              width: null,
              onTap:
                  () => Get.until((route) => Get.currentRoute == AppRoutes.app),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
