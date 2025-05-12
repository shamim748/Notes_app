import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/constants/app_text.dart';
import 'package:note_app/features/home/model/note_model.dart';
import 'package:note_app/helpers/custom_snackbar.dart';
import 'package:note_app/widgets/loading_dialog.dart';

class HomeController extends GetxController {
  final RxList<NoteModel> notes = <NoteModel>[].obs;
  StreamSubscription? _notesSubscription;
  String? userUid;
  final box = GetStorage();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    listenToNotes();
  }

  void listenToNotes() {
    try {
      userUid = box.read(AppText.userUid);
      if (userUid == null) throw Exception("User UID not found");

      _notesSubscription?.cancel();

      _notesSubscription = FirebaseFirestore.instance
          .collection("users")
          .doc(userUid)
          .collection("notes")
          .orderBy("createdAt", descending: true)
          .snapshots()
          .listen(
            (querySnapshot) {
              try {
                notes.clear();
                for (var doc in querySnapshot.docs) {
                  notes.add(NoteModel.fromJson(doc.data())..id = doc.id);
                }
              } catch (e) {
                CustomSnackbar().failedSnackBar(message: e.toString());
              }
            },
            onError: (error) {
              CustomSnackbar().failedSnackBar(message: error.toString());
            },
          );
    } catch (e) {
      CustomSnackbar().failedSnackBar(message: e.toString());
    }
  }

  // Future<void> fetchNotes() async {
  //   try {
  //     isLoading.value = true;
  //     userUid = box.read(AppText.userUid);
  //     if (userUid != null) {
  //       QuerySnapshot querySnapshot =
  //           await FirebaseFirestore.instance
  //               .collection("users")
  //               .doc(userUid)
  //               .collection("notes")
  //               .get();
  //       if (querySnapshot.docs.isNotEmpty) {
  //         for (var doc in querySnapshot.docs) {
  //           NoteModel note = NoteModel.fromJson(
  //             doc.data() as Map<String, dynamic>,
  //           );
  //           notes.add(note);
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     CustomSnackbar.error(title: "Error", message: e.toString());
  //   }
  //   isLoading.value = false;
  // }

  @override
  void onClose() {
    _notesSubscription?.cancel();
    super.onClose();
  }
}
