import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wet_dreams/controllers/localization_controller.dart';
import 'package:wet_dreams/controllers/user_controller.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/subscription_widget.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/screens/profile/purchase_confirmation.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  final user = Get.find<UserController>();

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
                  isPurchased: user.userInfo.value?.packageName == "Basic Plan",
                  icon: AppIcons.basic,
                  title: "basic_plan".tr,
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
                  isPurchased: user.userInfo.value?.packageName == "Premium Plan",
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
                      debugPrint(offerings.toString());
                      final offering = offerings.getOffering("premium_plan_1");
                      debugPrint(offering.toString());
                      if (offering != null) {
                        final package = offering.getPackage("\$rc_monthly");
                        debugPrint(package.toString());

                        if (package != null) {
                          await Purchases.logIn(user.userInfo.value!.email);
                          final appUserID = await Purchases.appUserID;
                          debugPrint("Paid user: $appUserID");
                          await Purchases.purchasePackage(package);

                          user.getInfo().then((message) {
                            if (message == "success") {
                              user.userInfo.value!.packageName = "Premium Plan";
                            }
                          });
                          showSnackBar("Payment Successful", isError: false);
                          Get.to(() => PurchaseConfirmation());
                        }
                      }
                    } catch (e) {
                      debugPrint(e.toString());
                      showSnackBar(
                        "Error: Something went wrong. Please try again.",
                      );
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
