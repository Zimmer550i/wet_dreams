import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int index;
  final Function(int)? onChanged;
  const CustomBottomNavbar({super.key, required this.index, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xff333333))),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 16,
            color: Colors.black.withAlpha(27),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            item("home".tr, AppIcons.home, 0),
            item("my_pool".tr, AppIcons.pool, 1),
            item("settings".tr, AppIcons.settings, 2),
          ],
        ),
      ),
    );
  }

  Widget item(String name, String icon, int pos) {
    bool isSelected = pos == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (onChanged != null) onChanged!(pos);
        },
        behavior: HitTestBehavior.translucent,
        child: Column(
          children: [
            CustomSvg(
              asset: icon,
              size: 24,
              color: isSelected ? AppColors.blue : AppColors.black.shade100,
            ),
            const SizedBox(height: 5),
            Text(
              name,
              style: AppTexts.tsmm.copyWith(
                color: isSelected ? AppColors.blue : AppColors.black.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
