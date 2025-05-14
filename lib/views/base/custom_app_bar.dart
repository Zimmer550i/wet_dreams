import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasLeading;
  const CustomAppBar({super.key, required this.title, this.hasLeading = true});

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.black[600],
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: SizedBox(
        height: 44,
        child: Row(
          children: [
            SizedBox(width: 18),
            hasLeading
                ? GestureDetector(
                  onTap: () => Get.back(),
                  behavior: HitTestBehavior.translucent,
                  child: CustomSvg(asset: AppIcons.back),
                )
                : SizedBox(height: 20, width: 20),
            const SizedBox(width: 24),
            Text(
              title,
              style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0.5),
        child: Container(
          height: 0.5,
          width: double.infinity,
          color: AppColors.black.shade300,
        ),
      ),
    );
  }
}
