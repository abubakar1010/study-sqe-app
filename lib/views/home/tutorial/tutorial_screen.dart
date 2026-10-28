import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studysqet/Controller/home/tutorial/tutorial_controller.dart';
import 'package:studysqet/global_widgets/custom_text.dart';
import 'package:studysqet/global_widgets/custom_text_button.dart';
import 'package:studysqet/utils/app_colors.dart';

class TutorialScreen extends StatelessWidget {
  final String? subjectId;
  final String? subjectName;

  const TutorialScreen({super.key, this.subjectId, this.subjectName});

  @override
  Widget build(BuildContext context) {
    final TutorialController controller = Get.put(TutorialController());

    // Initialize on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (subjectId != null && controller.tutorials.isEmpty) {
        controller.fetchTutorials(subjectId!);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: CustomTextOne(text: subjectName ?? "Tutorial"),
      ),
      body: Obx(() {
        if (controller.isLoadingTutorials.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        if (controller.tutorials.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_library_outlined,
                  size: 80.sp,
                  color: Colors.grey,
                ),
                SizedBox(height: 20.h),
                Text(
                  'No tutorials available',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        final currentTutorial =
        controller.tutorials[controller.currentTutorialIndex.value];

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Tutorial Title
                CustomTextOne(
                  text: currentTutorial.title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10.h),


                // Video Player Container
                Container(
                  height: 220.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Obx(() {
                      if (!controller.isPlayerInitialized.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      }

                      if (controller.chewieController == null) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 50.sp,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "Failed to load video",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 10.h),
                              ElevatedButton(
                                onPressed: () {
                                  controller.initializePlayer(
                                      currentTutorial.url);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                ),
                                child: Text("Retry"),
                              ),
                            ],
                          ),
                        );
                      }

                      return Chewie(controller: controller.chewieController!);
                    }),
                  ),
                ),
                SizedBox(height: 15.h),


                // Mark as complete button
                if (!currentTutorial.isComplete)
                  Obx(() {
                    return CustomTextButton(
                      text: "Mark as Complete",
                      isLoading: controller.isMarkingComplete.value,
                      onTap: () {
                        controller.markAsComplete(
                          currentTutorial.id,
                          controller.currentTutorialIndex.value,
                        );
                      },
                    );
                  })
                else
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle,
                            color: Colors.green, size: 20.sp),
                        SizedBox(width: 8.w),
                        CustomTextOne(
                          text: "Completed",
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 20.h),

                // Section Title
                CustomTextTwo(
                  text: "Following Lectures (${controller.tutorials.length})",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 16.h),

                // List of lectures
                Column(
                  children: List.generate(
                    controller.tutorials.length,
                        (index) => _buildLectureItem(
                      controller,
                      controller.tutorials[index],
                      index,
                      controller.currentTutorialIndex.value == index,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Custom Widget for Lecture Item
  Widget _buildLectureItem(
      TutorialController controller,
      Tutorial tutorial,
      int index,
      bool isCurrentlyPlaying,
      ) {
    bool isHLS = controller.isHLSVideo(tutorial.url);

    return InkWell(
      onTap: () {
        controller.playTutorial(index);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isCurrentlyPlaying
                ? AppColors.primaryColor.withOpacity(0.1)
                : AppColors.cardColor,
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            border: Border.all(
              color: isCurrentlyPlaying
                  ? AppColors.primaryColor
                  : AppColors.cardBorderColor,
              width: isCurrentlyPlaying ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // Thumbnail or play icon
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: isCurrentlyPlaying
                      ? AppColors.primaryColor
                      : Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      isCurrentlyPlaying
                          ? Icons.pause
                          : Icons.play_arrow_rounded,
                      color: isCurrentlyPlaying ? Colors.white : Colors.grey,
                      size: 35.sp,
                    ),
                    if (isHLS)
                      Positioned(
                        top: 4.h,
                        right: 4.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                          child: Text(
                            'HLS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),

              // Title and status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextOne(
                      text: tutorial.title,
                      fontSize: 14.sp,
                      color: AppColors.textColor,
                      fontWeight: isCurrentlyPlaying
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}