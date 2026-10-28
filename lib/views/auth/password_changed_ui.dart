
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import '../../global_widgets/app_logo.dart';
import '../../global_widgets/custom_text.dart';
import '../../global_widgets/custom_text_button.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
class PasswordChangedUi extends StatelessWidget {
  const PasswordChangedUi({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
    body: SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.all(sizeH*.02),
        child: Column(
          spacing: sizeH*.025,
          children: [
            AppLogo(height: sizeH*.15,),
            CustomTextOne(text: "Password Changed",),
            CustomTextTwo(text: "Your password has been changed successfully"),
            SvgPicture.asset(
              AppImages.passChange,
              fit: BoxFit.cover,
            ),
            SizedBox(height: sizeH*.02,),
            CustomTextButton(text: "Back to Log In ",                color: AppColors.primaryColor,onTap: (){
              Get.offAllNamed(AppRoutes.signInScreen);
            })
          ],
        ),
      ),
    ),

    );
  }
}
