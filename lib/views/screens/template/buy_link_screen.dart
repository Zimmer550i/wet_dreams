import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wet_dreams/models/clickable_button_model.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';

class BuyLinkScreen extends StatelessWidget {
  final ClickableButtonModel data;
  const BuyLinkScreen(this.data, {super.key});

  final String replacementDetails =
      "Getting your swimming pool ready at the start of the season involves a few key steps to ensure it's clean, safe, and ready for swimming.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ""),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.black.shade400,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomSvg(asset: data.icon!, size: 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      data.title ?? "",
                      textAlign: TextAlign.center,
                      style: AppTexts.tlgb.copyWith(color: AppColors.black[50]),
                    ),
                  ),
                  Text(
                    data.subTitle ?? "",
                    textAlign: TextAlign.center,
                    style: AppTexts.tlgb.copyWith(color: AppColors.black[50]),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data.details ?? replacementDetails,
                    style: AppTexts.txsr,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "   Buy Product",
                    trailing: AppIcons.forward,
                    iconSize: 20,
                    height: 40,
                    fontSize: 12,
                    padding: 24,
                    width: null,
                    onTap: () async {
                      if (data.link != null) {
                        final Uri url = Uri.parse(data.link!);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          showSnackBar("Could not launch URL");
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
