import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import 'Controller/controller_bindings.dart';
import 'routes/app_routes.dart';
import 'services/api_constants.dart';
import 'themes/light_theme.dart';

void main() {
  if (ApiConstants.host.isEmpty) {
    throw StateError(
        "API_HOST is not set. Run with --dart-define-from-file=env.json (see README).");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          theme: light(),
          debugShowCheckedModeBanner: false,
          getPages: AppRoutes.routes,
          initialRoute: AppRoutes.homeScreen,
          initialBinding: ControllerBindings(),


          // builder: (context, child) {
          //   return Scaffold(body: NoInternetWrapper(child: child!));
          // },
        );
      },
    );
  }
}


