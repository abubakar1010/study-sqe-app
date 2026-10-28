import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:studysqet/Controller/home/mcq/mcq_controller.dart';
import 'package:studysqet/global_widgets/custom_text.dart';
import 'package:studysqet/global_widgets/custom_text_button.dart';
import 'package:studysqet/routes/app_routes.dart';
import '../../../utils/app_icons.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final McqController controller = Get.find<McqController>();

    return Obx(() {
      if (controller.quizResults.value == null) {
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final results = controller.quizResults.value!;
      final scorePercentage = results.accuracy / 100;
      final accuracyInt = results.accuracy.round(); // Round to integer for display

      Color gradientEndColor;
      if (results.accuracy >= 70) {
        gradientEndColor = Color(0xff7AAE3F);
      } else if (results.accuracy >= 50) {
        gradientEndColor = Color(0xffE45E25);
      } else {
        gradientEndColor = Color(0xffFF0707);
      }

      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Get.offAllNamed(AppRoutes.homeScreen);
                    },
                    child: Image(
                      image: AssetImage(AppIcons.home),
                      height: 30.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 100.h),
                CustomTextOne(
                  text: "You just completed this test.",
                ),
                SizedBox(height: 10.h),
                CustomTextTwo(text: "Here's your result."),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextOne(
                      text:
                      "${results.numberOfCorrectAnswer}/${results.numberOfQuestions}",
                      fontSize: 25.sp,
                    ),
                    CustomTextOne(
                      text: "$accuracyInt%",
                      fontSize: 25.sp,
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                LinearPercentIndicator(
                  lineHeight: 15.h,
                  percent: scorePercentage.clamp(0.0, 1.0), // Ensure it's between 0 and 1
                  backgroundColor: Colors.white,
                  progressColor: gradientEndColor,
                  barRadius: Radius.circular(8),
                ),
                SizedBox(height: 80.h),
                CustomTextButton(
                  text: "Retake",
                  onTap: () {
                    // Go back to MCQ test setup
                    Get.back();
                    Get.back();
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextButton(
                  text: "Exit",
                  onTap: () {
                    Get.offAllNamed(AppRoutes.homeScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}