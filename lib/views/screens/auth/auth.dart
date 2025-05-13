import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/screens/auth/login.dart';
import 'package:wet_dreams/views/screens/auth/signup.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(flex: 3),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 81 - 156,
                  left: 55 - 120,
                  child: ImageFiltered(
                    // enabled: false,
                    imageFilter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: CustomSvg(asset: AppIcons.curvyShape, size: null),
                  ),
                ),
                Positioned(
                  bottom: 75 - 156,
                  right: 58.5 - 120,
                  child: ImageFiltered(
                    // enabled: false,
                    imageFilter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: CustomSvg(asset: AppIcons.curvyShape, size: null),
                  ),
                ),
                Center(
                  child: CustomSvg(
                    asset: AppIcons.illustration,
                    width: MediaQuery.of(context).size.width - 76,
                  ),
                ),
              ],
            ),
            Spacer(flex: 2),
            Padding(
              padding: EdgeInsets.only(left: 11, right: 11, bottom: 40),
              child: Column(
                children: [
                  Text(
                    "Welcome To Your\nSwimming Dreams",
                    textAlign: TextAlign.center,
                    style: AppTexts.dsmb.copyWith(
                      color: AppColors.blue.shade600,
                    ),
                  ),
                  const SizedBox(height: 28),
                  CustomButton(
                    text: "Login",
                    isSecondary: true,
                    fontSize: 18,
                    onTap: () {
                      Get.to(() => Login());
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: "Create Account",
                    fontSize: 18,
                    onTap: () => Get.to(() => Signup()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
