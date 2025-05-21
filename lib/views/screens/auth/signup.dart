import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:wet_dreams/controllers/auth_controller.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';
import 'package:wet_dreams/views/screens/auth/verification.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final auth = Get.find<AuthController>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final conPassCtrl = TextEditingController();
  bool isLoading = false;

  handleSignup() async {
    if (passCtrl.text.trim() != conPassCtrl.text.trim()) {
      showSnackBar("Password didn't match");
      return;
    }

    setState(() {
      isLoading = true;
    });

    final message = await auth.signup(
      nameCtrl.text,
      emailCtrl.text,
      passCtrl.text,
    );

    setState(() {
      isLoading = false;
    });

    if (message == "success") {
      Get.to(() => Verification(email: emailCtrl.text,));
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
                        Text("Sign Up", style: AppTexts.dsmb),
                        const SizedBox(height: 3),
                        Text(
                          "Please sign up to get started",
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
                      title: "Name",
                      hintText: "Enter your name",
                      controller: nameCtrl,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      title: "Email",
                      hintText: "Enter your email address",
                      controller: emailCtrl,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      title: "Password",
                      hintText: "Create a password",
                      isPassword: true,
                      controller: passCtrl,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      title: "Re-Type Password",
                      hintText: "Re-enter your password",
                      isPassword: true,
                      controller: conPassCtrl,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: "SIGN UP",
                      onTap: handleSignup,
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
