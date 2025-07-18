import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wet_dreams/controllers/home_controller.dart';
import 'package:wet_dreams/services/api_service.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_loading.dart';

class VideoLinkScreen extends StatefulWidget {
  final String itemId;
  const VideoLinkScreen(this.itemId, {super.key});

  @override
  State<VideoLinkScreen> createState() => _VideoLinkScreenState();
}

class _VideoLinkScreenState extends State<VideoLinkScreen> {
  final home = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    home.getItem(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "video_link".tr),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Obx(
              () =>
                  home.item.value == null
                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomLoading(),
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              home.item.value!.title,
                              textAlign: TextAlign.center,
                              style: AppTexts.tlgb.copyWith(
                                color: AppColors.black[50],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          CustomSvg(
                            asset:
                                ApiService().baseUrl + home.item.value!.image,
                            size: 120,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            home.item.value!.description,
                            style: AppTexts.txsr,
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () async {
                              if (home.item.value!.externalSourceUrl != null) {
                                final Uri url = Uri.parse(
                                  home.item.value!.externalSourceUrl!,
                                );
                              if (await canLaunchUrl(url)) {
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                showSnackBar("could_not_launch_url".tr);
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
                                    border: Border.all(
                                      width: 0.5,
                                      color: AppColors.blue,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                            2,
                                        child: Text(
                                          home.item.value!.externalSourceUrl ??
                                              "",
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
      ),
    );
  }
}
