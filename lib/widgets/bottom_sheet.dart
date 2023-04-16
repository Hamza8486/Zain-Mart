


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_text.dart';


Widget bottomSheet({onCamera ,onGallery}) {
  return DraggableScrollableSheet(
    initialChildSize: 0.25,
    minChildSize: 0.25,
    maxChildSize: 0.25,
    builder: (_, controller) => Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Padding(
        padding:  EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                InkWell(
                    onTap: onGallery,
                    child: iconCreation(
                        Icons.insert_photo, AppColor.primaryColor, "Gallery")),
                SizedBox(width: Get.width*0.2,),
                InkWell(
                    onTap: onCamera,
                    child: iconCreation(
                        Icons.camera_alt,AppColor.primaryColor , "Camera")),
              ],
            ),
          ],
        ),
      ),
    ),
  );


}

Widget iconCreation(IconData icons, Color color, String text) {
  return Column(
    children: [
      CircleAvatar(
        radius: 24,
        backgroundColor: color,
        child: Icon(
          icons,
          // semanticLabel: "Help",
          size: 22,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      AppText(
          title: text,
          color: AppColor.primaryColor,
          fontFamily: AppFont.medium,
          size: 15)
    ],
  );
}
getShimmerAllLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
          height: Get.height * 0.11,
          width: Get.width,

        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [

              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 18.0,
                color: Colors.white,
              ),

            ],
          ),
        )
      ],
    ),
  );
}