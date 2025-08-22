import 'package:wet_dreams/main.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:flutter/material.dart';

void showSnackBar(String message, {bool isError = true}) {
  rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  rootScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: isError ? AppColors.red : AppColors.blue,
      content: Text(
        message.contains("<!DOCTYPE html>") ? "Something went wrong! Please try again.": message,
        style: TextStyle(
          fontVariations: [FontVariation("wght", 400)],
          fontSize: 14,
          color: isError ? AppColors.blue[50] : AppColors.black,
        ),
      ),
    ),
  );
}
