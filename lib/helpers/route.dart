import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoutes {

  static Map<String, Widget> routeWidgets = {

  };

  static List<GetPage> pages = [
    ...routeWidgets.entries.map(
      (e) => GetPage(name: e.key, page: () => e.value),
    ),
  ];
}
