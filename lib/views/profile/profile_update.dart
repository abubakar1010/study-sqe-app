
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../Controller/profile/profile_controller.dart';
import '../../global_widgets/custom_text.dart';
import '../../global_widgets/custom_text_button.dart';
import '../../global_widgets/custom_text_field.dart';



class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final ProfileController profileController = Get.put(ProfileController());

  late TextEditingController nameController;
  late TextEditingController emailTEController;
  late TextEditingController phoneCtrl;

  bool _controllersInitialized = false;






  @override
  void initState() {
    super.initState();
    // Initialize empty controllers
    nameController = TextEditingController();
    emailTEController = TextEditingController();
    phoneCtrl = TextEditingController();

    profileController.fetchProfileData();

    // Listen for data changes and update controllers only once
    ever(profileController.isLoading, (isLoading) {
      if (!isLoading && !_controllersInitialized) {
        nameController.text = profileController.userName.value;
        emailTEController.text = profileController.email.value;
        phoneCtrl.text = profileController.phone.value;
        _controllersInitialized = true;
      }
    });
  }




  @override
  Widget build(BuildContext context) {

    var countryCode =profileController.countryCode.value;


    final sizeH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Information Edit'),
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(sizeH * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: sizeH*.02,
            children: [

SizedBox(height: 20.h,),
              CustomTextTwo(text: "Your Name"),

              CustomTextField(
                controller: nameController,
                hintText: "Enter your Full Name",
              ),





              CustomTextTwo(text: "Your E-mail"),
              CustomTextField(
                readOnly: true,
                controller: emailTEController,
                hintText: "jaimulislam7@gmail.com",
              ),

               CustomTextTwo(text: "Phone No."),

              IntlPhoneField(
                controller: phoneCtrl,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
                initialCountryCode: countryCode,
                onChanged: (phone) {
                  print(phone.completeNumber);
                  profileController.countryCode.value = phone.countryISOCode;
                  print("==========$countryCode");
                },
                validator: (value) {
                  if (value == null || value.isNull) {
                    return "Phone number cannot be empty";
                  }
                  return null;
                },
              ),

              SizedBox(height: sizeH * 0.2),
              Obx(() {
                return CustomTextButton(
                  isLoading: profileController.updateProfileLoading.value,
                  text:"Save Change",
                  onTap:(){
               profileController.updateProfile(nameController.text,phoneCtrl.text,      profileController.countryCode.value);
                  }
                );
              }),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailTEController.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }
}
