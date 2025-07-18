import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';
import 'package:wet_dreams/views/screens/profile/purchase_confirmation.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  final nameCtrl = TextEditingController();
  final numCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final cvvCtrl = TextEditingController();

  handlePayment() async {
    Get.to(() => PurchaseConfirmation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "card_details".tr),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 50),
                CustomTextField(
                  title: "card_holder_name".tr,
                  hintText: "enter_card_holder_name".tr,
                  controller: nameCtrl,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  title: "card_number".tr,
                  hintText: "enter_card_number".tr,
                  controller: numCtrl,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  title: "expire_date".tr,
                  hintText: "enter_card_expire_date".tr,
                  controller: dateCtrl,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  title: "cvv".tr,
                  hintText: "enter_card_cvv".tr,
                  controller: cvvCtrl,
                ),
                const SizedBox(height: 30),
                CustomButton(text: "confirm_purchase".tr, onTap: handlePayment),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
