import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/constants/note_background_color.dart';
import 'package:note_app/features/Add_or_update/controller/add_or_update_controller.dart';
import 'package:note_app/features/home/model/note_model.dart';

import 'package:get/get.dart';
import 'package:note_app/helpers/helper.dart';
// import your controller

class AddOrUpdateView extends StatelessWidget {
  final NoteModel? noteModel;
  AddOrUpdateView({super.key, required this.noteModel});

  final AddOrUpdateController controller = Get.put(AddOrUpdateController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadData(noteModel);
    });
    TextEditingController titleController = TextEditingController(
      text: noteModel == null ? "Add title" : noteModel!.title,
    );
    final TextEditingController contentController = TextEditingController(
      text: noteModel == null ? "Add description" : noteModel!.description,
    );
    return Obx(
      () => Scaffold(
        backgroundColor: Helper().colorFromHex(controller.selectedColor.value),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Helper().colorFromHex(
            controller.selectedColor.value,
          ),
          elevation: 0,

          title: Text(
            "Edit Note",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.save, color: Colors.black),
              onPressed: () async {
                if (noteModel != null && noteModel!.id != null) {
                  await controller.updateNote(
                    noteId: noteModel!.id!,
                    context: context,
                    title: titleController.text,
                    description: contentController.text,
                    isPinned: controller.isPinned.value,

                    backgroundColor: controller.selectedColor.value,
                  );
                } else {
                  await controller.saveNote(
                    backgroundColor: controller.selectedColor.value,
                    context: context,
                    title: titleController.text,
                    description: contentController.text,
                    isPinned: controller.isPinned.value,
                  );
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.black),
              onPressed: () async {
                if (noteModel != null && noteModel!.id != null) {
                  await controller
                      .deleteNote(context: context, noteId: noteModel!.id!)
                      .then((val) {
                        if (val == true) {
                          if (context.mounted) {
                            context.pop();
                          }
                        }
                      });
                }
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
                  onPressed: () {
                    controller.isPinned.value = !controller.isPinned.value;
                  },
                  icon: Icon(
                    Icons.push_pin_outlined,
                    color:
                        controller.isPinned.value ? Colors.orange : Colors.grey,
                  ),
                ),
              ),

              SizedBox(height: 8),
              // Color selection
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      noteBgcolors.map((color) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () => controller.changeColor(color),
                            child: Obx(() {
                              bool isSelected =
                                  controller.selectedColor.value == color;
                              return CircleAvatar(
                                radius: 18,
                                backgroundColor: Helper().colorFromHex(color),
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
