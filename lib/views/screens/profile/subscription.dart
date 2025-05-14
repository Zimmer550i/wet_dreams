import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/views/base/subscription_widget.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/screens/profile/payment_method.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Subscribe To Premium"),
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
                  title: "Basic Plan",
                  subTitle: "Free",
                  pros: [
                    "Issues Frequent",
                    "Maintenance Newspapar",
                    "But Products",
                    "Problem In My Pool",
                  ],
                  cons: ["Calculator Of Chemicals", "Tricks And Secrets"],
                  onTap: () => Get.to(() => PaymentMethod()),
                ),
                SubscriptionWidget(
                  isPremium: true,
                  icon: AppIcons.premium,
                  title: "Premium Plan",
                  subTitle: "\$4.9 /month",
                  pros: [
                    "Issues Frequent",
                    "Maintenance Newspapar",
                    "But Products",
                    "Problem In My Pool",
                    "Calculator Of Chemicals",
                    "Tricks And Secrets",
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
