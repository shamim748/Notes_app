import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/constants/app_text.dart';
import 'package:note_app/features/sign_up/controller/sign_up_controller.dart';

import 'package:note_app/features/signin/bindings/sign_in_controller_binding.dart';
import 'package:note_app/features/signin/controller/sign_in_controller.dart';
import 'package:note_app/helpers/custom_snackbar.dart';
import 'package:note_app/widgets/elevated_button.dart';
import 'package:note_app/widgets/text_button.dart';
import 'package:note_app/widgets/text_form_filed.dart';
import 'package:note_app/widgets/title_text.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    SignInControllerBinding().dependencies();
    SignInController controller = Get.find<SignInController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Caretutors"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: controller.signInFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleText(text: "Sign in"),
              const SizedBox(height: 20),
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
                width: double.infinity,
                labelText: 'Passowrd',
                hintText: 'Enter your password',
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
              const SizedBox(height: 20),
              Obx(
                () =>
                    controller.isloading.value
                        ? Center(child: CircularProgressIndicator())
                        : CustomElevatedButton(
                          text: "Sign in",
                          onPressed: () async {
                            if (controller.signInFormKey.currentState!
                                .validate()) {
                              User? user = await controller.signIn(
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
                            } else {
                              print("Form is not valid");
                            }
                          },
                        ),
              ),
              const SizedBox(height: 20),
              CustomTextButton(
                text: "Sign up here",
                onPressed: () {
                  Get.delete<SignUpController>();
                  context.push("/signup");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
