import 'package:flutter/material.dart';

class ClickableButtonModel {
  final String? icon;
  final String? title;
  final String? subTitle;
  final Widget? route;
  final String? routeString;

  const ClickableButtonModel({
    this.icon,
    this.title,
    this.subTitle,
    this.route,
    this.routeString,
  });
}
