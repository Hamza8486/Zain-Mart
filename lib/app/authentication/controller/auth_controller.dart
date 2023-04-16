

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {


  var codeValue = "+92".obs;
  updateCodeValue(val){
    codeValue.value = val;
    update();
  }
  var lat;
  var lng;
  @override







  TextEditingController otpEditingController = TextEditingController();
  var messageOtpCode = ''.obs;

  TextEditingController otpController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneCheckController = TextEditingController();
  TextEditingController addressCheckController = TextEditingController();
  TextEditingController addressController = TextEditingController();

}
