import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wet_dreams/utils/app_colors.dart';

Future<File?> customImagePicker({isCircular = true, isSquared = true, double? maxHeight, double? maxWidth}) async {
  final picker = ImagePicker();
  final cropper = ImageCropper();

  final XFile? pickedImage = await picker.pickImage(
    source: ImageSource.gallery,
  );

  if (pickedImage != null) {
    final CroppedFile? croppedImage = await cropper.cropImage(
      sourcePath: pickedImage.path,
      compressQuality: 90,
      maxHeight: maxHeight?.toInt(),
      maxWidth: maxWidth?.toInt(),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'crop_your_image'.tr,
          toolbarColor: AppColors.black,
          toolbarWidgetColor: Colors.blue[50],
          backgroundColor: AppColors.black,
          statusBarColor: AppColors.blue,
          cropStyle: isCircular ? CropStyle.circle : CropStyle.rectangle,
          hideBottomControls: isSquared,
          initAspectRatio: CropAspectRatioPreset.square,
        ),
        IOSUiSettings(
          cropStyle: isCircular ? CropStyle.circle : CropStyle.rectangle,
          showCancelConfirmationDialog: true,
        ),
      ],
    );

    if (croppedImage != null) {
      croppedImage.readAsBytes().then((value) {
        debugPrint("Image Size: ${value.length~/1000}KB");
      });
      return File(croppedImage.path);
    }
  }

  return null;
}
