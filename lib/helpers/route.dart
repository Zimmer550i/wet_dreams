import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/views/screens/auth/splash.dart';

class AppRoutes {
  static String splash = "/splash";

  static Map<String, Widget> routeWidgets = {splash: Splash()};

  static List<GetPage> pages = [
    ...routeWidgets.entries.map(
      (e) => GetPage(name: e.key, page: () => e.value),
    ),
  ];
}
