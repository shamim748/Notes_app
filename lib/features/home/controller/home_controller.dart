import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/constants/app_text.dart';
import 'package:note_app/features/home/model/note_model.dart';
import 'package:note_app/helpers/custom_snackbar.dart';

class HomeController extends GetxController {
  BuildContext context;
  HomeController({required this.context});
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
                if (context.mounted) {
                  CustomSnackbar().failedSnackBar(
                    context: context,
                    message: e.toString(),
                  );
                }
              }
            },
            onError: (error) {
              if (context.mounted) {
                CustomSnackbar().failedSnackBar(
                  context: context,
                  message: error.toString(),
                );
              }
            },
          );
    } catch (e) {
      if (context.mounted) {
        CustomSnackbar().failedSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        context.go("/signin");
        Get.deleteAll();
        await GetStorage().erase();
      }
    } catch (e) {
      print("Logout failed: $e");
    }
  }

  @override
  void onClose() {
    _notesSubscription?.cancel();
    super.onClose();
  }
}
