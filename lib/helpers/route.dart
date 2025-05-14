import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/views/screens/app.dart';
import 'package:wet_dreams/views/screens/auth/splash.dart';

class AppRoutes {
  static String splash = "/splash";
  static String app = "/app";

  static Map<String, Widget> routeWidgets = {splash: Splash(), app: App()};

  static List<GetPage> pages = [
    ...routeWidgets.entries.map(
      (e) => GetPage(name: e.key, page: () => e.value),
    ),
  ];
}
