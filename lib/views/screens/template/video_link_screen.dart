import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wet_dreams/models/clickable_button_model.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';

class VideoLinkScreen extends StatelessWidget {
  final ClickableButtonModel data;
  const VideoLinkScreen(this.data, {super.key});

  final String replacementDetails =
      "Getting your swimming pool ready at the start of the season involves a few key steps to ensure it's clean, safe, and ready for swimming.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ""),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    data.title ?? "",
                    textAlign: TextAlign.center,
                    style: AppTexts.tlgb.copyWith(color: AppColors.black[50]),
                  ),
                ),
                const SizedBox(height: 24),
                CustomSvg(asset: data.icon!, size: 120),
                const SizedBox(height: 30),
                Text(data.details ?? replacementDetails, style: AppTexts.txsr),
                const SizedBox(height: 16),
                GestureDetector(
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
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.black.shade400,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: CustomSvg(asset: AppIcons.youtube),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.black.shade400,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(width: 0.5, color: AppColors.blue),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                data.link ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: AppTexts.txsr.copyWith(
                                  color: AppColors.black[50],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Transform.rotate(
                              angle: 2.3,
                              child: CustomSvg(
                                asset: AppIcons.back,
                                color: AppColors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
