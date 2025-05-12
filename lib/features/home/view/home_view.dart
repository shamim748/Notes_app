import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/features/Add_or_update/bindings/add_or_update_controller_bindings.dart';
import 'package:note_app/features/Add_or_update/controller/add_or_update_controller.dart';
import 'package:note_app/features/home/bindings/home_controller_bindings.dart';
import 'package:note_app/features/home/controller/home_controller.dart';
import 'package:note_app/features/home/model/note_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControllerBindings().dependencies();
    AddOrUpdateControllerBindings().dependencies();

    final HomeController controller = Get.find<HomeController>();
    final AddOrUpdateController addOrUpdateController =
        Get.find<AddOrUpdateController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addOrUpdateController.titleController.clear();
          addOrUpdateController.descriptionController.clear();
          context.push("/update", extra: {"isUpdate": false});
        },
        label: Text("Add new note"),
      ),
      appBar: AppBar(title: Text("Your Notes")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.notes.isEmpty) {
          return const Center(child: Text("You have no notes"));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.notes.length,
            itemBuilder: (context, index) {
              NoteModel note = controller.notes[index];
              return ListTile(
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          addOrUpdateController.titleController.text =
                              note.title;
                          addOrUpdateController.descriptionController.text =
                              note.description;
                          context.push(
                            "/update",
                            extra: {"isUpdate": true, "id": note.id},
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () async {
                          bool success = await addOrUpdateController.deleteNote(
                            context: context,
                            noteId: note.id!,
                          );
                          if (success) {
                            controller.notes.removeWhere(
                              (n) => n.id == note.id,
                            );
                          }
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
                title: Text(note.title),
                subtitle: Text(note.description),
              );
            },
          );
        }
      }),
    );
  }
}
