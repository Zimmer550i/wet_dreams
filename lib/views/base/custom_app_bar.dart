import 'package:flutter/material.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_texts.dart';

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
      titleSpacing: 0,
      title: SizedBox(
        height: 44,
        child: Row(
          children: [
            SizedBox(width: 18),
            hasLeading
                ? SizedBox(width: 20, height: 20)
                : SizedBox(height: 20, width: 20),
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
          color: AppColors.black.shade300),
      ),
    );
  }
}
