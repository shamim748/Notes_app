import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'package:note_app/features/Add_or_update/bindings/add_or_update_controller_bindings.dart';
import 'package:note_app/features/Add_or_update/controller/add_or_update_controller.dart';
import 'package:note_app/widgets/elevated_button.dart';
import 'package:note_app/widgets/text_form_filed.dart';

class AddOrUpdateView extends StatelessWidget {
  const AddOrUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    AddOrUpdateControllerBindings().dependencies();
    final AddOrUpdateController addOrUpdateController =
        Get.find<AddOrUpdateController>();
    return Scaffold(
      appBar: AppBar(title: Text("Edit Note")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              width: double.infinity,
              labelText: 'Title',
              hintText: 'Enter your title',
              controller: addOrUpdateController.titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,

              filled: false,
              fillColor: Colors.grey[200],
            ),
            CustomTextFormField(
              maxLines: 8,
              width: double.infinity,

              hintText: 'Enter your description',
              controller: addOrUpdateController.descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,

              filled: false,
              fillColor: Colors.grey[200],
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              width: double.infinity,
              text: "Save",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
