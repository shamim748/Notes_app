import 'package:get/get.dart';
import 'package:note_app/features/sign_up/controller/sign_up_controller.dart';

class SignUpControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
  }
}
