import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/calculator_controller.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_loading.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';
import 'package:wet_dreams/views/screens/home/chemical_calculator_analyse.dart';

class ChemicalCalculator extends StatefulWidget {
  const ChemicalCalculator({super.key});

  @override
  State<ChemicalCalculator> createState() => _ChemicalCalculatorState();
}

class _ChemicalCalculatorState extends State<ChemicalCalculator> {
  final calc = Get.find<CalculatorController>();
  final phCtrl = TextEditingController();
  final chlorineCtrl = TextEditingController();
  final alkalinityCtrl = TextEditingController();
  final cyaCtrl = TextEditingController();
  final calciumHardnessCtrl = TextEditingController();

  bool isLoading = false;

  void callBack() async {
    if (phCtrl.text.trim().isEmpty ||
        chlorineCtrl.text.trim().isEmpty ||
        alkalinityCtrl.text.trim().isEmpty ||
        cyaCtrl.text.trim().isEmpty ||
        calciumHardnessCtrl.text.trim().isEmpty) {
      showSnackBar("Please fill all the fields");
      return;
    }
    final payload = {
      "pH": double.parse(phCtrl.text.trim()),
      "chlorine": double.parse(chlorineCtrl.text.trim()),
      "alkalinity": double.parse(alkalinityCtrl.text.trim()),
      "cya": double.parse(cyaCtrl.text.trim()),
      "calcium_hardness": double.parse(calciumHardnessCtrl.text.trim()),
    };

    final message = await calc.analyzeChemical(payload);

    if (message == "success") {
      Get.to(() => ChemicalCalculatorAnalyse(result: calc.lastResult.value!));
    } else {
      showSnackBar(message);
    }
  }

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
                    CustomTextField(
                      height: 30,
                      width: 70,
                      radius: 4,
                      textInputType: TextInputType.number,
                      controller: phCtrl,
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
                    CustomTextField(
                      height: 30,
                      width: 70,
                      radius: 4,
                      textInputType: TextInputType.number,
                      controller: chlorineCtrl,
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
                    CustomTextField(
                      height: 30,
                      width: 70,
                      radius: 4,
                      textInputType: TextInputType.number,
                      controller: alkalinityCtrl,
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
                    CustomTextField(
                      height: 30,
                      width: 70,
                      radius: 4,
                      textInputType: TextInputType.number,
                      controller: cyaCtrl,
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
                    CustomTextField(
                      height: 30,
                      width: 70,
                      radius: 4,
                      textInputType: TextInputType.number,
                      controller: calciumHardnessCtrl,
                    ),
                  ],
                ),
                const SizedBox(height: 62),
                CustomSvg(asset: AppIcons.frame33),
                const SizedBox(height: 50),
                isLoading
                    ? CustomLoading()
                    : CustomButton(
                      text: "ANALYSE",
                      fontSize: 12,
                      padding: 16,
                      radius: 8,
                      width: null,
                      height: 38,
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });

                        callBack();

                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
