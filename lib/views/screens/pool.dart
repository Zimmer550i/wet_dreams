import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/calculator_controller.dart';
import 'package:wet_dreams/models/chemical_result.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/formatter.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_loading.dart';
import 'package:wet_dreams/views/screens/home/chemical_calculator_analyse.dart';

class Pool extends StatefulWidget {
  const Pool({super.key});

  @override
  State<Pool> createState() => _PoolState();
}

class _PoolState extends State<Pool> {
  final calc = Get.find<CalculatorController>();
  num? m3;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    calc.getVolume().then((val) {
      setState(() {
        m3 = calc.poolVolume.value!.volumeM3;
      });
    }).onError((e, j) {
      showSnackBar(e.toString());
      return null;
    });
    calc.getChemicalResults().then((message) {
      if (message != "success") {
        showSnackBar(message);
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 36),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Volume (M3) WET App 00",
                      style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                    ),
                    Text(
                      "(1m3 = 1000 Liters)",
                      style: AppTexts.txsr.copyWith(
                        color: AppColors.black[200],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppColors.black.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(child: Text(m3?.ceil().toString() ?? "", style: AppTexts.txsr)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "Salt Chlorinator:",
                  style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                ),
                Spacer(),
                Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppColors.black.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(child: Text("But", style: AppTexts.txsr)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            isLoading
                ? CustomLoading()
                : Expanded(
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        children: [
                          const SizedBox(height: 34,),
                          for (var i in calc.results)
                            poolInformation(i),
                        ],
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget poolInformation(ChemicalResult result) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => Get.to(()=> ChemicalCalculatorAnalyse(result: result)),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.black.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Formatter.dateFormatter(result.createdAt),
                      style: AppTexts.txsr.copyWith(color: AppColors.black[50]),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "PH: ${result.inputValues.pH}",
                          style: AppTexts.txsr.copyWith(
                            color: AppColors.black[200],
                          ),
                        ),
                        Text(
                          "Cl: ${result.inputValues.chlorine}",
                          style: AppTexts.txsr.copyWith(
                            color: AppColors.black[200],
                          ),
                        ),
                        Text(
                          "Alc: ${result.inputValues.alkalinity}",
                          style: AppTexts.txsr.copyWith(
                            color: AppColors.black[200],
                          ),
                        ),
                        Text(
                          "CYA: ${result.inputValues.cya}",
                          style: AppTexts.txsr.copyWith(
                            color: AppColors.black[200],
                          ),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
        
              Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton<String>(
                  onSelected: (value) {},
                  iconSize: 10,
                  icon: CustomSvg(asset: AppIcons.threeDot, size: 16),
                  menuPadding: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  elevation: 24,
                  borderRadius: BorderRadius.circular(24),
                  splashRadius: 24,
                  color: AppColors.black.shade400,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(child: Text("Delete", style: AppTexts.tsmm)),
                    ];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
