import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';
import 'package:wet_dreams/views/screens/auth/forget_password.dart';
import 'package:wet_dreams/views/screens/auth/signup.dart';
import 'package:wet_dreams/views/screens/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool rememberMe = false;

  void handleLogin() async {
    Get.off(() => Home());
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
                        Text("Log In", style: AppTexts.dsmb),
                        const SizedBox(height: 3),
                        Text(
                          "Please sign in to your existing account",
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
                      title: "Email",
                      hintText: "Enter email",
                      controller: emailCtrl,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      title: "Password",
                      hintText: "Enter Password",
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
                            "Remember me",
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
                            " Forgot Password",
                            style: AppTexts.tsmr.copyWith(
                              color: AppColors.blue.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomButton(text: "LOGIN", onTap: handleLogin),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don’t have an account?", style: AppTexts.tmdr),
                        GestureDetector(
                          onTap: () => Get.to(() => Signup()),
                          child: Text(
                            " SIGN UP ",
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
