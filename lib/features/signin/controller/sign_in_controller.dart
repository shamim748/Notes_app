import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/constants/app_text.dart';
import 'package:note_app/core/model/user_model.dart';
import 'package:note_app/helpers/custom_snackbar.dart';

class SignInController extends GetxController {
  final box = GetStorage();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  RxBool isloading = false.obs;
  UserModel? userModel;
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<User?> signIn({
    required String emailAddress,
    required String password,
  }) async {
    try {
      isloading.value = true;

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      if (credential.user != null) {
        box.write(AppText.userUid, credential.user!.uid);
        return credential.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomSnackbar().failedSnackBar(message: e.toString());
      } else if (e.code == 'wrong-password') {
        CustomSnackbar().failedSnackBar(message: e.toString());
      } else {
        CustomSnackbar().failedSnackBar(message: e.toString());
      }
    } catch (e) {
      CustomSnackbar().failedSnackBar(message: e.toString());
    } finally {
      isloading.value = false;
    }
    return null;
  }
}
