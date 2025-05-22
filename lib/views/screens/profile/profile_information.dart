import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/user_controller.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';
import 'package:wet_dreams/views/base/profile_picture.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({super.key});

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  final user = Get.find<UserController>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  File? image;
  bool isEditing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    nameCtrl.text = user.userInfo.value!.fullName;
    emailCtrl.text = user.userInfo.value!.email;
    phoneCtrl.text = user.userInfo.value!.profilePic ?? "No image";
  }

  void updateProfile() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> payload = {};

    if (nameCtrl.text != user.userInfo.value!.fullName) {
      payload.addAll({"full_name": nameCtrl.text});
    }

    if (image != null) {
      payload.addAll({"profile_pic": image});
    }

    if (payload == {}) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final message = await user.updateInfo(payload);

    if (message == "success") {
      user.getInfo();
      showSnackBar("User info updated", isError: false);
    } else {
      showSnackBar(message);
    }

    setState(() {
      isEditing = false;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile Information"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Center(
                  child: ProfilePicture(
                    imageFile: image,
                    image: user.getImageUrl(),
                    size: 120,
                    isEditable: isEditing,
                    imagePickerCallback: (p0) {
                      setState(() {
                        image = p0;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    user.userInfo.value!.fullName,
                    style: AppTexts.txls.copyWith(color: AppColors.black[50]),
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  title: "Name",
                  controller: nameCtrl,
                  isDisabled: !isEditing,
                ),
                if (!isEditing) const SizedBox(height: 24),
                if (!isEditing)
                  CustomTextField(
                    title: "Email",
                    controller: emailCtrl,
                    isDisabled: !isEditing,
                  ),
                // const SizedBox(height: 24),
                // CustomTextField(
                //   title: "Phone Number",
                //   controller: phoneCtrl,
                //   isDisabled: !isEditing,
                // ),
                const SizedBox(height: 30),
                CustomButton(
                  text: isEditing ? "Update Profile" : "Edit Profile",
                  isLoading: isLoading,
                  onTap: () {
                    if (!isEditing) {
                      setState(() {
                        isEditing = true;
                      });
                    } else {
                      updateProfile();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
