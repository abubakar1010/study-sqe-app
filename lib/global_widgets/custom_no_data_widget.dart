import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_images.dart';
import 'custom_text.dart';

class CustomNoDataWidget extends StatelessWidget {
  final String text;
  final double? imageHeight;
  const CustomNoDataWidget({
    super.key, required this.text,  this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(AppImages.emptyBox,height: imageHeight?? 300.h),
        SizedBox(height: 20.h,),
        CustomTextOne(text: text),
      ],
    );
  }
}