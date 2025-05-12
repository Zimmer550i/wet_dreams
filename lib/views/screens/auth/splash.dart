import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/views/screens/auth/auth.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    routeController();
  }

  void routeController() async {
    Future.delayed(Duration(seconds: 1), () {
      Get.to(() => Auth());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset("assets/images/splash.png"));
  }
}
