import 'package:flutter/material.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/formatter.dart';

class Pool extends StatelessWidget {
  const Pool({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 36),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Volume (M3) WET App 00",
                      style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                    ),
                    Text(
                      "(1m3 = 1000 Liters)",
                      style: AppTexts.txsr.copyWith(
                        color: AppColors.black[200],
                      ),
                    ),
                  ],
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
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "Salt Chlorinator:",
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
                  child: Center(child: Text("But", style: AppTexts.txsr)),
                ),
              ],
            ),
            const SizedBox(height: 50),
            for (int i = 0; i < 3; i++)
              poolInformation(DateTime.now(), [1.1, 1, 3, 1]),
          ],
        ),
      ),
    );
  }

  Widget poolInformation(DateTime date, List<double> values) {
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
            GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.translucent,
              child: Icon(
                Icons.close_rounded,
                size: 12,
                color: AppColors.black[50]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
