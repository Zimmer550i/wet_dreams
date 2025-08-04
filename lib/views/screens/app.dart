import 'package:flutter/material.dart';
import 'package:wet_dreams/views/base/custom_bottom_navbar.dart';
import 'package:wet_dreams/views/screens/home/home.dart';
import 'package:wet_dreams/views/screens/pool.dart';
import 'package:wet_dreams/views/screens/profile/profile.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged:
                    (value) => setState(() {
                      index = value;
                    }),
                children: [
                  Home(key: PageStorageKey("home")),
                  Pool(key: PageStorageKey("pool")),
                  Profile(key: PageStorageKey("profile")),
                ],
              ),
            ),
            CustomBottomNavbar(
              index: index,
              onChanged: (p0) {
                setState(() {
                  index = p0;
                });
                controller.jumpToPage(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
