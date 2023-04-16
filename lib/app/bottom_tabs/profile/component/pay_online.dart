import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mart/app/authentication/component/auth_component.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/services/api_manager.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/app_textfield.dart';
import 'package:mart/widgets/helper_function.dart';
import 'package:mart/widgets/image_pick.dart';



class PayOnline extends StatefulWidget {
  const PayOnline({Key? key}) : super(key: key);

  @override
  State<PayOnline> createState() => _PayOnlineState();
}

class _PayOnlineState extends State<PayOnline> {
 final homeController = Get.put(HomeController());
  TextEditingController name = TextEditingController();
  var id;
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
                      title: "Online Payment",
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
                      children: [
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (builder) => bottomSheet(onCamera: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.camera)
                                      .then((value) {
                                    setState(() {
                                      homeController.updateValuePay("val");
                                      homeController.file1 = value!;
                                    });
                                  });
                                }, onGallery: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.gallery)
                                      .then((value) {
                                    setState(() {
                                      homeController.updateValuePay("val");
                                      homeController.file1 = value!;
                                    });
                                  });
                                }));
                          },
                          child: SizedBox(
                            width: Get.width,
                            height: Get.height*0.2,
                            child: Card(
                              margin: EdgeInsets.zero,
                              color: AppColor.whiteColor,

                              shadowColor: Colors.grey.withOpacity(0.5),
                              elevation: 1,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: AppColor.borderColorField)
                              ),


                              child:
                              homeController.file1 == null?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.06,
                                  ),
                                  const Icon(Icons.camera_alt_outlined,color: AppColor.boldBlackColor,
                                    size: 30,
                                  ),
                                  SizedBox(height: Get.height*0.005,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: AppText(
                                      title: "Upload Receipt",
                                      size: AppSizes.size_12,
                                      overFlow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      color: AppColor.blackColor,
                                      fontFamily: AppFont.semi,
                                    ),
                                  ),
                                ],
                              ):Image.file(homeController.file1 as File,fit: BoxFit.cover,),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        AppTextFied(
                          fillColor:AppColor.whiteColor,
                          isFill: true,

                          isborderline: true,
                          autovalidateMode:  AutovalidateMode.onUserInteraction,
                          isborderline2: true,
                          isSuffix: true,
                          onChange: (val){
                            setState(() {
                              homeController.updateValuePay("val");
                            });
                          },
                          padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0185),                        borderRadius: BorderRadius.circular(10),
                          borderRadius2: BorderRadius.circular(10),
                          borderColor:AppColor.borderColorField,
                          controller: name,
                          hint: "Receipt description",

                          hintColor: AppColor.blackColor.withOpacity(0.5),
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,

                          hintSize: AppSizes.size_13,
                          fontFamily:AppFont.medium,
                          borderColor2: AppColor.primaryColor,

                          maxLines: 1,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Obx(
                          () {
                            return dropDownButtons(
                                color2: AppColor.blackColor,
                                color1: AppColor.blackColor,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.016, horizontal: 10),
                                color: homeController.allList.isNotEmpty? AppColor.borderColorField:AppColor.borderColorField,
                                hinText: "Choose Order Id",
                                value: id,
                                onChanged: (value) {
                                  setState(() {
                                    id = value!;
                                    print(
                                      id.toString(),
                                    );
                                  });
                                },
                                items:
                                locDataList(dataList: homeController.allList));
                          }
                        ),
                      ],
                    ),
                  )
              ),
              isKeyBoard?SizedBox.shrink():
              SizedBox(
                height: Get.height * 0.015,
              ),
              isKeyBoard?SizedBox.shrink():
               authButton(text: "Pay",onTap:


                      (){
                        if(validateAlll(context)){
                          showLoadingIndicator(context: context);
                          ApiManger().paymentResponse(context: context,title:name.text,id: id.toString() );
                        }
                  }),
              SizedBox(
                height: Get.height * 0.09,
              ),
            ],
          ),
        )

    );
  }

 List<DropdownMenuItem<int>> locDataList({var dataList}) {
   List<DropdownMenuItem<int>> outputList = [];
   for (int i = 0; i < dataList.length; i++) {
     outputList.add(DropdownMenuItem<int>(
         value: dataList[i].id,
         child: SizedBox(
           width: Get.width * 0.8,
           child: AppText(
             title:"Order Id# ${ dataList[i].id.toString()}" ,
             size: AppSizes.size_12,
             maxLines: 1,
             overFlow: TextOverflow.ellipsis,
             color: AppColor.blackColor,
             fontFamily: AppFont.medium,
           ),
         )));
   }
   return outputList;
 }
 bool validateAlll(BuildContext context) {

   if (homeController.valuePay.value.isEmpty) {
     flutterToast(msg: "Please select fields");
     return false;
   }
   if (id==null) {
     flutterToast(msg: "Please select Order Id");
     return false;
   }

   return true;
 }
}



