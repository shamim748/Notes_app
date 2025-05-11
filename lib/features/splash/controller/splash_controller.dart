import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:go_router/go_router.dart';

class SplashController extends GetxController {
  BuildContext context;
  SplashController(this.context);

  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Timer(const Duration(seconds: 3), () {
      context.go("/signin");
    });
  }
}
