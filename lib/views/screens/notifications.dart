import 'package:flutter/material.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notifications"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 24),
                for (int i = 0; i < 20; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      spacing: 12,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.black.shade400,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: CustomSvg(asset: AppIcons.bellBig),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "If water is cold, consider supplementing with liquid chlorine.",
                            style: AppTexts.txsr.copyWith(
                              color: AppColors.black[50],
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            
                          },
                          icon: CustomSvg(asset: AppIcons.threeDot),
                          menuPadding: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                          color: AppColors.black.shade400,
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: Text("Delete", style: AppTexts.tsmm),
                              ),
                            ];
                          },
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
}
