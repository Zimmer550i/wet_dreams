import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/screens/profile/card_details.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Payment Method"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Select the payment method you want to use.",
                style: AppTexts.tlgm.copyWith(color: AppColors.black[50]),
              ),
              const SizedBox(height: 20),
              CustomSvg(asset: AppIcons.card),
              Spacer(),
              CustomButton(
                text: "Make Payment",
                onTap: () => Get.to(() => CardDetails()),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
