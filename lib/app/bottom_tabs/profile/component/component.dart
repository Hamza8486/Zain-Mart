import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_text.dart';

Widget profileWidget({onTap,image,color,text,Color?colorDiv,icon}){
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                Row(
                  children: [
                    icon,
                    SizedBox(width: Get.width*0.05,),

                    AppText(
                      title: text,
                      color: AppColor.blackColor,
                      size: AppSizes.size_14,
                      fontFamily: AppFont.medium,
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded,color: AppColor.greyColor,
                  size: AppSizes.size_14,)
              ],
            ),
          ),
        ),
        SizedBox(height: Get.height*0.008,),
        Divider(color:colorDiv?? AppColor.boldGreyColor,),
        SizedBox(height: Get.height*0.008,),
      ],
    ),
  );
}