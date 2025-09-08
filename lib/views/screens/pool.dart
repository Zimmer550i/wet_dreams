import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/calculator_controller.dart';
import 'package:wet_dreams/controllers/user_controller.dart';
import 'package:wet_dreams/models/chemical_result.dart';
import 'package:wet_dreams/services/shared_prefs_service.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/formatter.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_loading.dart';
import 'package:wet_dreams/views/screens/home/chemical_calculator_analyse.dart';
import 'package:wet_dreams/views/screens/profile/subscription.dart';

class Pool extends StatefulWidget {
  const Pool({super.key});

  @override
  State<Pool> createState() => _PoolState();
}

class _PoolState extends State<Pool> {
  final calc = Get.find<CalculatorController>();
  final prefs = SharedPrefsService();

  final clorinatorValues = ["yes", "not"];
  final poolTypeValues = ["concrete", "polyester", "liner"];
  int clorinatorIndex = 0;
  int poolTypeIndex = 0;
  num? m3;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = Get.find<UserController>();

      if (user.userInfo.value!.packageName != "Premium Plan") {
        premiumFeature(context);
        return;
      }

      loadValues();
    });

    calc
        .getVolume()
        .then((val) {
          setState(() {
            m3 = calc.poolVolume.value?.volumeM3;
          });
        })
        .onError((e, j) {
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
                      "volume_m3_wet_app".tr,
                      style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                    ),
                    Text(
                      "volume_info".tr,
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
                  child: Center(
                    child: Text(
                      m3?.ceil().toString() ?? "",
                      style: AppTexts.txsr,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "${"salt_chlorinator".tr}:",
                  style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      clorinatorIndex++;
                      if (clorinatorIndex == clorinatorValues.length) {
                        clorinatorIndex = 0;
                      }
                    });
                    saveValues();
                  },
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColors.black.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        clorinatorValues[clorinatorIndex].tr,
                        style: AppTexts.txsr,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "${"pool_type".tr}:",
                  style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      poolTypeIndex++;
                      if (poolTypeIndex == poolTypeValues.length) {
                        poolTypeIndex = 0;
                      }
                    });
                    saveValues();
                  },
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColors.black.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        poolTypeValues[poolTypeIndex].tr,
                        style: AppTexts.txsr,
                      ),
                    ),
                  ),
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
                          const SizedBox(height: 34),
                          for (var i in calc.results) poolInformation(i),
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

  void loadValues() async {
    String? val1 = await SharedPrefsService.get("clorinatorIndex");
    String? val2 = await SharedPrefsService.get("poolTypeIndex");
    setState(() {
      clorinatorIndex = int.parse(val1 ?? "0");
      poolTypeIndex = int.parse(val2 ?? "0");
    });
  }

  void saveValues() async {
    SharedPrefsService.set("clorinatorIndex", clorinatorIndex.toString());
    SharedPrefsService.set("poolTypeIndex", clorinatorIndex.toString());
  }

  Widget poolInformation(ChemicalResult result) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => Get.to(() => ChemicalCalculatorAnalyse(result: result)),
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
                    Wrap(
                      spacing: 5,
                      children: [
                        Text(
                          "${"ph".tr}: ${result.inputValues.pH}",
                          style: AppTexts.txsr.copyWith(
                            color: AppColors.black[200],
                          ),
                        ),
                        Text(
                          "${"cl".tr}: ${result.inputValues.chlorine}",
                          style: AppTexts.txsr.copyWith(
                            color: AppColors.black[200],
                          ),
                        ),
                        Text(
                          "${"alc".tr}: ${result.inputValues.alkalinity}",
                          style: AppTexts.txsr.copyWith(
                            color: AppColors.black[200],
                          ),
                        ),
                        Text(
                          "${"cya".tr}: ${result.inputValues.cya}",
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
                      PopupMenuItem(
                        onTap: () async {
                          await calc
                              .deleteChemicalResult(result.id.toString())
                              .then((val) {
                                if (val == "success") {
                                  setState(() {
                                    calc.results.remove(result);
                                  });
                                }
                              });
                        },
                        child: Text("delete".tr, style: AppTexts.tsmm),
                      ),
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

  Future<dynamic> premiumFeature(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black,
      builder: (_) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5, color: AppColors.black[50]!),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 75),
                Text(
                  "premium_feature_encountered".tr,
                  style: AppTexts.tmdr.copyWith(color: AppColors.black[100]),
                ),
                const SizedBox(height: 4),
                Text(
                  "upgrade_now".tr,
                  style: AppTexts.txls.copyWith(color: AppColors.black[50]),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 40),
                    Expanded(
                      child: CustomButton(
                        text: "not_now".tr,
                        isSecondary: true,
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: CustomButton(
                        text: "upgrade".tr,
                        onTap: () {
                          Get.back();
                          Get.to(() => Subscription());
                        },
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        );
      },
    );
  }
}
