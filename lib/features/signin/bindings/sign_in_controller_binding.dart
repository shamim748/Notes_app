import 'package:get/get.dart';
import 'package:note_app/features/signin/controller/sign_in_controller.dart';

class SignInControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
  }
}
