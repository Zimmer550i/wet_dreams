import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/views/base/subscription_widget.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/screens/profile/payment_method.dart';

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
                  cons: [
                    "calculator_of_chemicals".tr,
                    "tricks_and_secrets".tr,
                  ],
                  onTap: () => Get.to(() => PaymentMethod()),
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
                  onTap: () => Get.to(() => PaymentMethod()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
