import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studysqet/global_widgets/custom_text.dart';
import 'package:studysqet/routes/app_routes.dart';
import 'package:studysqet/utils/app_colors.dart';
import 'package:studysqet/utils/app_icons.dart';

import '../../Controller/home/home_controller.dart';
import 'note/note_screen.dart';

import 'subject_area_screen.dart';
import 'tutorial/tutorial_screen.dart';

class SubjectScreen extends StatefulWidget {
  final String? subjectName;
  final String? type;

  const SubjectScreen({super.key, this.subjectName, this.type});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    if (widget.type == "flashCard") {
      controller.fetchSubjects(widget.subjectName ?? '', 'FLASHCARD');
    } else if (widget.type == "note") {
      controller.fetchSubjects(widget.subjectName ?? '', 'NOTE');
    } else if (widget.type == "mcq") {
      controller.fetchSubjects(widget.subjectName ?? '', 'MCQ');
    }else if (widget.type == "tutorial") {
      controller.fetchSubjects(widget.subjectName ?? '', 'TUTORIAL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                      Get.back();
                    },
                    child: Image(
                      image: AssetImage(AppIcons.home),
                      height: 30.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: CustomTextOne(
                      text: widget.subjectName == "E_AND_C"
                          ? "Ethics & Professional Conduct"
                          : widget.subjectName ?? "Unknown",
                    ),
                  ),
                  CustomTextOne(text: ""),
                ],
              ),
              SizedBox(height: 30.h),
              if (widget.type == "flashCard" || widget.type == "note" || widget.type == "mcq" || widget.type == "tutorial")
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (controller.subjects.isEmpty) {
                    return const Expanded(
                      child: Center(child: Text('No subjects available')),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.subjects.length,
                      itemBuilder: (context, index) {
                        final subject = controller.subjects[index];

                        return InkWell(
                          onTap: () {
                            if (widget.type == "flashCard") {
                              Get.to(() => SubjectAreaScreen(
                                subjectId: subject.id,
                                subjectName: subject.title,
                                type: widget.type,
                              ));
                            } else if (widget.type == "note") {
                              Get.to(() => NoteScreen(
                                subjectId: subject.id,
                                subjectName: subject.title,
                              ));
                            } else if (widget.type == "mcq") {
                              Get.to(() => SubjectAreaScreen(
                                subjectId: subject.id,
                                subjectName: subject.title,
                                type: widget.type,
                              ));
                            }

                            else if (widget.type == "tutorial") {
                              Get.to(() => TutorialScreen(
                                subjectId: subject.id,
                                subjectName: subject.title,
                              ));
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.cardColor,
                                border: Border.all(
                                  color: AppColors.cardBorderColor,
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: CustomTextOne(
                                      text: subject.title ?? '',
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.play_arrow),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                })
              else
              // Only for tutorial - no API call needed
                Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (widget.type == "tutorial") {
                            Get.toNamed(AppRoutes.tutorialScreen);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.cardColor,
                              border: Border.all(
                                color: index < 3
                                    ? AppColors.cardBorderColor
                                    : AppColors.blackColor,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomTextOne(
                                    text: "Property practice",
                                    fontSize: 14.sp,
                                    color: index < 3
                                        ? Colors.black
                                        : Colors.black.withOpacity(0.5),
                                  ),
                                ),
                                index < 3
                                    ? Icon(Icons.play_arrow)
                                    : Icon(Icons.lock),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}