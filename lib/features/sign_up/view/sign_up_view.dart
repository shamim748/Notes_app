import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/constants/app_text.dart';
import 'package:note_app/features/sign_up/bindings/sign_up_controller_bindings.dart';
import 'package:note_app/features/sign_up/controller/sign_up_controller.dart';
import 'package:note_app/helpers/custom_snackbar.dart';
import 'package:note_app/widgets/elevated_button.dart';
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
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          "Caretutors",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: controller.signUpFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText(text: "Sign Up"),
                const SizedBox(height: 60),
                Text(
                  "First create your account",
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 60),

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
                  prefixIcon: const Icon(Icons.abc_rounded),
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

                Obx(
                  () => CustomTextFormField(
                    obscureText: controller.obscureTextPassword.value,
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
                    prefixIcon: IconButton(
                      onPressed: () {
                        controller.obscureTextPassword.value =
                            !controller.obscureTextPassword.value;
                      },
                      icon: Icon(
                        controller.obscureTextPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                Obx(
                  () => CustomTextFormField(
                    obscureText: controller.obscureTextConfirmPassword.value,
                    width: double.infinity,
                    labelText: 'Confirm Password',
                    hintText: 'Enter your passoword again',
                    controller: controller.confirmPassController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      } else if (!AppText().passwordRegExp.hasMatch(value)) {
                        return 'Password must be at least 6 characters and include a special character';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    prefixIcon: IconButton(
                      onPressed: () {
                        controller.obscureTextConfirmPassword.value =
                            !controller.obscureTextConfirmPassword.value;
                      },
                      icon: Icon(
                        controller.obscureTextConfirmPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
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
                                if (controller.passController.text ==
                                    controller.confirmPassController.text) {
                                  User? user = await controller.signUp(
                                    context: context,
                                    name: controller.nameController.text,
                                    emailAddress:
                                        controller.emailController.text,
                                    password: controller.passController.text,
                                  );
                                  if (user != null && context.mounted) {
                                    context.go("/home");
                                  } else {
                                    if (context.mounted) {
                                      CustomSnackbar().failedSnackBar(
                                        context: context,
                                        message: "Failed try again",
                                      );
                                    }
                                  }
                                } else {
                                  if (context.mounted) {
                                    CustomSnackbar().failedSnackBar(
                                      context: context,
                                      message:
                                          "Password and confirm password are not same",
                                    );
                                  }
                                }
                              }
                            },
                          ),
                ),
                const SizedBox(height: 20),
                // CustomTextButton(
                //   text: "Sign in here",
                //   onPressed: () {
                //     Get.delete<SignInController>();
                //     context.push("/signin");
                //   },
                // ),
                Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Sign In",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.delete<SignUpController>();
                                context.push("/signin");
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
