import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/features/home/controller/home_controller.dart';

class HomeControllerBindings implements Bindings {
  BuildContext context;
  HomeControllerBindings({required this.context});
  @override
  void dependencies() {
    Get.put(HomeController(context: context));
  }
}
