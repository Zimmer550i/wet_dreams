import 'package:flutter/material.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';

class ReportProblem extends StatefulWidget {
  const ReportProblem({super.key});

  @override
  State<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final explainCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameCtrl.text = "Wasiul Islam";
    emailCtrl.text = "wasiul0491@gmail.com";
    phoneCtrl.text = "01823456146";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Report A Problem"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomTextField(title: "Name", radius: 8, controller: nameCtrl),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "Email",
                  radius: 8,
                  controller: emailCtrl,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "Phone",
                  radius: 8,
                  controller: phoneCtrl,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "Explain your problem",
                  hintText: "Explain your problem and be as specific as possible",
                  radius: 8,
                  lines: 8,
                  controller: explainCtrl,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    text: "SEND INQUIRY",
                    fontSize: 12,
                    padding: 12,
                    radius: 8,
                    width: null,
                    height: 38,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
