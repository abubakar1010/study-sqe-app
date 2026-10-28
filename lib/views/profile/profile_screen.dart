import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studysqet/views/profile/profile_update.dart';

import '../../Controller/profile/profile_controller.dart';
import '../../global_widgets/custom_text.dart';
import '../../global_widgets/dialog.dart';
import '../../helpers/prefs_helper.dart';
import '../../routes/app_routes.dart';
import '../../services/api_constants.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_images.dart';
import '../splash screen/onBoardingScreen.dart';
import 'setting/setting_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: sizeH * .015,
            children: [
              Padding(
                padding:  EdgeInsets.all(8.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image(
                        image: AssetImage(AppIcons.home,),
                        height: 30.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_none_outlined,
                        size: 20.h,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10.w,
                  children: [
                    CustomTextOne(
                      text: "MSQ Pack",
                      color: AppColors.cardBorderColor,
                    ),
                    CustomTextTwo(text: "Current Subscription"),

                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Obx((){
                  return CustomTextOne(
                    text: "${profileController.userName.value}",

                    maxLine: 1,
                    textOverflow: TextOverflow.ellipsis,
                    fontSize: 20.sp,
                  );
                })
              ),
        

        
        
        
        
        
              SizedBox(height: sizeH * .1),
              // Profile buttons
              _buildProfileOption(
                icon: Image.asset(AppIcons.profile, height: 18.h),
                label: 'General Info',
                onTap: () {
                  Get.to(() => ProfileUpdate());
                },
              ),
              Divider(
                  thickness: 1,
                  indent: 40,
                  endIndent: 40,
                  color: AppColors.cardBorderColor
              ),
              _buildProfileOption(
                icon: Image.asset(AppIcons.subscription, height: 18.h),
                label: 'Subscription Plans',
                onTap: () {
                  //Get.toNamed(AppRoutes.supportScreen);
                },
              ),
              Divider(
                  thickness: 1,
                  indent: 40,
                  endIndent: 40,
                  color: AppColors.cardBorderColor
              ),
              _buildProfileOption(
                icon: Image.asset(AppIcons.setting, height: 18.h),
                label: 'Settings',
                onTap: () {
                  Get.to(() => const SettingScreen());
                },
              ),
              Divider(
                  thickness: 1,
                  indent: 40,
                  endIndent: 40,
                  color: AppColors.cardBorderColor
              ),
              _buildProfileOption(
                icon: Image.asset(AppIcons.whatsapp, height: 18.h),
                label: 'Join Whatsapp',
                onTap: () {
                  //Get.toNamed(AppRoutes.supportScreen);
                },
              ),
              Divider(
                thickness: 1,
                indent: 40,
                endIndent: 40,
                color: AppColors.cardBorderColor
              ),
              _buildProfileOption(
                icon: Image.asset(AppIcons.support, height: 18.h),
                label: 'Support',
                onTap: () {
                  Get.toNamed(AppRoutes.supportScreen);
                },
              ),


              Divider(
                thickness: 1,
                indent: 40,
                endIndent: 40,
                  color: AppColors.cardBorderColor
              ),
              // Logout button
              _buildProfileOption(
                isTrue: true,
                icon: Image.asset(AppIcons.logOut, height: 18.h),
                label: 'Log Out',
                fillColor: AppColors.cardColor,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        title: "Are you sure you want to LogOut?",
                        subTitle: "You will be logged out of your account",
                        onCancel: () {
                          Get.back();
                        },
                        onConfirm: () async {
                          PrefsHelper.remove(AppConstants.isLogged);
                          PrefsHelper.remove(AppConstants.bearerToken);
                          PrefsHelper.remove(AppConstants.userId);
                          PrefsHelper.remove(AppConstants.firstTimeOnboarding);
                          Get.offAll(OnboardingScreen());
                        },
                      );
                    },
                  );
                },
              ),
              Divider(
                thickness: 1,
                indent: 40,
                endIndent: 40,
                  color: AppColors.cardBorderColor
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build the profile options
  Widget _buildProfileOption({
    required Widget icon,
    required String label,
    required VoidCallback onTap,
    Color? fillColor,
    final bool? isTrue,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),

          child: Row(
            children: [
              SizedBox(width: 10.w),
              icon,
              SizedBox(width: 20.w),
              CustomTextTwo(text: label),
              const Spacer(),
              isTrue == true
                  ? const Icon(null)
                  : Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18.h,
                      color: Colors.black,
                    ),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }
}
