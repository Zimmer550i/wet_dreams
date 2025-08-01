import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wet_dreams/controllers/localization_controller.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/subscription_widget.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "subscribe_to_premium".tr),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              spacing: 24,
              children: [
                const SizedBox(height: 0),
                SubscriptionWidget(
                  icon: AppIcons.basic,
                  title: "basic_plan".tr,
                  isPurchased: true,
                  subTitle: "free".tr,
                  pros: [
                    "issues_frequent".tr,
                    "maintenance_newspaper".tr,
                    "but_products".tr,
                    "problem_in_my_pool".tr,
                  ],
                  cons: ["calculator_of_chemicals".tr, "tricks_and_secrets".tr],
                  onTap: () {
                    Get.find<LocalizationController>().setLanguage(
                      Locale.fromSubtags(languageCode: "es"),
                    );
                  },
                ),
                SubscriptionWidget(
                  isPremium: true,
                  icon: AppIcons.premium,
                  title: "premium_plan".tr,
                  subTitle: "price_per_month".tr,
                  pros: [
                    "issues_frequent".tr,
                    "maintenance_newspaper".tr,
                    "but_products".tr,
                    "problem_in_my_pool".tr,
                    "calculator_of_chemicals".tr,
                    "tricks_and_secrets".tr,
                  ],
                  onTap: () async {
                    try {
                      final offerings = await Purchases.getOfferings();
                      final offering = offerings.getOffering("premium_plan_1");
                      if (offering != null) {
                        final package = offering.getPackage("\$rc_monthly");

                        if (package != null) {
                          PurchaseResult purchaseResult =
                              await Purchases.purchasePackage(package);

                          debugPrint("Purchase Successful: $purchaseResult");
                        }
                      }
                    } catch (e) {
                      showSnackBar(e.toString());
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
