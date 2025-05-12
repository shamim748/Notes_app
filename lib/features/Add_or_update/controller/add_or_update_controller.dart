import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/constants/app_text.dart';
import 'package:note_app/constants/note_background_color.dart';
import 'package:note_app/features/home/model/note_model.dart';
import 'package:note_app/helpers/custom_snackbar.dart';
import 'package:note_app/widgets/loading_dialog.dart';

class AddOrUpdateController extends GetxController {
  final box = GetStorage();
  final GlobalKey<FormState> updateformKey = GlobalKey<FormState>();
  RxString selectedColor = noteBgcolors[0].obs;
  var isPinned = false.obs;
  // Rx<Color?> selectedColor = Rx(null);

  void changeColor(String color) {
    selectedColor.value = color;
  }

  void loadData(NoteModel? noteModel) {
    if (noteModel != null) {
      selectedColor.value = noteModel.backgroundColor;
    }
    if (noteModel != null) {
      isPinned.value = noteModel.isPinned;
    } else {
      isPinned.value = false;
    }
  }

  RxBool isLoading = false.obs;
  String? userUid;

  Future<bool> saveNote({
    required String backgroundColor,
    required BuildContext context,
    required String title,
    required String description,
    required bool isPinned,
  }) async {
    try {
      loadingDialog(context);
      userUid = box.read(AppText.userUid);
      if (userUid != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userUid)
            .collection("notes")
            .doc()
            .set({
              "title": title,
              "description": description,
              "createdAt": Timestamp.now(),
              "updatedAt": null,
              "isPinned": isPinned,
              "bgColor": backgroundColor,
            });
      }

      if (context.mounted) {
        Navigator.pop(context);
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
      }
      return false;
    }
  }

  Future<bool> deleteNote({
    required BuildContext context,
    required String noteId,
  }) async {
    try {
      userUid = box.read(AppText.userUid);
      if (userUid != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userUid)
            .collection("notes")
            .doc(noteId)
            .delete()
            .whenComplete(() {
              if (context.mounted) {
                CustomSnackbar().successSnackBar(
                  context: context,
                  message: "Success",
                );
              }
            });
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        CustomSnackbar().failedSnackBar(
          context: context,
          message: e.toString(),
        );
      }

      return false;
    }
  }

  Future<bool> updateNote({
    required String noteId,
    required BuildContext context,
    required String title,
    required String description,
    required bool isPinned,
    required String backgroundColor,
  }) async {
    try {
      loadingDialog(context);
      userUid = box.read(AppText.userUid);
      if (userUid != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userUid)
            .collection("notes")
            .doc(noteId)
            .update({
              "title": title,
              "description": description,
              "updatedAt": Timestamp.now(),
              "isPinned": isPinned,
              "bgColor": backgroundColor,
            });
      }

      if (context.mounted) {
        Navigator.pop(context);
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
      }
      if (context.mounted) {
        CustomSnackbar().failedSnackBar(
          context: context,
          message: e.toString(),
        );
      }
      return false;
    }
  }
}
