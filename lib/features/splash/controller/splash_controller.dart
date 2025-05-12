import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/constants/app_text.dart';

class SplashController extends GetxController {
  BuildContext context;
  SplashController(this.context);
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Timer(const Duration(seconds: 3), () {
      if (box.read(AppText.userUid) == null) {
        context.go("/signin");
      } else {
        context.go("/home");
      }
    });
  }
}
