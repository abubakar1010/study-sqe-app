import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:studysqet/global_widgets/app_logo.dart';
import 'package:studysqet/global_widgets/custom_text.dart';
import 'package:studysqet/routes/exports.dart';
import 'package:studysqet/utils/app_colors.dart';
import 'package:studysqet/utils/app_images.dart';
import 'package:studysqet/views/home/subject_screen.dart';

import '../../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(


      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            children: [
SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLogo(height: sizeH*.08,),
               Row(
                 children: [
                   IconButton(
                     onPressed: () {
                       Get.toNamed(AppRoutes.notificationScreen);
                     },
                     icon: Icon(Icons.notifications_none_outlined),
                   ),
                   InkWell(
                     onTap: (){
                       Get.toNamed(AppRoutes.profileScreen);
                     },
                     child: CircleAvatar(
                       backgroundImage: NetworkImage(AppImages.model),
                       radius: 20.r,
                     ),
                   ),
                 ],
               )
                ],
              ),
              SizedBox(height: 50.h,),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5.h,
                  // crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    buildInkWell(() {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: AppColors.bgColor,
                            title: Column(
                              children: [
                                buildContainer((){
                                  Get.to(()=> SubjectScreen(subjectName: "FLK1",type: "mcq",));
                                },"Flk1"),
                                buildContainer((){
                                  Get.to(()=> SubjectScreen(subjectName: "FLK2",type: "mcq",));
                                },"Flk2"),
                                buildContainer((){
                                  Get.to(()=> SubjectScreen(subjectName: "Ethics & Professional Conduct",type: "mcq",));
                                },"Ethics & Professional Conduct"),
                              ],
                            ),
                          );
                        },
                      );
                    }, AppImages.home1,context),
                    buildInkWell(() {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: AppColors.bgColor,
                            title: Column(
                              children: [
                                buildContainer((){
                                  Get.to(()=> SubjectScreen(subjectName: "FLK1",type: "flashCard",));
                                },"Flk1"),
                                buildContainer((){
                                  Get.to(()=> SubjectScreen(subjectName: "FLK2",type: "flashCard",));
                                },"Flk2"),
                                buildContainer((){
                                  Get.to(()=> SubjectScreen(subjectName: "E_AND_C",type: "flashCard",));
                                },"Ethics & Professional Conduct"),
                              ],
                            ),
                          );
                        },
                      );
                    }, AppImages.home2,context),
                    buildInkWell(() {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: AppColors.bgColor,
                            title: Column(
                              children: [
                                buildContainer((){
                                  Get.to(()=> SubjectScreen(subjectName: "FLK1",type: "note",));
                                },"Flk1"),
                                buildContainer((){
                                  Get.to(()=> SubjectScreen(subjectName: "FLK2",type: "note",));
                                },"Flk2"),
                              ],
                            ),
                          );
                        },
                      );
                    }, AppImages.home3,context),
                    buildInkWell(() {
                      Get.to(()=> SubjectScreen(subjectName: "Tutorial",type: "tutorial",));
                    }, AppImages.home4,context),
                    buildInkWell(() {
                      Get.toNamed(AppRoutes.progressScreen);

                    }, AppImages.home5,context),
                    buildInkWell(() {
                      Get.toNamed(AppRoutes.faqScreen);
                    }, AppImages.home6,context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainer(VoidCallback onTap,String data) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 5.h),
        child: Container(
          padding: EdgeInsets.all(5.h),

                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          border: Border.all(
                            color: AppColors.cardBorderColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child: CustomTextOne(text: data)),
                                Icon(Icons.arrow_forward_ios_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),
      ),
    );
  }

  Widget buildInkWell(VoidCallback onTap, String image,BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(2.h),
      child: InkWell(
        onTap: onTap,
        child: Image(image: AssetImage(image), height: sizeH*.2),
      ),
    );
  }
}
