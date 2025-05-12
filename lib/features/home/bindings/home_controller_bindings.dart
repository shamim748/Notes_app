import 'package:get/get.dart';
import 'package:note_app/features/home/controller/home_controller.dart';

class HomeControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
