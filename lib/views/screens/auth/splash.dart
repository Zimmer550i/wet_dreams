import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wet_dreams/controllers/auth_controller.dart';
import 'package:wet_dreams/helpers/route.dart';
import 'package:wet_dreams/views/screens/auth/auth.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Duration waitTime = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    routeController();
  }

  void routeController() async {
    final stopWatch = Stopwatch()..start();

    await Future.delayed(waitTime - stopWatch.elapsed);

    if (await Get.find<AuthController>().previouslyLoggedIn()) {
      Get.offAllNamed(AppRoutes.app);
    } else {
      Get.off(() => Auth());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/images/splash.png")),
    );
  }
}
