import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wet_dreams/models/clickable_button_model.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/views/screens/notifications.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  final data = const [
    ClickableButtonModel(
      icon: AppIcons.warning,
      title: "ISSUES FREQUENT",
      subTitle: "(In The Pool)",
    ),
    ClickableButtonModel(
      icon: AppIcons.news,
      title: "MAINTENANCE NEWSPAPER",
      subTitle: "(For Individuals)",
    ),
    ClickableButtonModel(
      icon: AppIcons.buy,
      title: "BUY PRODUCTS",
      subTitle: "(To Take Care Of Your Pool)",
    ),
    ClickableButtonModel(
      icon: AppIcons.calculator,
      title: "BUY PRODUCTS",
      subTitle: "(To Take Care Of Your Pool)",
    ),
    ClickableButtonModel(
      icon: AppIcons.tipsAndTricks,
      title: "TRICKS AND SECRETS",
      subTitle: "(Little Known)",
    ),
    ClickableButtonModel(
      icon: AppIcons.swim,
      title: "I HAVE A PROBLEM IN MY POOL",
      subTitle: "(Critical And Urgent)",
    ),
  ];

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
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.07,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ...data.map((e) {
                      return GestureDetector(
                        onTap: () {
                          if (e.route != null) {
                            Get.to(() => e.route);
                          } else if (e.routeString != null) {
                            Get.toNamed(e.routeString!);
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomSvg(asset: e.icon!, size: 32),
                                  const SizedBox(height: 16),
                                  Text(
                                    e.title!,
                                    textAlign: TextAlign.center,
                                    style: AppTexts.txss.copyWith(
                                      color: AppColors.black.shade400,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    e.subTitle!,
                                    textAlign: TextAlign.center,
                                    style: AppTexts.txsr.copyWith(
                                      color: AppColors.black.shade400,
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
          ],
        ),
      ),
    );
  }
}
