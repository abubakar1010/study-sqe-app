import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studysqet/Controller/home/faq/faq_controller.dart';
import 'package:studysqet/global_widgets/custom_text.dart';

import '../../../utils/app_icons.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FaqController controller = Get.put(FaqController());

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
                  CustomTextOne(text: "FAQ"),
                  CustomTextOne(text: ""),
                ],
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.topLeft,
                child: CustomTextOne(text: "Do you have any questions?"),
              ),
              SizedBox(height: 20.h),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (controller.faqs.isEmpty) {
                  return const Expanded(
                    child: Center(child: Text('No FAQs available')),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.faqs.length,
                    itemBuilder: (context, index) {
                      final faq = controller.faqs[index];
                      return InkWell(
                        onTap: () {
                          buildBottomSheet(faq.question, faq.answer);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.8)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(12.r)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 5.h,
                                  width: 5.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Flexible(
                                  child: CustomTextOne(
                                    text: faq.question,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildBottomSheet(String title, content) {
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextOne(
              text: title,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 20.h),
            Flexible(
              child: SingleChildScrollView(
                child: CustomTextTwo(
                  text: content,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}