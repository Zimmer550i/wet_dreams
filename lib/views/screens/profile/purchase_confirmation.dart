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
              "Congratulations!",
              style: AppTexts.dxsm.copyWith(color: AppColors.black[50]),
            ),
            const SizedBox(height: 24),
            Text(
              "You have successfully purchased the Package. Now you can enjoy it over offline from my music tab, anytime anywhere.",
              textAlign: TextAlign.center,
              style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: "Back To Pofile",
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
