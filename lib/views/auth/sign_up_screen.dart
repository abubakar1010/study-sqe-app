import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/auth/auth_controller.dart';
import '../../global_widgets/app_logo.dart';
import '../../global_widgets/custom_text.dart';
import '../../global_widgets/custom_text_button.dart';
import '../../global_widgets/custom_text_field.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_icons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userNameTEController = TextEditingController();



  final TextEditingController emailTEController = TextEditingController();

  final TextEditingController passTEController = TextEditingController();

  final TextEditingController confirmPassTEController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    RxBool check = false.obs;
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: sizeH*.05,),
            const AppLogo(),
            Padding(
              padding: EdgeInsets.all(sizeH * .02),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: sizeH * .02,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: CustomTextOne(text: "Get Started")),
                    Center(
                        child: CustomTextTwo(
                            text:
                                "By creating free account")),

                    //userName
                    CustomTextField(
                      controller: userNameTEController,
                      hintText: "Enter your Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "User Name cannot be empty";
                        }
                        return null;
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            left: sizeW * .03, right: sizeW * .01),
                        child: Icon(
                          Icons.person,
                          color: Colors.black
                        ),
                      ),
                    ),

                    //email
                    CustomTextField(
                      controller: emailTEController,
                      autofillHints: const [AutofillHints.email],
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter E-mail",
                      isEmail: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email cannot be empty";
                        }
                        if (!AppConstants.emailValidate.hasMatch(value)) {
                          return "Invalid email address";
                        }
                        return null;
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            left: sizeW * .03, right: sizeW * .01),
                        child: Image.asset(
                          AppIcons.email,
                          height: sizeH * .02,
                        ),
                      ),
                    ),
                    //password
                    CustomTextField(
                      controller: passTEController,
                      hintText: "Enter Password",
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (value.length < 8) {
                          return "Password must be at least 8 characters and include uppercase, lowercase, numbers, and special characters (e.g., Abc123@!)";
                        }
                        return null;
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            left: sizeW * .03, right: sizeW * .01),
                        child: Image.asset(
                          AppIcons.password,
                          height: sizeH * .02,
                        ),
                      ),
                    ),
                    //confirm password
                    CustomTextField(
                      controller: confirmPassTEController,
                      hintText: "Re-enter your password",
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm your password";
                        }
                        if (value != passTEController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            left: sizeW * .03, right: sizeW * .01),
                        child: Image.asset(
                          AppIcons.password,
                          height: sizeH * .02,
                        ),
                      ),
                    ),
                    Obx(() => Row(
                          children: [
                            Checkbox(
                              value: check.value,
                              checkColor: Colors.white,
                              activeColor: AppColors.primaryColor,
                              onChanged: (value) {
                                check.value = value!;
                              },
                            ),
                   Expanded(child: CustomTextTwo(text: "By checking the box you agree to our Terms and Conditions.",fontSize: sizeH*.013,textAlign: TextAlign.start,))
                          ],
                        )),

                    // sign up button
                    Obx(() => CustomTextButton(
                          text: "Register",
                          isLoading: controller.signUpLoading.value,
                      color: AppColors.primaryColor,
                          onTap: () {
                            if (formKey.currentState?.validate() ?? false) {
                              controller.handleSignUp(
                                emailTEController.text,
                                passTEController.text,
                                confirmPassTEController.text,
                                userNameTEController.text,
                              );

                            }
                          },
                        )),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomTextTwo(text: "Already have an account?"),
                        StyleTextButton(
                          text: "Login",
                          textDecoration: TextDecoration.underline,
                          textColor: AppColors.primaryColor,
                          onTap: () {
                            Get.offAllNamed(AppRoutes.signInScreen);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sizeH * .01,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameTEController.dispose();

    passTEController.dispose();
    emailTEController.dispose();
    confirmPassTEController.dispose();
  }
}
