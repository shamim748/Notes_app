import 'package:get/get.dart';
import 'package:note_app/features/Add_or_update/controller/add_or_update_controller.dart';

class AddOrUpdateControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AddOrUpdateController());
  }
}
