import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studysqet/global_widgets/custom_text.dart';
import 'package:studysqet/routes/app_routes.dart';
import 'package:studysqet/utils/app_colors.dart';
import 'package:studysqet/utils/app_icons.dart';

import '../../Controller/home/flashcard/flashcard_controller.dart';
import 'flash card/flash_card.dart';
import 'mcq/mcq_test_screen.dart';

class SubjectAreaScreen extends StatefulWidget {
  final String? subjectId;
  final String? subjectName;
  final String? type;

  const SubjectAreaScreen({
    super.key,
    this.subjectId,
    this.subjectName,
    this.type,
  });

  @override
  State<SubjectAreaScreen> createState() => _SubjectAreaScreenState();
}

class _SubjectAreaScreenState extends State<SubjectAreaScreen> {
  final FlashcardController controller = Get.put(FlashcardController());

  @override
  void initState() {
    super.initState();
    controller.fetchSubjectAreas(widget.subjectId ?? '');
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
                    },
                    child: Image(
                      image: AssetImage(AppIcons.home),
                      height: 30.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: CustomTextOne(text: widget.subjectName ?? "Unknown"),
                  ),
                  CustomTextOne(text: ""),
                ],
              ),
              SizedBox(height: 30.h),
              Obx(() {
                if (controller.isLoadingAreas.value) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (controller.subjectAreas.isEmpty) {
                  return const Expanded(
                    child: Center(child: Text('No areas available')),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.subjectAreas.length,
                    itemBuilder: (context, index) {
                      final area = controller.subjectAreas[index];
                      return InkWell(
                        onTap: () {
                          if (widget.type == "flashCard") {
                            Get.to(() => FlashCardScreen(areaId: area.id));
                          } else if (widget.type == "mcq") {
                            Get.to(() => McqTestScreen(
                              areaId: area.id,
                              areaName: area.title,
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
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomTextOne(
                                    text: area.title,
                                    fontSize: 14.sp,
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
              }),
            ],
          ),
        ),
      ),
    );
  }
}