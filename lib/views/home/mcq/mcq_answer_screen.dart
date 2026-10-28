import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studysqet/Controller/home/mcq/mcq_controller.dart';
import 'package:studysqet/global_widgets/custom_text.dart';
import 'package:studysqet/global_widgets/custom_text_button.dart';

class McqAnswerScreen extends StatelessWidget {
  const McqAnswerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final McqController controller = Get.find<McqController>();
    final options = ['A', 'B', 'C', 'D', 'E'];

    return Scaffold(
      appBar: AppBar(
        title: CustomTextOne(text: "Answer Review"),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.currentAnswerReview.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final review = controller.currentAnswerReview.value!;
        final question = review.currentQuestion;
        final isCorrect = review.isCorrect;
        final wasSkipped = review.questionStatus == 'SKIP';

        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question
              CustomTextTwo(
                text: question.title,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 30.h),

              // Options with correct/incorrect highlighting
              ...List.generate(question.options.length, (index) {
                final isSelected = review.selectedOption == index;
                final isRightAnswer = question.rightOption == index;

                Color? backgroundColor;
                Color? borderColor;

                if (isRightAnswer) {
                  backgroundColor = Colors.green.withOpacity(0.1);
                  borderColor = Colors.green;
                } else if (isSelected && !isCorrect) {
                  backgroundColor = Colors.red.withOpacity(0.1);
                  borderColor = Colors.red;
                }

                return Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: backgroundColor ?? Colors.transparent,
                    border: Border.all(
                      color: borderColor ?? Colors.grey.withOpacity(0.3),
                      width: borderColor != null ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isRightAnswer
                              ? Colors.green
                              : (isSelected && !isCorrect)
                              ? Colors.red
                              : Colors.grey.withOpacity(0.3),
                        ),
                        child: Center(
                          child: CustomTextOne(
                            text: options[index],
                            color: (isRightAnswer || (isSelected && !isCorrect))
                                ? Colors.white
                                : Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Flexible(
                        child: CustomTextTwo(
                          text: question.options[index],
                          textAlign: TextAlign.start,
                        ),
                      ),
                      if (isRightAnswer)
                        Icon(Icons.check_circle, color: Colors.green, size: 24.sp),
                      if (isSelected && !isCorrect)
                        Icon(Icons.cancel, color: Colors.red, size: 24.sp),
                    ],
                  ),
                );
              }),

              SizedBox(height: 20.h),

              // Result message
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: wasSkipped
                      ? Colors.grey.withOpacity(0.1)
                      : isCorrect
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: wasSkipped
                        ? Colors.grey
                        : isCorrect
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextOne(
                      text: wasSkipped
                          ? "Skipped"
                          : isCorrect
                          ? "Correct!"
                          : "Incorrect",
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: wasSkipped
                          ? Colors.grey
                          : isCorrect
                          ? Colors.green
                          : Colors.red,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextTwo(
                      text: question.solution,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),

              Spacer(),

              CustomTextButton(
                text: "Next Question",
                onTap: () {
                  controller.loadNextQuestion();
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      }),
    );
  }
}