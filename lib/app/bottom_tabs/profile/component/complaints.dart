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



class ComplaintRequest extends StatefulWidget {
  const ComplaintRequest({Key? key}) : super(key: key);

  @override
  State<ComplaintRequest> createState() => _ComplaintRequestState();
}

class _ComplaintRequestState extends State<ComplaintRequest> {
final homeController = Get.put(HomeController());
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
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
                      title: "Complaint Requests",
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
                                      homeController.updateValueComplaint("true");
                                      homeController.file = value!;
                                    });
                                  });
                                }, onGallery: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.gallery)
                                      .then((value) {
                                    setState(() {
                                      homeController.updateValueComplaint("true");
                                      homeController.file = value!;
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
                              homeController.file == null?
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
                                      title: "Upload Image",
                                      size: AppSizes.size_12,
                                      overFlow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      color: AppColor.blackColor,
                                      fontFamily: AppFont.semi,
                                    ),
                                  ),
                                ],
                              ):Image.file( homeController.file as File,fit: BoxFit.cover,),
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
                          controller: title,
                          autovalidateMode:  AutovalidateMode.onUserInteraction,
                          isborderline2: true,
                          isSuffix: true,
                          padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0185),                        borderRadius: BorderRadius.circular(10),
                          borderRadius2: BorderRadius.circular(10),
                          borderColor:AppColor.borderColorField,
                          hint: "title Complaint",
                          onChange: (val){
                            setState(() {
                              homeController.updateValueComplaint(val.toString());
                            });
                          },

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
                        AppTextFied(
                          fillColor:AppColor.whiteColor,
                          isFill: true,
                          onChange: (val){
                            setState(() {
                              homeController.updateValueComplaint(val.toString());
                            });
                          },
                          isborderline: true,
                          controller: desc,
                          autovalidateMode:  AutovalidateMode.onUserInteraction,
                          isborderline2: true,
                          isSuffix: true,
                          padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0185),                        borderRadius: BorderRadius.circular(10),
                          borderRadius2: BorderRadius.circular(10),
                          borderColor:AppColor.borderColorField,
                          hint: "About Complaint",

                          hintColor: AppColor.blackColor.withOpacity(0.5),
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,

                          hintSize: AppSizes.size_13,
                          fontFamily:AppFont.medium,
                          borderColor2: AppColor.primaryColor,

                          maxLines: 1,
                        )
                      ],
                    ),
                  )
              ),
              isKeyBoard?SizedBox.shrink():
              SizedBox(
                height: Get.height * 0.015,
              ),
              isKeyBoard?SizedBox.shrink():
              Obx(
                () {
                  return authButton(text:homeController.valueComp.value.isEmpty?"Submit Complaint": "Submit Complaint",onTap:
                  homeController.valueComp.value.isEmpty?(){
                    flutterToast(msg: "Please select fields");
                  }:
                      (){
                    showLoadingIndicator(context: context);
                    ApiManger().complaintResponse(context: context,
                    title: title.text,
                      desc: desc.text

                    );
                  });
                }
              ),
              SizedBox(
                height: Get.height * 0.08,
              ),
            ],
          ),
        )

    );
  }
}



