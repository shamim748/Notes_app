import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/features/splash/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashController(context),
      builder:
          (controller) => Scaffold(body: Center(child: Text("Splash screen"))),
    );
  }
}
