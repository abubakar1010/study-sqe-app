import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studysqet/Controller/home/mcq/mcq_controller.dart';
import 'package:studysqet/global_widgets/custom_text.dart';
import 'package:studysqet/global_widgets/custom_text_button.dart';
import 'package:studysqet/utils/app_colors.dart';


import '../../../global_widgets/dialog.dart';

class McqScreen extends StatefulWidget {
  const McqScreen({super.key});

  @override
  _McqScreenState createState() => _McqScreenState();
}

class _McqScreenState extends State<McqScreen> {
  final McqController controller = Get.find<McqController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextOne(text: "MCQ Test"),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.currentQuestion.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final question = controller.currentQuestion.value!;
        final options = ['A', 'B', 'C', 'D', 'E'];

        return Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: StyleTextButton(
                  text: "Exit",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog(
                          title: "Are you sure you want to Exit?",
                          subTitle: "Your progress will be lost",
                          cancelButtonText: "Cancel",
                          confirmButtonText: "Exit",
                          onCancel: () {
                            Get.back();
                          },
                          onConfirm: () {
                            Get.back();
                            Get.back();
                            Get.back();
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextTwo(
                    text:
                    "${controller.currentQuestionNumber.value}/${controller.totalQuestions.value}",
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time),
                      SizedBox(width: 5.w),
                      CustomTextTwo(
                        text: "${controller.timeRemaining.value}s",
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.r),
              CustomTextTwo(
                text: question.title,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 30.r),
              ...List.generate(question.options.length, (index) {
                return _buildOption(
                  options[index],
                  question.options[index],
                  index,
                );
              }),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Obx(() {
                  return CustomTextButton(
                    text: "Submit Answer",
                    isLoading: controller.isSubmittingAnswer.value,
                    onTap: controller.selectedOption.value != null
                        ? () {
                      controller.submitAnswer(
                        controller.selectedOption.value,
                        'ANSWERED',
                      );
                    }
                        : (){},
                    color: controller.selectedOption.value != null
                        ? Colors.white
                        : Colors.grey,
                    textColor: AppColors.cardBorderColor,
                    borderColor: AppColors.cardBorderColor,
                    radius: 10.r,
                    borderWidth: 2,
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 2.h),
                child: Obx(() {
                  return CustomTextButton(
                    text: "Skip",
                    isLoading: controller.isSubmittingAnswer.value,
                    onTap: () {
                      controller.submitAnswer(null, 'SKIP');
                    },
                    color: Colors.transparent,
                    textColor: AppColors.textColor.withOpacity(0.5),
                    borderColor: AppColors.textColor.withOpacity(0.5),
                    radius: 10.r,
                  );
                }),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildOption(String option, String description, int index) {
    return Obx(() {
      return Row(
        children: [
          Radio<int>(
            value: index,
            groupValue: controller.selectedOption.value,
            activeColor: Colors.blue,
            onChanged: (int? value) {
              controller.selectedOption.value = value;
            },
          ),
          Flexible(child: CustomTextTwo(text: '$option. $description',textAlign: TextAlign.start,)),
        ],
      );
    });
  }
}