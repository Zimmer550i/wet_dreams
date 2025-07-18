import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/auth_controller.dart';
import 'package:wet_dreams/helpers/route.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';
import 'package:wet_dreams/views/screens/auth/forget_password.dart';
import 'package:wet_dreams/views/screens/auth/signup.dart';
import 'package:wet_dreams/views/screens/auth/verification.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = Get.find<AuthController>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool rememberMe = true;
  bool isLoading = false;

  void handleLogin() async {
    setState(() {
      isLoading = true;
    });

    final message = await auth.login(
      emailCtrl.text,
      passCtrl.text,
      rememberMe: rememberMe,
    );

    setState(() {
      isLoading = false;
    });

    if (message == "success") {
      Get.offNamed(AppRoutes.app);
    } else if (message == "verify") {
      auth.sendOtp(emailCtrl.text);
      Get.to(() => Verification(email: emailCtrl.text));
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
                        const SizedBox(height: 40, width: double.infinity),
                        const SizedBox(height: 30),
                        Text("log_in".tr, style: AppTexts.dsmb),
                        const SizedBox(height: 3),
                        Text(
                          "please_sign_in_to_your_existing_account".tr,
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
                      hintText: "enter_email".tr,
                      controller: emailCtrl,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      title: "password".tr,
                      hintText: "enter_password".tr,
                      isPassword: true,
                      controller: passCtrl,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            activeColor: AppColors.blue,
                            checkColor: AppColors.black,
                            value: rememberMe,
                            onChanged: (val) {
                              setState(() {
                                rememberMe = val!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rememberMe = !rememberMe;
                            });
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Text(
                            "remember_me".tr,
                            style: AppTexts.tsmr.copyWith(
                              color: AppColors.black.shade200,
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap:
                              () => Get.to(
                                () => ForgetPassword(email: emailCtrl.text),
                              ),
                          behavior: HitTestBehavior.translucent,
                          child: Text(
                            "forgot_password".tr,
                            style: AppTexts.tsmr.copyWith(
                              color: AppColors.blue.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: "login".tr,
                      onTap: handleLogin,
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("dont_have_an_account".tr, style: AppTexts.tmdr),
                        GestureDetector(
                          onTap: () => Get.to(() => Signup()),
                          child: Text(
                            "sign_up".tr,
                            style: AppTexts.tmdb.copyWith(
                              color: AppColors.blue.shade600,
                            ),
                          ),
                        ),
                      ],
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
