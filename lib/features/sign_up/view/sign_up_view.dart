import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/constants/app_text.dart';
import 'package:note_app/features/sign_up/bindings/sign_up_controller_bindings.dart';
import 'package:note_app/features/sign_up/controller/sign_up_controller.dart';
import 'package:note_app/features/signin/controller/sign_in_controller.dart';
import 'package:note_app/helpers/custom_snackbar.dart';
import 'package:note_app/widgets/elevated_button.dart';
import 'package:note_app/widgets/text_button.dart';
import 'package:note_app/widgets/text_form_filed.dart';
import 'package:note_app/widgets/title_text.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpControllerBindings().dependencies();
    SignUpController controller = Get.find<SignUpController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Caretutors"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: controller.signUpFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleText(text: "Sign Up"),
              const SizedBox(height: 20),
              CustomTextFormField(
                width: double.infinity,
                labelText: 'Name',
                hintText: 'Enter your name',
                controller: controller.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email),
                filled: true,
                fillColor: Colors.grey[200],
              ),

              CustomTextFormField(
                width: double.infinity,
                labelText: 'Email',
                hintText: 'Enter your email',
                controller: controller.emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!AppText().emailRegExp.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email),
                filled: true,
                fillColor: Colors.grey[200],
              ),

              CustomTextFormField(
                obscureText: true,
                width: double.infinity,
                labelText: 'Password',
                hintText: 'Enter your passoword',
                controller: controller.passController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (!AppText().passwordRegExp.hasMatch(value)) {
                    return 'Password must be at least 6 characters and include a special character';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              Obx(
                () =>
                    controller.isloading.value
                        ? Center(child: CircularProgressIndicator())
                        : CustomElevatedButton(
                          text: "Sign up",
                          onPressed: () async {
                            if (controller.signUpFormKey.currentState!
                                .validate()) {
                              User? user = await controller.signUp(
                                name: controller.nameController.text,
                                emailAddress: controller.emailController.text,
                                password: controller.passController.text,
                              );
                              if (user != null && context.mounted) {
                                context.go("/home");
                              } else {
                                CustomSnackbar().failedSnackBar(
                                  message: "Failed try again",
                                );
                              }
                            }
                          },
                        ),
              ),
              const SizedBox(height: 20),
              CustomTextButton(
                text: "Sign in here",
                onPressed: () {
                  Get.delete<SignInController>();
                  context.push("/signin");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
