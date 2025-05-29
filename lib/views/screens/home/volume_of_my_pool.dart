import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:wet_dreams/controllers/calculator_controller.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_drop_down.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';
import 'package:wet_dreams/views/screens/home/chemical_calculator.dart';

class VolumeOfMyPool extends StatefulWidget {
  const VolumeOfMyPool({super.key});

  @override
  State<VolumeOfMyPool> createState() => _VolumeOfMyPoolState();
}

class _VolumeOfMyPoolState extends State<VolumeOfMyPool> {
  final calc = Get.find<CalculatorController>();
  final List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<String> shapes = ["Rectangular", "Circle", "Oval"];
  final List<List<String>> fields = [
    ["length", "width", "min_depth", "max_depth"],
    ["diameter", "average_depth"],
    ["length", "width", "average_depth"],
  ];
  int index = 0;
  bool isLoading = false;

  void handleCallback() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> payload = {};

    if (index == 0) {
      payload = {
        "shape": "rectangular",
        "length": double.tryParse(controllers[0].text.trim()),
        "width": double.tryParse(controllers[1].text.trim()),
        "min_depth": double.tryParse(controllers[2].text.trim()),
        "max_depth": double.tryParse(controllers[3].text.trim()),
      };
    }

    final message = await calc.calculateVolume(payload);

    if (message == "success") {
      Get.to(() => ChemicalCalculator());
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
      appBar: CustomAppBar(title: "Volume Of My Pool"),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              spacing: 16,
              children: [
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shape:",
                      style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                    ),
                    Spacer(),
                    Expanded(
                      child: CustomDropDown(
                        options: shapes,
                        initialPick: index,
                        radius: 4,
                        height: 30,
                        onChanged: (p0) {
                          setState(() {
                            index = shapes.indexOf(p0);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "in Meters",
                    style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                  ),
                ),
                for (int i = 0; i < fields[index].length; i++)
                  inputFields(fields[index][i], controller: controllers[i]),

                const SizedBox(height: 50),

                CustomButton(
                  text: "CONTINUE",
                  fontSize: 12,
                  padding: 16,
                  radius: 8,
                  width: null,
                  height: 38,
                  isLoading: isLoading,
                  onTap: handleCallback,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row inputFields(String title, {TextEditingController? controller}) {
    title = title.replaceAll("_", " ");
    title = title
        .split(" ")
        .map((e) => e[0].toUpperCase() + e.substring(1))
        .join(" ");

    return Row(
      children: [
        Text(title, style: AppTexts.tsmr.copyWith(color: AppColors.black[50])),
        Spacer(),
        CustomTextField(
          height: 30,
          width: 70,
          radius: 4,
          textInputType: TextInputType.number,
          controller: controller,
        ),
      ],
    );
  }
}
