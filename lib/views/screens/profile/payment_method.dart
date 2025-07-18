import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/services/api_service.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int selectedPayment = -1;
  final api = ApiService();
  bool isLoading = false;

  void handleCallback() async {
    if (selectedPayment == -1) {
      showSnackBar("select_payment_method_first".tr);
      return;
    }

    setState(() {
      isLoading = true;
    });

    List<String> endpoints = [
      "/subscription/strip_payment/",
      "/subscription/paypal_payment/",
    ];

    try {
      final response = await api.post(
        endpoints[selectedPayment],
        {},
        authReq: true,
      );
      setState(() {
        isLoading = false;
      });
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final url = body["approval_url"] ?? body[""];

        final uri = Uri.parse(url);

        if (await canLaunchUrl(uri)) {
          launchUrl(uri);
        }
      } else {
        showSnackBar(body['message'] ?? "connection_error".tr);
      }
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar("unexpected_error".tr + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "payment_method".tr),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "select_payment_method_prompt".tr,
                style: AppTexts.tlgm.copyWith(color: AppColors.black[50]),
              ),
              const SizedBox(height: 20),
              // CustomSvg(asset: AppIcons.card),
              paymentOptions(AppIcons.paypal, "card".tr, 0),
              const SizedBox(height: 16),
              paymentOptions(AppIcons.paypal, "paypal".tr, 1),
              Spacer(),
              CustomButton(
                text: "make_payment".tr,
                isLoading: isLoading,
                onTap: handleCallback,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector paymentOptions(String asset, String text, int index) {
    var isActive = selectedPayment == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = index;
        });
      },
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: isActive ? AppColors.blue : null,
          border: isActive ? null : Border.all(color: AppColors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          spacing: 16,
          children: [
            CustomSvg(asset: asset),
            Text(
              text,
              style: AppTexts.tlgr.copyWith(
                color: isActive ? AppColors.black : null,
              ),
            ),
            Spacer(),
            checkBox(isActive),
          ],
        ),
      ),
    );
  }

  Widget checkBox(bool isActive) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: Colors.white),
            shape: BoxShape.circle,
          ),
        ),
        if (isActive)
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
