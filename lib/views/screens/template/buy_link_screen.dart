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
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_loading.dart';

class BuyLinkScreen extends StatefulWidget {
  final String itemId;
  const BuyLinkScreen(this.itemId, {super.key});

  @override
  State<BuyLinkScreen> createState() => _BuyLinkScreenState();
}

class _BuyLinkScreenState extends State<BuyLinkScreen> {
  final home = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    home.getItem(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "buy_link".tr),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Obx(
              () =>
                  home.item.value == null
                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomLoading(),
                      )
                      : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.black.shade400,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomSvg(
                              asset:
                                  ApiService().baseUrl + home.item.value!.image,
                              size: 80,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: Text(
                                home.item.value!.title,
                                textAlign: TextAlign.center,
                                style: AppTexts.tlgb.copyWith(
                                  color: AppColors.black[50],
                                ),
                              ),
                            ),
                            Text(
                              home.item.value!.shortTitle ?? "",
                              textAlign: TextAlign.center,
                              style: AppTexts.txsr.copyWith(
                                color: AppColors.black[50],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              home.item.value!.description,
                              style: AppTexts.txsr,
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              text: "buy_product".tr,
                              trailing: AppIcons.forward,
                              iconSize: 20,
                              height: 40,
                              fontSize: 12,
                              padding: 24,
                              width: null,
                              onTap: () async {
                                if (home.item.value!.externalSourceUrl !=
                                    null) {
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
                            ),
                          ],
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
