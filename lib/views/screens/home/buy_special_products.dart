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

class BuySpecialProducts extends StatelessWidget {
  const BuySpecialProducts({super.key});

  final List<ClickableButtonModel> data = const [
    ClickableButtonModel(
      title: "pH Measuring Pack",
      subTitle: "drops, strips and pH-",
    ),
    ClickableButtonModel(
      title: "Salt Measuring Pack",
      subTitle: "salt, salt bag",
    ),
    ClickableButtonModel(
      title: "Chlorine Measuring Pack",
      subTitle: "drops, strips and  Chlorine tablets",
    ),
    ClickableButtonModel(
      title: "Green Pool Pack",
      subTitle: "drops, pH-, Fast  Chlorine, Flocculant",
    ),
    ClickableButtonModel(
      title: "Cloudy Pool Pack ",
      subTitle: "drops, pH Flocculant, clarifier",
    ),
    ClickableButtonModel(
      title: "Maintenance Pack",
      subTitle: "fast chlorine, slow  chlorine",
    ),
    ClickableButtonModel(
      title: "pH Raise Pack ",
      subTitle: "drops, alcaplus, pH+",
    ),
    ClickableButtonModel(
      title: "Saline Disinfection Pack",
      subTitle: "chlorinator +  chlorinator course",
    ),
    ClickableButtonModel(
      title: "Energy Saving Pack",
      subTitle: "cartridge, VV  pump, pool tiger",
    ),
    ClickableButtonModel(
      title: "Premium Pool Pack",
      subTitle: "Low salt, VV Pump, Pool Domina Course",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Buy Special Products"),
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
