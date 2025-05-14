import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_texts.dart';
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
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  File? image;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();

    nameCtrl.text = "Wasiul Islam";
    emailCtrl.text = "wasiul0491@gmail.com";
    phoneCtrl.text = "01969696969";
  }

  void updateProfile() async {
    setState(() {
      isEditing = false;
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
                    image: "https://thispersondoesnotexist.com",
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
                    "Waisul Islam",
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
                const SizedBox(height: 24),
                CustomTextField(
                  title: "Phone Number",
                  controller: phoneCtrl,
                  isDisabled: !isEditing,
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: isEditing ? "Update Profile" : "Edit Profile",
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
