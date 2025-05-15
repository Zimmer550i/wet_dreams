import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:wet_dreams/models/clickable_button_model.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/formatter.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';

class PeriodicMaintenance extends StatelessWidget {
  const PeriodicMaintenance({super.key});

  final List<ClickableButtonModel> data = const [
    ClickableButtonModel(title: "FQL Method for a Perfect Pool"),
    ClickableButtonModel(title: "The 3 Chemical parameters to control"),
    ClickableButtonModel(title: "When to Wash the Filter"),
    ClickableButtonModel(title: "How Many Hours to Filter"),
    ClickableButtonModel(title: "I have the Green Pool"),
    ClickableButtonModel(title: "I have a cloudy pool"),
    ClickableButtonModel(title: "I have algae in the pool"),
    ClickableButtonModel(title: "How to Raise pH"),
    ClickableButtonModel(title: "How to lower pH"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Periodic Maintenance"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),
              ...data.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    left: 24,
                    right: 24,
                  ),
                  child: tabButton(e),
                );
              }),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blue),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Master Your Pool Course",
                        style: AppTexts.txsr.copyWith(color: AppColors.blue),
                      ),
                      const SizedBox(width: 4),
                      Transform.rotate(
                        angle: 2.3,
                        child: CustomSvg(
                          asset: AppIcons.back,
                          color: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabButton(ClickableButtonModel e) {
    return GestureDetector(
      onTap: () {
        if (e.route != null) {
          Get.to(() => e.route!);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      Formatter.toTitleCase(e.title!),
                      style: AppTexts.tsms.copyWith(
                        color: AppColors.blue.shade900,
                      ),
                    ),
                  ),
                  if (e.subTitle != null)
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        Formatter.toTitleCase(e.subTitle!),
                        style: AppTexts.txsr.copyWith(
                          color: AppColors.blue.shade900,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            CustomSvg(asset: AppIcons.arrowRightSmall),
          ],
        ),
      ),
    );
  }
}
