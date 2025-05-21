import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:wet_dreams/controllers/auth_controller.dart';
import 'package:wet_dreams/helpers/route.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/screens/auth/create_new_password.dart';

class Verification extends StatefulWidget {
  final String email;
  final bool resettingPass;
  const Verification({
    super.key,
    required this.email,
    this.resettingPass = false,
  });

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final auth = Get.find<AuthController>();
  final otpCtrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int sec = 0;
  Timer? _timer;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  handleVerification() async {
    setState(() {
      isLoading = true;
    });

    final message = await auth.verifyEmail(widget.email, otpCtrl.text);

    setState(() {
      isLoading = false;
    });

    if (message == "success") {
      if (widget.resettingPass) {
        Get.to(() => CreateNewPassword());
      } else {
        Get.offAllNamed(AppRoutes.app);
      }
    } else {
      showSnackBar(message);
    }
  }

  resendOtp() async {
    final message = await auth.sendOtp(widget.email);

    if (message == "success") {
      restartTime();
    } else {
      showSnackBar(message);
    }
  }

  restartTime() async {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    setState(() {
      sec = 60;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (sec > 0) {
        setState(() {
          sec = sec - 1;
        });
      } else {
        _timer!.cancel();
      }
    });
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
                        Text("Verification", style: AppTexts.dsmb),
                        const SizedBox(height: 3),
                        Text(
                          "We have sent a code to your email",
                          style: AppTexts.tmdr,
                        ),
                        const SizedBox(height: 3),
                        Text(widget.email, style: AppTexts.tmdb),
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
                    Row(
                      children: [
                        Text(
                          "Code",
                          style: AppTexts.tsmr.copyWith(
                            color: AppColors.black[50],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: resendOtp,
                          behavior: HitTestBehavior.translucent,
                          child: Text(
                            " Resend ",
                            style: AppTexts.tsmb.copyWith(
                              color: AppColors.black[50],
                            ),
                          ),
                        ),
                        if (_timer != null && _timer!.isActive)
                          Text(
                            "in $sec sec",
                            style: AppTexts.tsmr.copyWith(
                              color: AppColors.black[50],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Pinput(
                      length: 6,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      controller: otpCtrl,
                      focusNode: _focusNode,
                      cursor: Container(
                        height: 20,
                        width: 3,
                        color: AppColors.blue.shade600,
                      ),
                      defaultPinTheme: PinTheme(
                        width: MediaQuery.of(context).size.width / 7,
                        height: MediaQuery.of(context).size.width / 7,
                        textStyle: AppTexts.tlgr,
                        decoration: BoxDecoration(
                          color: AppColors.black.shade400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: MediaQuery.of(context).size.width / 7,
                        height: MediaQuery.of(context).size.width / 7,
                        textStyle: AppTexts.tlgr,
                        decoration: BoxDecoration(
                          color: AppColors.black.shade400,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.blue.shade600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: "VERIFY",
                      onTap: handleVerification,
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
