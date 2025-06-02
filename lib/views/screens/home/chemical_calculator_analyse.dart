import 'package:flutter/material.dart';
import 'package:wet_dreams/models/chemical_result.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/formatter.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';

class ChemicalCalculatorAnalyse extends StatelessWidget {
  final ChemicalResult result;
  const ChemicalCalculatorAnalyse({super.key, required this.result});

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
                const SizedBox(height: 24),
                poolInformation(result.createdAt, [
                  result.inputValues.pH,
                  result.inputValues.chlorine,
                  result.inputValues.alkalinity,
                  result.inputValues.cya,
                ]),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.black.shade400,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    spacing: 12,
                    children: [
                      // Text(result.resultSummary, style: AppTexts.tsmr),
                      for (var i in result.adjustments.entries)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              i.key
                                  .split("_")
                                  .map(
                                    (e) => e[0].toUpperCase() + e.substring(1),
                                  )
                                  .join(" "),
                              style: AppTexts.tsmr.copyWith(
                                color: AppColors.black[50],
                              ),
                            ),
                            Text(i.value.toString(), style: AppTexts.tsmr),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget poolInformation(DateTime date, List<String> values) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.black.shade400,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Formatter.dateFormatter(date),
                    style: AppTexts.txsr.copyWith(color: AppColors.black[50]),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "PH: ${values.isNotEmpty ? values[0] : "XX"}",
                        style: AppTexts.txsr.copyWith(
                          color: AppColors.black[200],
                        ),
                      ),
                      Text(
                        "Cl: ${values.length > 1 ? values[1] : "XX"}",
                        style: AppTexts.txsr.copyWith(
                          color: AppColors.black[200],
                        ),
                      ),
                      Text(
                        "Alc: ${values.length > 2 ? values[2] : "XX"}",
                        style: AppTexts.txsr.copyWith(
                          color: AppColors.black[200],
                        ),
                      ),
                      Text(
                        "CYA: ${values.length > 3 ? values[3] : "XX"}",
                        style: AppTexts.txsr.copyWith(
                          color: AppColors.black[200],
                        ),
                      ),
                      SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 40),
          ],
        ),
      ),
    );
  }
}
