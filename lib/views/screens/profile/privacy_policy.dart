import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/user_controller.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_loading.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final user = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    user.getPrivacyPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "privacy_policy".tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Obx(
              () =>
                  user.isLoading.value 
                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomLoading(),
                      )
                      : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          user.privacyPolicy.value ?? "",
                          style: AppTexts.txsr.copyWith(
                            color: AppColors.black[50],
                          ),
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
