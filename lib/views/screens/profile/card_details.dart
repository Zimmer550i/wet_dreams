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
      appBar: CustomAppBar(title: "Card Details"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 50),
                CustomTextField(
                  title: "Card Holder Name",
                  hintText: "Enter card holder's name",
                  controller: nameCtrl,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  title: "Card Number",
                  hintText: "Enter card number",
                  controller: numCtrl,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  title: "Expire Date",
                  hintText: "Enter card's expire date",
                  controller: dateCtrl,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  title: "CVV",
                  hintText: "Enter card's cvv",
                  controller: cvvCtrl,
                ),
                const SizedBox(height: 30),
                CustomButton(text: "Confirm Purchase", onTap: handlePayment),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
