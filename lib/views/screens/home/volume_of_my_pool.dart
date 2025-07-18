import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/calculator_controller.dart';
import 'package:wet_dreams/models/pool_volume.dart';
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
  final List<String> shapes = ["rectangular".tr, "circular".tr, "oval".tr];
  final List<List<String>> fields = [
    ["length", "width", "min_depth", "max_depth"],
    ["diameter", "min_depth", "max_depth"],
    ["length", "width", "min_depth", "max_depth"],
  ];
  final List<List<String>> fieldNames = [
    ["length".tr, "width".tr, "min_depth".tr, "max_depth".tr],
    ["diameter".tr, "min_depth".tr, "max_depth".tr],
    ["length".tr, "width".tr, "min_depth".tr, "max_depth".tr],
  ];
  int index = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (calc.poolVolume.value == null) {
      calc
          .getVolume()
          .then((val) => setValue(calc.poolVolume.value))
          .onError((e, j) => showSnackBar(e.toString()));
    } else {
      setValue(calc.poolVolume.value!);
    }
  }

  void handleCallback() async {
    setState(() {
      isLoading = true;
    });

    final currentVolume = calc.poolVolume.value;

    // Helper to parse double safely
    double? parse(String text) => double.tryParse(text.trim());

    bool hasChanged = false;

    if (currentVolume != null) {
      if (index == 0 || index == 2) {
        // Rectangular or Oval
        hasChanged =
            currentVolume.length != parse(controllers[0].text) ||
            currentVolume.width != parse(controllers[1].text) ||
            currentVolume.minDepth != parse(controllers[2].text) ||
            currentVolume.maxDepth != parse(controllers[3].text) ||
            currentVolume.shape.toLowerCase() != shapes[index].toLowerCase();
      } else if (index == 1) {
        // Circular
        hasChanged =
            currentVolume.diameter != parse(controllers[0].text) ||
            currentVolume.minDepth != parse(controllers[1].text) ||
            currentVolume.maxDepth != parse(controllers[2].text) ||
            currentVolume.shape.toLowerCase() != shapes[index].toLowerCase();
      }
    } else {
      // No existing data, so definitely changed
      hasChanged = true;
    }

    if (!hasChanged) {
      // No change, just navigate forward or do next step
      setState(() {
        isLoading = false;
      });
      Get.to(() => ChemicalCalculator());
      return;
    }

    // Build payload based on index as before
    Map<String, dynamic> payload = {};
    if (index == 0) {
      payload = {
        "shape": "rectangular",
        "length": parse(controllers[0].text),
        "width": parse(controllers[1].text),
        "min_depth": parse(controllers[2].text),
        "max_depth": parse(controllers[3].text),
      };
    } else if (index == 1) {
      payload = {
        "shape": "circular",
        "diameter": parse(controllers[0].text),
        "min_depth": parse(controllers[1].text),
        "max_depth": parse(controllers[2].text),
      };
    } else if (index == 2) {
      payload = {
        "shape": "oval",
        "length": parse(controllers[0].text),
        "width": parse(controllers[1].text),
        "min_depth": parse(controllers[2].text),
        "max_depth": parse(controllers[3].text),
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

  void setValue(PoolVolume? volume) {
    if (volume == null) {
      return;
    }
    index = shapes.indexWhere((val) => val.toLowerCase() == volume.shape);
    if (index == 0 || index == 2) {
      controllers[0].text = volume.length.toString();
      controllers[1].text = volume.width.toString();
      controllers[2].text = volume.minDepth.toString();
      controllers[3].text = volume.maxDepth.toString();
    } else if (index == 1) {
      controllers[0].text = volume.diameter.toString();
      controllers[1].text = volume.minDepth.toString();
      controllers[2].text = volume.maxDepth.toString();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "volume_of_my_pool".tr),
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
                      "${"shape".tr}:",
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
                    "in_meters".tr,
                    style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                  ),
                ),
                for (int i = 0; i < fields[index].length; i++)
                  inputFields(fieldNames[index][i], controller: controllers[i]),

                const SizedBox(height: 50),

                CustomButton(
                  text: "continue".tr,
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

  Row inputFields(String displayName, {TextEditingController? controller}) {
    return Row(
      children: [
        Text(
          displayName,
          style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
        ),
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
