import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../global_widgets/app_logo.dart';
import '../../helpers/prefs_helper.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? logged;

  @override
  void initState() {
    super.initState();
    getData();
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.onboardingScreen);
     if(logged=="true"){
      // Get.offAllNamed(AppRoutes.homeScreen);
     }else{
       Get.offAllNamed(AppRoutes.onboardingScreen);
     }
    });
  }

  void getData() async {
    logged = await PrefsHelper.getString(AppConstants.isLogged);
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: AppLogo(
              height: sizeH * .7,
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeH * .04),
              child: CircularProgressIndicator(color: AppColors.cardBorderColor,),
            ),
          ],
        ));
  }
}
