
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../../Controller/profile/setting_controller.dart';
import '../../../global_widgets/custom_text.dart';
import '../../../utils/app_colors.dart';



class AppData extends StatelessWidget {
  final String type;
  const AppData({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final SettingController settingController = Get.put(SettingController());
    settingController.fetchAppData(type);
    var types=type.toLowerCase();
    String getAppTitle(String types) {
      switch (types) {
        case "privacy":
          return "Privacy Policy";
        case "terms":
          return "Terms & Conditions";
        case "about":
          return "About Us";
        default:
          return "Info";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title:CustomTextOne(
          text: getAppTitle(types),
          fontSize: 18.sp,
          color: AppColors.textColor,
        ),

      ),
      body: Obx(() {
        if (settingController.isLoadingAppData.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: EdgeInsets.all(sizeH * .02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextTwo(
                  text: 'Our ${getAppTitle(types)}',
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: sizeH * .02),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(

                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(sizeH * .016),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: sizeH * 0.7,
                    ),
                    child: SingleChildScrollView(
                      child: HtmlWidget(
                        settingController.appContent.value,
                        // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        textStyle: TextStyle(fontSize: 14.sp,color: AppColors.textColor),
                      ),
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
}
