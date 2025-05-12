import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/constants/app_text.dart';
import 'package:note_app/core/model/user_model.dart';
import 'package:note_app/helpers/custom_snackbar.dart';
import 'package:note_app/networks/firebase_services.dart';

class SignUpController extends GetxController {
  final box = GetStorage();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  RxBool isloading = false.obs;
  FirebaseServices firebaseServices = FirebaseServices();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<User?> signUp({
    required String name,
    required String emailAddress,
    required String password,
  }) async {
    try {
      isloading.value = true;
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      if (credential.user != null) {
        User user = credential.user!;
        UserModel userModel = UserModel(
          email: user.email ?? emailAddress,
          name: user.displayName ?? name,
          uid: user.uid,
        );
        await firebaseServices.createUser(
          userId: user.uid,
          userData: userModel.toJson(),
        );
        box.write(AppText.userUid, credential.user!.uid);
        return credential.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomSnackbar().failedSnackBar(message: e.toString());
      } else if (e.code == 'email-already-in-use') {
        CustomSnackbar().failedSnackBar(message: e.toString());
      }
    } catch (e) {
      CustomSnackbar().failedSnackBar(message: e.toString());
    }
    isloading.value = false;
    return null;
  }
}
