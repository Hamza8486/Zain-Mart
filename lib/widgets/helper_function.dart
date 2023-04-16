// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_text.dart';

import 'package:shared_preferences/shared_preferences.dart';


class HelperFunctions {


  static Future<File?> pickImage(ImageSource imageSource) async {
    File imageFile;
    final file = await ImagePicker().pickImage(source: imageSource,imageQuality: 25);
    if (file != null) {
      imageFile = File(file.path);
      return imageFile;
    } else {
      print("No image selected");
    }
    return null;
  }


  static saveInPreference(String preName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(preName, value);
    print('Bismillah: In save preference function');
  }

  static Future<String> getFromPreference(String preName) async {
    String returnValue = "";

    final prefs = await SharedPreferences.getInstance();
    returnValue = prefs.getString(preName) ?? "";
    return returnValue;
  }



  Future<bool>  clearPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    return true;
  }
}

Future<bool> signout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  return true;
}

Widget loader(){
  return Column(
    children: [
      SizedBox(
        height: Get.height * 0.35,
      ),
       Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.black26,
            valueColor: AlwaysStoppedAnimation<Color>(
                AppColor.primaryColor //<-- SEE HERE

            ),
          )),
    ],
  );
}
Widget noData(){
  return Column(children: [
    SizedBox(height: Get.height * 0.35),
    SvgPicture.asset(
      "assets/images/notfound.svg",
      height: Get.height * 0.05,
    ),
    SizedBox(height: Get.height * 0.015),
    Center(
        child: AppText(
          title: "No Record Found",
          size: Get.height * 0.014,
          color: AppColor.blackColor,
          fontFamily: AppFont.semi,
        )),
    SizedBox(height: Get.height * 0.01),
  ]);
}

Widget dropDownButtons(
    {value, onChanged, items, hinText, color, contentPadding, color1, color2,fontFamily ="regular",validator}) {
  return ButtonTheme(
    alignedDropdown: true,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: DropdownButtonFormField(
        menuMaxHeight: Get.height * 0.3,
        style: TextStyle(fontFamily: AppFont.medium,fontSize: AppSizes.size_13),
        icon: Icon(Icons
        .arrow_drop_down,color: AppColor.primaryColor,),
        validator: validator,


        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.transparent,
          filled: true,


          contentPadding: contentPadding,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: color),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: color),
          ),
        ),
        value: value,
        hint: SizedBox(
          width: Get.width*0.5,
          child: Text(
            hinText,
            maxLines: 1,
            style: TextStyle(
                color: color2,
                overflow: TextOverflow.ellipsis,
                fontFamily: fontFamily,
                fontSize: AppSizes.size_12),
          ),
        ),
        isExpanded: true,
        isDense: true,
        onChanged: onChanged,
        items: items),
  );
}