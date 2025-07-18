import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/home_controller.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';

class ReportProblem extends StatefulWidget {
  const ReportProblem({super.key});

  @override
  State<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  final home = Get.find<HomeController>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final explainCtrl = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void callBack() async {
    setState(() {
      isLoading = true;
    });

    final message = await home.sendQuery({
      "name": nameCtrl.text.trim(),
      "email": emailCtrl.text.trim(),
      "phone": phoneCtrl.text.trim(),
      "query": explainCtrl.text.trim(),
    });

    if (message == "success") {
      showSnackBar("Your inquiry has been sent", isError: false);
    } else {
      showSnackBar(message);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "report_problem".tr),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomTextField(title: "name".tr, radius: 8, controller: nameCtrl),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "email".tr,
                  radius: 8,
                  controller: emailCtrl,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "phone".tr,
                  radius: 8,
                  controller: phoneCtrl,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "explain_your_problem".tr,
                  hintText: "explain_your_problem_hint".tr,
                  radius: 8,
                  lines: 8,
                  controller: explainCtrl,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child:
                      isLoading
                          ? SizedBox(
                            height: 38,
                            width: 115,
                            child: Center(
                              child: FittedBox(
                                child: CircularProgressIndicator(
                                  color: AppColors.blue[50],
                                ),
                              ),
                            ),
                          )
                          : CustomButton(
                            text: "send_inquiry".tr,
                            onTap: callBack,
                            fontSize: 12,
                            padding: 12,
                            radius: 8,
                            width: 120,
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
