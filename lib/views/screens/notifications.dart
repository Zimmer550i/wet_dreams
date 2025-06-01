import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wet_dreams/controllers/user_controller.dart';
import 'package:wet_dreams/utils/app_colors.dart';
import 'package:wet_dreams/utils/app_icons.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/utils/custom_svg.dart';
import 'package:wet_dreams/utils/show_snackbar.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final user = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    user
        .refreshNotifications()
        .onError((e, j) {
          showSnackBar("Unexpected Error: $e");
          return '';
        })
        .then((val) {
          user.readNotifications();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notifications"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Obx(
              () => Column(
                spacing: 16,
                children: [
                  const SizedBox(height: 0),
                  for (var i in user.notifications)
                    GestureDetector(
                      onTap: () async {
                        if (i.actionUrl != null && i.actionUrl!.isNotEmpty) {
                          final url = Uri.parse(i.actionUrl!);
                          if (await canLaunchUrl(url)) {
                            launchUrl(url);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: i.isRead ? null : AppColors.blue,
                          border:
                              i.isRead
                                  ? null
                                  : Border.symmetric(horizontal: BorderSide()),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.black.shade400,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: CustomSvg(asset: AppIcons.bellBig),
                              ),
                            ),
                            Expanded(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(minHeight: 40),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    i.message,
                                    style: AppTexts.txsr.copyWith(
                                      color:
                                          i.isRead
                                              ? AppColors.black[50]
                                              : AppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: PopupMenuButton<String>(
                                onSelected: (value) {},
                                icon: CustomSvg(
                                  asset: AppIcons.threeDot,
                                  color:
                                      i.isRead
                                          ? AppColors.black.shade100
                                          : AppColors.black,
                                ),
                                menuPadding: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                color: AppColors.black.shade400,
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      child: Text(
                                        "Delete",
                                        style: AppTexts.tsmm,
                                      ),
                                    ),
                                  ];
                                },
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
        ),
      ),
    );
  }
}
