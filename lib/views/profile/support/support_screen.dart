import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studysqet/routes/exports.dart';

import '../../../Controller/profile/setting_controller.dart';
import '../../../global_widgets/custom_text.dart';
import '../../../global_widgets/custom_text_button.dart';
import '../../../global_widgets/custom_text_field.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController subjectTEController=TextEditingController();
  final TextEditingController detailsTEController=TextEditingController();
  final SettingController settingController=SettingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: CustomTextOne(text: "Support"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15.h,
            children: [
              CustomTextOne(text: "Subject"),
              CustomTextField(controller:subjectTEController,hintText: "Enter the subject", ),
              CustomTextOne(text: "Description"),
              CustomTextField(controller:detailsTEController,hintText: "What issue are having with the app?", maxLine: 6),
             Obx((){
               return  CustomTextButton(
                   isLoading: settingController.supportLoading.value,
                   text: "Send to Support", onTap: (){

                 settingController.support(subjectTEController.text, detailsTEController.text);
               });
             })
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    subjectTEController.dispose();
    detailsTEController.dispose();
    super.dispose();
  }
}

