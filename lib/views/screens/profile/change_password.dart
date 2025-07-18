import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/user_controller.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final user = Get.find<UserController>();
  final oldCtrl = TextEditingController();
  final newCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  bool isLoading = false;

  void handleCallback() async {
    setState(() {
      isLoading = true;
    });

    final message = await user.changePassword(
      oldCtrl.text,
      newCtrl.text,
      confirmCtrl.text,
    );

    if (message == "success") {
      showSnackBar("password_changed_successfully".tr, isError: false);
    } else {
      showSnackBar(message);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "change_password".tr),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                CustomTextField(
                  title: "old_password".tr,
                  hintText: "enter_current_password".tr,
                  controller: oldCtrl,
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  title: "new_password".tr,
                  hintText: "enter_new_password".tr,
                  controller: newCtrl,
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  title: "confirm_password".tr,
                  hintText: "re_enter_new_password".tr,
                  controller: confirmCtrl,
                  isPassword: true,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: "set_password".tr,
                  onTap: handleCallback,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
