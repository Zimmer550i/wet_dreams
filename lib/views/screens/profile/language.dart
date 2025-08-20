import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/localization_controller.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';

enum SelectedLanguage { english, spanish }

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final lang = Get.find<LocalizationController>();
  SelectedLanguage _selectedLanguage = SelectedLanguage.spanish;

  @override
  void initState() {
    super.initState();

    if (lang.locale.languageCode == "en") {
      _selectedLanguage = SelectedLanguage.english;
    } else {
      _selectedLanguage = SelectedLanguage.spanish;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "language".tr),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  lang.setLanguage(Locale.fromSubtags(languageCode: "es"));
                  setState(() {
                    _selectedLanguage = SelectedLanguage.spanish;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color:
                          _selectedLanguage == SelectedLanguage.spanish
                              ? AppColors.blue
                              : AppColors.black.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Español",
                        style: AppTexts.tlgm.copyWith(
                          color: AppColors.black[50],
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color:
                                _selectedLanguage == SelectedLanguage.spanish
                                    ? AppColors.blue
                                    : AppColors.black.shade200,
                          ),
                        ),
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color:
                                _selectedLanguage == SelectedLanguage.spanish
                                    ? AppColors.blue
                                    : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  lang.setLanguage(Locale.fromSubtags(languageCode: "en"));
                  setState(() {
                    _selectedLanguage = SelectedLanguage.english;
                  });
                  
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color:
                          _selectedLanguage == SelectedLanguage.english
                              ? AppColors.blue
                              : AppColors.black.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "English",
                        style: AppTexts.tlgm.copyWith(
                          color: AppColors.black[50],
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color:
                                _selectedLanguage == SelectedLanguage.english
                                    ? AppColors.blue
                                    : AppColors.black.shade200,
                          ),
                        ),
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color:
                                _selectedLanguage == SelectedLanguage.english
                                    ? AppColors.blue
                                    : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
