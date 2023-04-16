
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';




class BankDetail extends StatefulWidget {
  const BankDetail({Key? key}) : super(key: key);

  @override
  State<BankDetail> createState() => _BankDetailState();
}

class _BankDetailState extends State<BankDetail> {


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
                      title: "Bank Detail",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AppText(title: "Bank Detail",size: AppSizes.size_14,
                        fontFamily: AppFont.semi,
                          color: AppColor.blackColor,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                    SizedBox(
                      width: Get.width,
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: AppColor.whiteColor,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: AppColor.borderColorField)),
                        child:Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  AppText(title: "Bank Name",size: AppSizes.size_14,
                                    fontFamily: AppFont.regular,
                                    color: AppColor.blackColor,
                                  ),
                                  SizedBox(width: Get.width*0.03,),
                                  AppText(title: "Alflah bank",size: AppSizes.size_13,
                                    fontFamily: AppFont.semi,
                                    color: AppColor.blackColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              Row(
                                children: [
                                  AppText(title: "Account Title",size: AppSizes.size_14,
                                    fontFamily: AppFont.regular,
                                    color: AppColor.blackColor,
                                  ),
                                  SizedBox(width: Get.width*0.03,),
                                  AppText(title: "GHULAM AKBAR",size: AppSizes.size_13,
                                    fontFamily: AppFont.semi,
                                    color: AppColor.blackColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      AppText(title: "Account Number",size: AppSizes.size_14,
                                        fontFamily: AppFont.regular,
                                        color: AppColor.blackColor,
                                      ),
                                      SizedBox(width: Get.width*0.03,),
                                      AppText(title: "08711007689732",size: AppSizes.size_13,
                                        fontFamily: AppFont.semi,
                                        color: AppColor.blackColor,
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                      onTap: (){
                                        Clipboard.setData(const ClipboardData(text:"08711007689732"));

                                      },
                                      child: Icon(Icons.copy,color: AppColor.primaryColor,))

                                ],
                              ),

                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      AppText(title: "IBAN",size: AppSizes.size_14,
                                        fontFamily: AppFont.regular,
                                        color: AppColor.blackColor,
                                      ),
                                      SizedBox(width: Get.width*0.03,),
                                      AppText(title: "PK29ALFH0871001007689732",size: AppSizes.size_13,
                                        fontFamily: AppFont.semi,
                                        color: AppColor.blackColor,
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                      onTap: (){
                                        Clipboard.setData(const ClipboardData(text:"PK29ALFH0871001007689732"));
                                      },
                                      child: Icon(Icons.copy,color: AppColor.primaryColor,))
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      AppText(title: "Branch Name",size: AppSizes.size_14,
                                        fontFamily: AppFont.regular,
                                        color: AppColor.blackColor,
                                      ),
                                      SizedBox(width: Get.width*0.03,),
                                      AppText(title: "Station Road Gambat Branch",size: AppSizes.size_13,
                                        fontFamily: AppFont.semi,
                                        color: AppColor.blackColor,
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                      onTap: (){
                                        Clipboard.setData(const ClipboardData(text:"Station Road Gambat Branch"));
                                      },
                                      child: Icon(Icons.copy,color: AppColor.primaryColor,))
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      AppText(title: "Branch Code",size: AppSizes.size_14,
                                        fontFamily: AppFont.regular,
                                        color: AppColor.blackColor,
                                      ),
                                      SizedBox(width: Get.width*0.03,),
                                      AppText(title: "0871",size: AppSizes.size_13,
                                        fontFamily: AppFont.semi,
                                        color: AppColor.blackColor,
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                      onTap: (){
                                        Clipboard.setData(const ClipboardData(text:"0871"));
                                      },
                                      child: Icon(Icons.copy,color: AppColor.primaryColor,))
                                ],
                              )
                            ],
                          ),
                        )),
                    ),


                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: Card(
                              margin: EdgeInsets.zero,
                              color: AppColor.whiteColor,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: AppColor.borderColorField)),
                              child:Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        AppText(title: "Bank Name",size: AppSizes.size_14,
                                          fontFamily: AppFont.regular,
                                          color: AppColor.blackColor,
                                        ),
                                        SizedBox(width: Get.width*0.03,),
                                        AppText(title: "Meezan bank",size: AppSizes.size_13,
                                          fontFamily: AppFont.semi,
                                          color: AppColor.blackColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.015,
                                    ),
                                    Row(
                                      children: [
                                        AppText(title: "Account Title",size: AppSizes.size_14,
                                          fontFamily: AppFont.regular,
                                          color: AppColor.blackColor,
                                        ),
                                        SizedBox(width: Get.width*0.03,),
                                        AppText(title: "GHULAM AKBAR",size: AppSizes.size_13,
                                          fontFamily: AppFont.semi,
                                          color: AppColor.blackColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            AppText(title: "Account Number",size: AppSizes.size_14,
                                              fontFamily: AppFont.regular,
                                              color: AppColor.blackColor,
                                            ),
                                            SizedBox(width: Get.width*0.03,),
                                            AppText(title: "12630104928525",size: AppSizes.size_13,
                                              fontFamily: AppFont.semi,
                                              color: AppColor.blackColor,
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                            onTap: (){
                                              Clipboard.setData(const ClipboardData(text:"12630104928525"));

                                            },
                                            child: Icon(Icons.copy,color: AppColor.primaryColor,))

                                      ],
                                    ),

                                    SizedBox(
                                      height: Get.height * 0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            AppText(title: "IBAN",size: AppSizes.size_14,
                                              fontFamily: AppFont.regular,
                                              color: AppColor.blackColor,
                                            ),
                                            SizedBox(width: Get.width*0.03,),
                                            AppText(title: "PK21MEZN0012630104928525",size: AppSizes.size_13,
                                              fontFamily: AppFont.semi,
                                              color: AppColor.blackColor,
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                            onTap: (){
                                              Clipboard.setData(const ClipboardData(text:"PK21MEZN0012630104928525"));
                                            },
                                            child: Icon(Icons.copy,color: AppColor.primaryColor,))
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            AppText(title: "Branch Name",size: AppSizes.size_14,
                                              fontFamily: AppFont.regular,
                                              color: AppColor.blackColor,
                                            ),
                                            SizedBox(width: Get.width*0.03,),
                                            AppText(title: "Gambat Branch",size: AppSizes.size_13,
                                              fontFamily: AppFont.semi,
                                              color: AppColor.blackColor,
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                            onTap: (){
                                              Clipboard.setData(const ClipboardData(text:"Gambat Branch"));
                                            },
                                            child: Icon(Icons.copy,color: AppColor.primaryColor,))
                                      ],
                                    ),

                                  ],
                                ),
                              )),
                        ),




                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AppText(title: "Raast Id",size: AppSizes.size_14,
                          fontFamily: AppFont.semi,
                          color: AppColor.blackColor,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: Card(
                              margin: EdgeInsets.zero,
                              color: AppColor.whiteColor,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: AppColor.borderColorField)),
                              child:Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        AppText(title: "Account Title",size: AppSizes.size_14,
                                          fontFamily: AppFont.regular,
                                          color: AppColor.blackColor,
                                        ),
                                        SizedBox(width: Get.width*0.03,),
                                        AppText(title: "GHULAM AKBAR",size: AppSizes.size_13,
                                          fontFamily: AppFont.semi,
                                          color: AppColor.blackColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            AppText(title: "Account Number",size: AppSizes.size_14,
                                              fontFamily: AppFont.regular,
                                              color: AppColor.blackColor,
                                            ),
                                            SizedBox(width: Get.width*0.03,),
                                            AppText(title: "03032120991",size: AppSizes.size_13,
                                              fontFamily: AppFont.semi,
                                              color: AppColor.blackColor,
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                            onTap: (){
                                              Clipboard.setData(const ClipboardData(text:"03032120991"));

                                            },
                                            child: Icon(Icons.copy,color: AppColor.primaryColor,))

                                      ],
                                    ),

                                  ],
                                ),
                              )),
                        )

                      ],
                    ),
                  )
              ),

            ],
          ),
        )

    );
  }


}



