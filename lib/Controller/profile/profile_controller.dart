
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/api_client.dart';
import '../../utils/urls.dart';

class ProfileController extends GetxController{

  var isLoading = true.obs;

  var userName = ''.obs;

  var email = ''.obs;
  var phone = '0000000000'.obs;
  var countryCode = 'GB'.obs;


  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }



  void fetchProfileData() async {
    try {
      isLoading(true);
      final response = await ApiClient.getData(Urls.getProfile);
      if (response.statusCode == 200) {
        final data = response.body['data'];

        userName.value = data['username'] ?? '';


        email.value = data['email'] ?? '';
        phone.value = data['phoneNumber'] ?? '';
        countryCode.value = data['countryCode'] ?? '';


      } else {
        Get.snackbar('!!!', response.body['message'] ?? 'Failed to load profile data');
      }
    } catch (e) {
     // Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }

  RxBool updateProfileLoading = false.obs;

void updateProfile (String name,String phone,countryCode) async {
  updateProfileLoading(true);

  var body={

    "username":name,
    "phoneNumber":phone,
    "countryCode":countryCode
  };
  var response=await ApiClient.patch(Urls.updateProfile,body);

  if(response.statusCode==200){
    updateProfileLoading(false);
    Get.snackbar('Success', response.body['message'] ?? 'Failed to load profile data');

  }else{
    Get.snackbar('!!!', response.body['message'] ?? 'Failed to load profile data');

  }
  updateProfileLoading(false);
}}