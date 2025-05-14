import 'package:flutter/material.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldCtrl = TextEditingController();
  final newCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Change Password"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                CustomTextField(
                  title: "Old Password",
                  hintText: "Eneter current password",
                  controller: oldCtrl,
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  title: "New Password",
                  hintText: "Eneter new password",
                  controller: newCtrl,
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  title: "Confirm Password",
                  hintText: "Re-enter the new password",
                  controller: confirmCtrl,
                  isPassword: true,
                ),
                const SizedBox(height: 40),
                CustomButton(text: "Set Password")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
