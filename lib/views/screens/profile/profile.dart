import 'package:wet_dreams/controllers/auth_controller.dart';
import 'package:wet_dreams/controllers/user_controller.dart';
import 'package:wet_dreams/models/clickable_button_model.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/views/screens/profile/change_password.dart';
import 'package:wet_dreams/views/screens/profile/privacy_policy.dart';
import 'package:wet_dreams/views/screens/profile/profile_information.dart';
import 'package:wet_dreams/views/screens/profile/subscription.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = Get.find<UserController>();

  final List<ClickableButtonModel> data = [
    ClickableButtonModel(
      icon: AppIcons.userCircle,
      title: "profile_information".tr,
      route: ProfileInformation(),
    ),
    ClickableButtonModel(
      icon: AppIcons.crown,
      title: "subscription".tr,
      route: Subscription(),
    ),
    ClickableButtonModel(
      icon: AppIcons.lock,
      title: "change_password".tr,
      route: ChangePassword(),
    ),
    ClickableButtonModel(
      icon: AppIcons.privacy,
      title: "privacy_policy".tr,
      route: PrivacyPolicy(),
    ),
    ClickableButtonModel(icon: AppIcons.logout, title: "log_out".tr),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 44),
                Center(
                  child: Obx(
                    () => ProfilePicture(image: user.getImageUrl(), size: 120),
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => Text(
                      user.userInfo.value!.fullName,
                      style: AppTexts.txls.copyWith(color: AppColors.black[50]),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.black.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < data.length; i++)
                        profileOptions(
                          iconPath: data[i].icon!,
                          title: data[i].title!,
                          isLast: i == data.length - 1,
                          onTap: () {
                            if (i == data.length - 1) {
                              logoutSheet(context);
                            } else {
                              if (data[i].route != null) {
                                Get.to(() => data[i].route!);
                              } else if (data[i].routeString != null) {
                                Get.toNamed(data[i].routeString!);
                              }
                            }
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

  Future<dynamic> logoutSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black,
      builder: (_) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5, color: AppColors.black[50]!),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 75),
                Text(
                  "are_you_sure_you_want_to".tr,
                  style: AppTexts.tmdr.copyWith(color: AppColors.black[100]),
                ),
                const SizedBox(height: 4),
                Text(
                  "logout_question".tr,
                  style: AppTexts.txls.copyWith(color: AppColors.black[50]),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 40),
                    Expanded(
                      child: CustomButton(
                        text: "logout".tr,
                        isSecondary: true,
                        onTap: () async {
                          Get.back();
                          Get.find<AuthController>().logout();
                        },
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: CustomButton(
                        text: "cancel".tr,
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        );
      },
    );
  }

  GestureDetector profileOptions({
    required String iconPath,
    required String title,
    Function()? onTap,
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          border: Border(
            bottom:
                isLast
                    ? BorderSide.none
                    : BorderSide(width: 0.5, color: AppColors.black[200]!),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blue,
              ),
              child: Center(child: CustomSvg(asset: iconPath, size: 20)),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppTexts.tmdm.copyWith(color: AppColors.black[50]),
            ),
            const Spacer(),
            SvgPicture.asset(AppIcons.arrowRight),
          ],
        ),
      ),
    );
  }
}
