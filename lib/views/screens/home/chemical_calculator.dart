import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/screens/home/chemical_calculator_analyse.dart';

class ChemicalCalculator extends StatelessWidget {
  const ChemicalCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Chemical Calculator"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 32),
                Row(
                  children: [
                    Text(
                      "PH (7.2-7.5) –",
                      style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: AppColors.black.shade400,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(child: Text("1.1", style: AppTexts.txsr)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "Free Chlorine (1.0 – 3.0 Ppm)",
                      style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: AppColors.black.shade400,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(child: Text("1", style: AppTexts.txsr)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "Alkalinity (100-120ppm)",
                      style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: AppColors.black.shade400,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(child: Text("3", style: AppTexts.txsr)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "Iscocyanuric (CYA) (10-30ppm)",
                      style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: AppColors.black.shade400,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(child: Text("1", style: AppTexts.txsr)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "Calcium Hardness (100-150ppm)",
                      style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: AppColors.black.shade400,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(child: Text("2", style: AppTexts.txsr)),
                    ),
                  ],
                ),
                const SizedBox(height: 62),
                CustomSvg(asset: AppIcons.frame33),
                const SizedBox(height: 50),
                CustomButton(
                  text: "ANALYSE",
                  fontSize: 12,
                  padding: 16,
                  radius: 8,
                  width: null,
                  height: 38,
                  onTap: () => Get.to(()=> ChemicalCalculatorAnalyse()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
