import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wet_dreams/controllers/home_controller.dart';
import 'package:wet_dreams/controllers/user_controller.dart';
import 'package:wet_dreams/services/api_service.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_loading.dart';
import 'package:wet_dreams/views/screens/home/report_problem.dart';
import 'package:wet_dreams/views/screens/home/volume_of_my_pool.dart';
import 'package:wet_dreams/views/screens/notifications.dart';
import 'package:wet_dreams/views/screens/profile/subscription.dart';
import 'package:wet_dreams/views/screens/template/link_collection_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final home = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    home.getServices();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 27),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WELCOME TO WET",
                      style: TextStyle(
                        fontVariations: [FontVariation("wght", 700)],
                        fontSize: 12,
                        color: AppColors.black[50],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Swimming Pool Office",
                      style: AppTexts.tsmm.copyWith(color: AppColors.black[50]),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => Get.to(() => Notifications()),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.blue.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: CustomSvg(asset: AppIcons.bell)),
                      ),
                      Positioned(
                        top: -5,
                        right: -5,
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.red,
                          ),
                          child: Center(child: Text("2", style: AppTexts.tmdb)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hey Man, Good Afternoon!",
                style: AppTexts.tmdb.copyWith(color: AppColors.black[50]),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () =>
                      home.homeButtons.isEmpty
                          ? CustomLoading()
                          : GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.07,
                                  mainAxisSpacing: 18,
                                  crossAxisSpacing: 18,
                                ),
                            shrinkWrap: true,
                            children: [
                              ...home.homeButtons.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    if (e.isPremium) {
                                      final user = Get.find<UserController>();

                                      if (user
                                              .userInfo
                                              .value!
                                              .subscriptionStatus !=
                                          "subscribed") {
                                        // premiumFeature(context);
                                        // return;
                                      }
                                    }
                                    switch (e.type) {
                                      case "service":
                                        Get.to(
                                          () => LinkCollectionScreen(
                                            title: e.title,
                                            serviceId: e.serviceId,
                                          ),
                                        );
                                        break;
                                      case "shop":
                                        Get.to(
                                          () => LinkCollectionScreen(
                                            title: e.title,
                                            serviceId: e.serviceId,
                                            isShoping: true,
                                          ),
                                        );
                                        break;
                                      case "calculator":
                                        Get.to(() => VolumeOfMyPool());
                                        break;
                                      case "query":
                                        Get.to(() => ReportProblem());
                                        break;
                                      default:
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.blue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  ApiService().baseUrl + e.icon,
                                              height: 32,
                                              width: 32,
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              e.title,
                                              textAlign: TextAlign.center,
                                              style: AppTexts.txss.copyWith(
                                                color: AppColors.black.shade400,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            if (e.shortDescription != null)
                                              Text(
                                                e.shortDescription!,
                                                textAlign: TextAlign.center,
                                                style: AppTexts.txsr.copyWith(
                                                  color:
                                                      AppColors.black.shade400,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> premiumFeature(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black,
      builder: (_) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5, color: AppColors.black[50]!),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 75),
                Text(
                  "You have encountered a Premium Feature",
                  style: AppTexts.tmdr.copyWith(color: AppColors.black[100]),
                ),
                const SizedBox(height: 4),
                Text(
                  "Upgrade now?",
                  style: AppTexts.txls.copyWith(color: AppColors.black[50]),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 40),
                    Expanded(
                      child: CustomButton(
                        text: "Not now",
                        isSecondary: true,
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: CustomButton(
                        text: "Upgrade",
                        onTap: () {
                          Get.back();
                          Get.to(() => Subscription());
                        },
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        );
      },
    );
  }
}
