import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';




class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  File ? file;
  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(

        body:  Padding(
          padding: AppPaddings.mainPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.035,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(onTap: (){
                    Navigator.pop(context);


                  }),

                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: AppText(
                      title: "About Us",
                      color: AppColor.blackColor,
                      size: AppSizes.size_16,
                      fontFamily: AppFont.semi,
                    ),
                  ),
                  SizedBox()
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),



              Expanded(
                  child:SingleChildScrollView(
                    child: Column(
                      children: [],
                    ),
                  )
              ),

            ],
          ),
        )

    );
  }
}



