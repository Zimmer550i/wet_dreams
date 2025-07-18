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
import 'package:wet_dreams/views/screens/auth/password_confirmation.dart';

class CreateNewPassword extends StatefulWidget {
  final String? email;
  const CreateNewPassword({super.key, this.email});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final auth = Get.find<AuthController>();
  final passCtrl = TextEditingController();
  final conPassCtrl = TextEditingController();
  bool isLoading = false;

  handleCreatePassword() async {
    setState(() {
      isLoading = true;
    });

    final message = await auth.resetPassword(passCtrl.text, conPassCtrl.text);

    setState(() {
      isLoading = false;
    });

    if (message == "success") {
      Get.to(() => PasswordConfirmation());
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
                        Text("create_new_password".tr, style: AppTexts.dsmb),
                        const SizedBox(height: 3),
                        Text(
                          "please_sign_up_to_get_started".tr,
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
                      title: "password".tr,
                      hintText: "create_a_password".tr,
                      isPassword: true,
                      controller: passCtrl,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      title: "re_type_password".tr,
                      hintText: "re_enter_your_password".tr,
                      isPassword: true,
                      controller: conPassCtrl,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: "confirm".tr,
                      onTap: handleCreatePassword,
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
