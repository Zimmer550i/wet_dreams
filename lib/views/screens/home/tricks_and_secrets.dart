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
import 'package:wet_dreams/views/screens/template/video_link_screen.dart';

class TricksAndSecrets extends StatelessWidget {
  const TricksAndSecrets({super.key});

  final List<ClickableButtonModel> data = const [
    ClickableButtonModel(
      title: "Reduce electricity costs",
      icon: AppIcons.frame11,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "Optimize your salt chlorinator",
      icon: AppIcons.frame13,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "Get clearer water",
      icon: AppIcons.frame14,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "Filter wirelessly and save costs",
      icon: AppIcons.frame16,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
    ClickableButtonModel(
      title: "More efficient start to the season",
      icon: AppIcons.frame18,
      link:
          "https://www.youtube.com/watch?v=oYRw02g706M&pp=ygUNYmFuZ2xhZGVzaCA0aw%3D%3D",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Tricks And Secrets"),
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
          Get.to(() => VideoLinkScreen(e));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: e.subTitle != null ? 0 : 15,
        ),
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
