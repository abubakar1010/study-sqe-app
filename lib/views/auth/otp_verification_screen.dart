

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Controller/auth/auth_controller.dart';
import '../../global_widgets/app_logo.dart';
import '../../global_widgets/custom_pin_code_textfiled.dart';
import '../../global_widgets/custom_text.dart';
import '../../global_widgets/custom_text_button.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_colors.dart';

class OtpVerificationScreen extends StatelessWidget {
  final bool? isFormForget;
  final String? email;
   OtpVerificationScreen({
    super.key,
    this.isFormForget,
    this.email,
  });
  final TextEditingController otpTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    final sizeH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppLogo(),

            Padding(
              padding: EdgeInsets.all(sizeH * .016),
              child: Column(
                spacing: sizeH * .04,
                children: [

                  Center(child: CustomTextOne(text: "Enter Verification Code.",)),
                  Center(
                    child: CustomTextTwo(
                        text:
                            "Please enter the 6 digit verification code sent to your e-mail"),
                  ),
                  CustomPinCodeTextField(
                    textEditingController: otpTEController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StyleTextButton(
                          text: "Didn’t receive the code?",
                          textColor: AppColors.textColor,
                          onTap: () {
                          }),
                      StyleTextButton(
                          text: "Resend",
                          textColor: AppColors.primaryColor,
                          textDecoration: TextDecoration.underline,

                          onTap: () {
                           controller.reSendOtp(email!,isFormForget!);
                          }),
                    ],
                  ),
                  SizedBox(
                    height: sizeH * .03,
                  ),
                 Obx(() =>  CustomTextButton(
                     text:"Verify",
                     color: AppColors.primaryColor,
                     isLoading: controller.verifyLoading.value,
                     onTap: () {

                         controller.verifyOtp(
                             otpTEController.text, email,isFormForget!);



                     }),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
