
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_images.dart';
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});


  List<PageViewModel> getPages() {

    return [

      PageViewModel(
        title: "",
        body: '“Success is the sum of small efforts, repeated day in and day out — little by little, it becomes a lot.”',
        decoration: PageDecoration(
          bodyTextStyle: TextStyle(color: AppColors.primaryColor,fontSize: 20.sp,fontStyle: FontStyle.italic),
          pageColor: AppColors.bgColor,
          bodyAlignment: Alignment.center, // Centering the text
          imageAlignment: Alignment.center, // Centering the image
          imagePadding: EdgeInsets.all(20.w),
        ),
      ),
      // Onboarding Page 2
      PageViewModel(
        title: "",
        body: '“Doing MCQs at spaced intervals boosts long-term retention by up to 50% — far more effective than reading — while training both recognition and recall.”',

        decoration: PageDecoration(
          bodyTextStyle: TextStyle(color: AppColors.primaryColor,fontSize: 20.sp,fontStyle: FontStyle.italic),
          pageColor: AppColors.bgColor,
          bodyAlignment: Alignment.center, // Centering the text
          imageAlignment: Alignment.center, // Centering the image
          imagePadding: EdgeInsets.all(20.w),
        ),
      ),
      // Onboarding Page 3
      PageViewModel(
        title: "",
        body: '“Progress tracking helps reduce the illusion of knowledge, leading to greater exam accuracy.”',

        decoration: PageDecoration(
          bodyTextStyle: TextStyle(color: AppColors.primaryColor,fontSize: 20.sp,fontStyle: FontStyle.italic),
          pageColor: AppColors.bgColor,
          bodyAlignment: Alignment.center, // Centering the text
          imageAlignment: Alignment.center, // Centering the image
          imagePadding: EdgeInsets.all(20.w),
        ),
      ),
      // Onboarding Page 4
      PageViewModel(
        title: "",
        body: '“Strive for progress, not perfection.”',

        decoration: PageDecoration(
          bodyTextStyle: TextStyle(color: AppColors.primaryColor,fontSize: 20.sp,fontStyle: FontStyle.italic),
          pageColor: AppColors.bgColor,
          bodyAlignment: Alignment.center, // Centering the text
          imageAlignment: Alignment.center, // Centering the image
          imagePadding: EdgeInsets.all(20.w),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: IntroductionScreen(
          pages: getPages(),
          onDone: () {
           Get.offAllNamed(AppRoutes.signInScreen);
            PrefsHelper.setString(AppConstants.firstTimeOnboarding, "true");
          },
          onSkip: () {
           Get.offAllNamed(AppRoutes.signInScreen);
            PrefsHelper.setString(AppConstants.firstTimeOnboarding, "true");
          },
          showSkipButton: true,
          skip: const Text("Skip"),
          next: const Icon(Icons.arrow_forward),
          done: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold)),
          dotsDecorator: DotsDecorator(
            size: Size(10.0.w, 10.0.h),
            color: AppColors.primaryColor.withOpacity(0.5),
            activeSize: Size(22.0.w, 10.0.h),
            activeColor: AppColors.primaryColor,
            spacing: EdgeInsets.symmetric(horizontal: 3.0.w),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }
}
