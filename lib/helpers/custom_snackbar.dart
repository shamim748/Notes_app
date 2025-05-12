import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  successSnackBar({required String message}) {
    return Get.showSnackbar(
      GetSnackBar(
        title: "Success",
        message: message,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  failedSnackBar({required String message}) {
    return Get.showSnackbar(
      GetSnackBar(
        title: "Failed",
        message: message,
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
