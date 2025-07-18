import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/auth_controller.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';
import 'package:wet_dreams/views/screens/auth/verification.dart';

class ForgetPassword extends StatefulWidget {
  final String? email;
  const ForgetPassword({super.key, this.email});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final auth = Get.find<AuthController>();
  final emailCtrl = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailCtrl.text = widget.email ?? "";
  }

  handleResetPassword() async {
    setState(() {
      isLoading = true;
    });

    final message = await auth.sendOtp(emailCtrl.text);

    setState(() {
      isLoading = false;
    });

    if (message == "success") {
      Get.to(() => Verification(email: emailCtrl.text, resettingPass: true));
    } else {
      showSnackBar(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Stack(
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withAlpha(191),
                    BlendMode.srcATop,
                  ),
                  child: Image.asset(
                    "assets/images/swim.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => Get.back(),
                            child: CustomSvg(asset: AppIcons.backRounded),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text("forgot_password".tr, style: AppTexts.dsmb),
                        const SizedBox(height: 3),
                        Text(
                          "enter_your_email_to_reset_your_password".tr,
                          textAlign: TextAlign.center,
                          style: AppTexts.tmdr,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: Offset(0, -24),
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      title: "email".tr,
                      hintText: "enter_your_email_address".tr,
                      controller: emailCtrl,
                      radius: 10,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: "send_code".tr,
                      onTap: handleResetPassword,
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
