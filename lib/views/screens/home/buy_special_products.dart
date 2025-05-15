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
import 'package:wet_dreams/views/screens/template/buy_link_screen.dart';

class BuySpecialProducts extends StatelessWidget {
  const BuySpecialProducts({super.key});

  final List<ClickableButtonModel> data = const [
    ClickableButtonModel(
      title: "pH Measuring Pack",
      subTitle: "(Drops, strips and pH-)",
      icon: AppIcons.frame23,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "Salt Measuring Pack",
      subTitle: "(Salt, salt bag)",
      icon: AppIcons.frame24,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "Chlorine Measuring Pack",
      subTitle: "(Drops, strips and  Chlorine tablets)",
      icon: AppIcons.frame25,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "Green Pool Pack",
      subTitle: "(Drops, pH-, Fast  Chlorine, Flocculant)",
      icon: AppIcons.frame26,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "Cloudy Pool Pack ",
      subTitle: "(Drops, pH Flocculant, clarifier)",
      icon: AppIcons.frame32,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "Maintenance Pack",
      subTitle: "(Fast chlorine, slow  chlorine)",
      icon: AppIcons.frame27,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "pH Raise Pack ",
      subTitle: "(Drops, alcaplus, pH+)",
      icon: AppIcons.frame28,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "Saline Disinfection Pack",
      subTitle: "(Chlorinator +  chlorinator course)",
      icon: AppIcons.frame29,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "Energy Saving Pack",
      subTitle: "(Cartridge, VV  pump, pool tiger)",
      icon: AppIcons.frame30,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "Premium Pool Pack",
      subTitle: "(Low salt, VV Pump, Pool Domina Course)",
      icon: AppIcons.frame31,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
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
        if (e.icon != null) {
          Get.to(() => BuyLinkScreen(e));
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
