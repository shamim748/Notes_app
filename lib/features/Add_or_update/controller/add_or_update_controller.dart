import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/constants/app_text.dart';
import 'package:note_app/features/home/model/note_model.dart';
import 'package:note_app/helpers/custom_snackbar.dart';
import 'package:note_app/widgets/loading_dialog.dart';

class AddOrUpdateController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final box = GetStorage();
  final GlobalKey<FormState> updateformKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  String? userUid;
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<bool> saveNote({
    required BuildContext context,
    required String title,
    required String description,
  }) async {
    try {
      loadingDialog(context);
      userUid = box.read(AppText.userUid);
      if (userUid != null) {
        NoteModel noteModel = NoteModel(
          title: title,
          description: description,
          createdAt: Timestamp.now(),
          updatedAt: null,
          isPinned: null,
        );

        await FirebaseFirestore.instance
            .collection("users")
            .doc(userUid)
            .collection("notes")
            .doc()
            .set(noteModel.toJson());
      }

      if (context.mounted) {
        Navigator.pop(context);
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
      }
      CustomSnackbar().failedSnackBar(message: e.toString());
      return false;
    }
  }

  // Future<bool> deleteNote({
  //   required BuildContext context,
  //   required String noteId,
  // }) async {
  //   bool dialogOpen = false;
  //   try {
  //     loadingDialog(context);
  //     dialogOpen = true;

  //     userUid = box.read(AppText.userUid);
  //     if (userUid != null) {
  //       await FirebaseFirestore.instance
  //           .collection("users")
  //           .doc(userUid)
  //           .collection("notes")
  //           .doc(noteId)
  //           .delete();
  //     }

  //     return true;
  //   } catch (e) {
  //     CustomSnackbar.error(title: "Delete Error", message: e.toString());
  //     return false;
  //   } finally {
  //     if (dialogOpen && context.mounted) {
  //       Navigator.pop(context);
  //     }
  //   }
  // }
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
              CustomSnackbar().successSnackBar(message: "Success");
            });
      }
      return true;
    } catch (e) {
      CustomSnackbar().failedSnackBar(message: e.toString());
      return false;
    }
  }

  Future<bool> updateNote({
    required BuildContext context,
    required String noteId,
    required String title,
    required String description,
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
      CustomSnackbar().failedSnackBar(message: e.toString());
      return false;
    }
  }
}
