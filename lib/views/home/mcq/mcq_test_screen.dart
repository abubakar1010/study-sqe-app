import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studysqet/Controller/home/mcq/mcq_controller.dart';
import 'package:studysqet/utils/app_colors.dart';
import '../../../global_widgets/custom_text_button.dart';
import '../../../global_widgets/custom_text.dart';

class McqTestScreen extends StatefulWidget {
  final String? areaId;
  final String? areaName;

  const McqTestScreen({super.key, this.areaId, this.areaName});

  @override
  _McqTestScreenState createState() => _McqTestScreenState();
}

class _McqTestScreenState extends State<McqTestScreen> {
  final McqController controller = Get.put(McqController());

  int questionCount = 10;
  int timePerQuestion = 60;

  void incrementQuestions() {
    setState(() {
      questionCount++;
    });
  }

  void decrementQuestions() {
    setState(() {
      if (questionCount > 0) {
        questionCount--;
      }
    });
  }

  void incrementTime() {
    setState(() {
      timePerQuestion += 10;
    });
  }

  void decrementTime() {
    setState(() {
      if (timePerQuestion > 10) {
        timePerQuestion -= 10;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextOne(text: widget.areaName ?? "MCQ Test"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextTwo(text: "How many questions do you want to answer?"),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: decrementQuestions,
                    child: Container(
                      height: 30.h,
                      width: 30.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.cardBorderColor),
                      ),
                      child: Icon(Icons.remove),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    height: 40.h,
                    width: 60.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.cardBorderColor),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: CustomTextOne(
                        text: questionCount.toString(),
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: incrementQuestions,
                    child: Container(
                      height: 30.h,
                      width: 30.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.cardBorderColor),
                      ),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              CustomTextTwo(text: "Add time per question (seconds)"),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: decrementTime,
                    child: Container(
                      height: 30.h,
                      width: 30.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.cardBorderColor),
                      ),
                      child: Icon(Icons.remove),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    height: 40.h,
                    width: 70.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.cardBorderColor),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: CustomTextOne(
                        text: "${timePerQuestion}s",
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: incrementTime,
                    child: Container(
                      height: 30.h,
                      width: 30.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.cardBorderColor),
                      ),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
        child: Obx(() {
          return CustomTextButton(
            text: "Start",
            color: Colors.white,
            borderColor: AppColors.cardBorderColor,
            textColor: AppColors.cardBorderColor,
            isLoading: controller.isCreatingSession.value,
            onTap: () {
              if (widget.areaId != null) {
                controller.createQuizSession(
                  questionCount,
                  timePerQuestion,
                  widget.areaId!,
                );
              }
            },
          );
        }),
      ),
    );
  }
}