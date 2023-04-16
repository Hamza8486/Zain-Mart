import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_text.dart';

class CountryCodeWid extends StatelessWidget {
  final TextEditingController phoneController;

  final Function(dynamic code) onPickCode;

  CountryCodeWid(
      {super.key, required this.phoneController,
      required this.onPickCode,
      required this.value});

  String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.06,
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColor.transParent,
          border: Border.all(color: AppColor.greyColor, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(width: Get.width*0.04,),
          AppText(title: "+92",
          color: AppColor.boldBlackColor,
            fontFamily: AppFont.medium,
            size: AppSizes.size_14,
          ),
          SizedBox(width: Get.width*0.02,),
          VerticalDivider(thickness: .5, color: AppColor.borderColorField),
          SizedBox(
            width: Get.width * 0.01,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide.none, bottom: BorderSide.none),
                ),
                child: TextFormField(
                  cursorColor: AppColor.primaryColor,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                      fontFamily: AppFont.medium,
                      fontSize: AppSizes.size_14,
                      fontWeight: FontWeight.w400),
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: phoneController,
                  // validator: (value) => value!.length < 8 ?  authController.updateValid(true) : null,

                  onChanged: (val) {
                    // if(val.length>8){
                    //   profileController.updateValid(false);
                    // }
                    // else{ profileController.updateValid(true);}
                  },

                  decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    hintStyle: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: AppSizes.size_12,
                      fontFamily: AppFont.medium,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
