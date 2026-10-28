

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../Controller/auth/auth_controller.dart';
import '../../global_widgets/app_logo.dart';
import '../../global_widgets/custom_text.dart';
import '../../global_widgets/custom_text_button.dart';
import '../../global_widgets/custom_text_field.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_constant.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passTEController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppLogo(),
            Padding(
              padding: EdgeInsets.all(sizeH * .02),
              child: Form(
                key: formKey,
                child: AutofillGroup(
                  child: Column(
                    spacing: sizeH * .02,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: CustomTextOne(text: "Welcome back",color: AppColors.primaryColor,)),
                      Center(
                        child: CustomTextTwo(
                            text: "sign in to access your account"),
                      ),

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

                      ),

                      CustomTextField(
                        controller: passTEController,
                        autofillHints: const [AutofillHints.password],
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "Enter Password",
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password cannot be empty";
                          }
                          // if (value.length < 8) {
                          //   return "Password must be at least 8 characters";
                          // }
                          return null;
                        },

                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: StyleTextButton(
                          text: "Forget Password?",
                          textColor: Colors.red,
                          onTap: () {
                            Get.toNamed(AppRoutes.emailPassScreen);
                          },

                        ),
                      ),
                     Obx(() =>  CustomTextButton(
                       text:"Sign In",
                      color: AppColors.primaryColor,
                      isLoading: controller.logInLoading.value,
                       onTap: () {
                         if (formKey.currentState?.validate() ?? false) {
                           FocusScope.of(context).unfocus();
                           TextInput.finishAutofillContext(shouldSave: true);

                          controller.handleLogIn(emailTEController.text, passTEController.text);


                         }
                       },
                     ),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextTwo(text: "New Here?"),
                          StyleTextButton(text: "Sign Up", onTap: (){
                            Get.offAllNamed(AppRoutes.signUpScreen);
                          },textColor: AppColors.primaryColor)
                        ],
                      )


                      

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

