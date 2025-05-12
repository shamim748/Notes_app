import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'package:note_app/features/Add_or_update/bindings/add_or_update_controller_bindings.dart';
import 'package:note_app/features/Add_or_update/controller/add_or_update_controller.dart';
import 'package:note_app/helpers/custom_snackbar.dart';
import 'package:note_app/widgets/elevated_button.dart';
import 'package:note_app/widgets/text_form_filed.dart';

// class AddOrUpdateView extends StatelessWidget {
//   final bool isUpdate;
//   final String? noteId;
//   const AddOrUpdateView({this.noteId, required this.isUpdate, super.key});

//   @override
//   Widget build(BuildContext context) {
//     AddOrUpdateControllerBindings().dependencies();
//     final AddOrUpdateController controller = Get.find<AddOrUpdateController>();
//     return Scaffold(
//       appBar: AppBar(title: Text("Edit Note")),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Form(
//           autovalidateMode: AutovalidateMode.always,
//           key: controller.updateformKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomTextFormField(
//                 width: double.infinity,
//                 labelText: 'Title',
//                 hintText: 'Enter your title',
//                 controller: controller.titleController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Email is required';
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.emailAddress,

//                 filled: false,
//                 fillColor: Colors.grey[200],
//               ),
//               CustomTextFormField(
//                 maxLines: 8,
//                 width: double.infinity,

//                 hintText: 'Enter your description',
//                 controller: controller.descriptionController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Email is required';
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.emailAddress,

//                 filled: false,
//                 fillColor: Colors.grey[200],
//               ),
//               const SizedBox(height: 20),
//               CustomElevatedButton(
//                 width: double.infinity,
//                 text: isUpdate ? "Update" : "Save",
//                 onPressed: () async {
//                   if (controller.updateformKey.currentState!.validate()) {
//                     isUpdate == false
//                         ? await controller.saveNote(
//                           context: context,
//                           title: controller.titleController.text,
//                           description: controller.descriptionController.text,
//                         )
//                         : await controller.updateNote(
//                           context: context,
//                           noteId: noteId!,
//                           title: controller.titleController.text,
//                           description: controller.descriptionController.text,
//                         );
//                     controller.titleController.clear();
//                     controller.descriptionController.clear();
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import your controller

class AddOrUpdateView extends StatelessWidget {
  final Map<String, dynamic> data;
  AddOrUpdateView({super.key, required this.data});

  final AddOrUpdateController controller = Get.put(AddOrUpdateController());

  final List<Color> colors = [
    Colors.white,
    Colors.red.shade300,
    Colors.orange,
    Colors.yellow.shade200,
    Colors.green.shade200,
    Colors.cyan.shade200,
    Colors.brown.shade200,
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(
      text: data["title"] ?? "Add title",
    );
    final TextEditingController contentController = TextEditingController(
      text: data["description"] ?? "Add description",
    );
    return Obx(
      () => Scaffold(
        backgroundColor: controller.selectedColor.value,
        appBar: AppBar(
          backgroundColor: controller.selectedColor.value,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "Edit Note",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.save, color: Colors.black),
              onPressed: () {
                // Save logic
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.black),
              onPressed: () {
                // Delete logic
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.push_pin_outlined),
                ),
              ),

              SizedBox(height: 8),
              // Color selection
              Row(
                children:
                    colors.map((color) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: GestureDetector(
                          onTap: () => controller.changeColor(color),
                          child: Obx(() {
                            bool isSelected =
                                controller.selectedColor.value == color;
                            return CircleAvatar(
                              radius: 18,
                              backgroundColor: color,
                              child:
                                  isSelected
                                      ? Icon(Icons.check, color: Colors.black)
                                      : null,
                            );
                          }),
                        ),
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),
              // Title field
              TextField(
                controller: titleController,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                decoration: InputDecoration(border: InputBorder.none),
              ),
              // Content field
              TextField(
                controller: contentController,
                maxLines: null,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
