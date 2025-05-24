import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wet_dreams/controllers/home_controller.dart';
import 'package:wet_dreams/models/item_list_model.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/formatter.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_loading.dart';
import 'package:wet_dreams/views/screens/template/buy_link_screen.dart';
import 'package:wet_dreams/views/screens/template/video_link_screen.dart';

class LinkCollectionScreen extends StatefulWidget {
  final String title;
  final String serviceId;
  final bool isShoping;
  const LinkCollectionScreen({
    super.key,
    required this.serviceId,
    required this.title,
    this.isShoping = false,
  });

  @override
  State<LinkCollectionScreen> createState() => _LinkCollectionScreenState();
}

class _LinkCollectionScreenState extends State<LinkCollectionScreen> {
  final home = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Obx(
            () =>
                home.itemList.isEmpty
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomLoading(),
                    )
                    : Column(
                      children: [
                        const SizedBox(height: 32),
                        ...home.itemList.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              left: 24,
                              right: 24,
                            ),
                            child: tabButton(e),
                          );
                        }),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Obx(
                            () =>
                                home.footer.value == null
                                    ? Container()
                                    : GestureDetector(
                                      onTap: () async {
                                        final Uri url = Uri.parse(
                                          home.footer.value!.footerUrl,
                                        );
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(
                                            url,
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        } else {
                                          showSnackBar("Could not launch URL");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.blue,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                home.footer.value!.footerTitle,
                                                style: AppTexts.txsr.copyWith(
                                                  color: AppColors.blue,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
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
                                    ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
          ),
        ),
      ),
    );
  }

  Widget tabButton(ItemListModel e) {
    return GestureDetector(
      onTap: () {
        if (widget.isShoping) {
          Get.to(() => BuyLinkScreen(e.itemId));
        } else {
          Get.to(() => VideoLinkScreen(e.itemId));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      Formatter.toTitleCase(e.title),
                      style: AppTexts.tsms.copyWith(
                        color: AppColors.blue.shade900,
                      ),
                    ),
                  ),
                  if (e.shortTitle != null)
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        Formatter.toTitleCase(e.shortTitle!),
                        style: AppTexts.txsr.copyWith(
                          color: AppColors.blue.shade900,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            CustomSvg(asset: AppIcons.arrowRightSmall),
          ],
        ),
      ),
    );
  }

  void fetchData() async {
    final message = await home.getItems(widget.serviceId);

    if (message != "success") {
      showSnackBar(message);
    }
  }
}
