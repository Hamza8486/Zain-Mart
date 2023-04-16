import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mart/app/authentication/component/auth_component.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/services/api_manager.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/app_textfield.dart';
import 'package:mart/widgets/helper_function.dart';
import 'package:mart/widgets/image_pick.dart';



class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);


  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final homeController = Get.put(HomeController());
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = homeController.name.value.toString();
  }
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
                      title: "Edit Profile",
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
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (builder) => bottomSheet(onCamera: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.camera)
                                      .then((value) {
                                    setState(() {
                                      homeController.fileUpdate = value!;
                                    });
                                  });
                                }, onGallery: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.gallery)
                                      .then((value) {
                                    setState(() {
                                      homeController.fileUpdate = value!;
                                    });
                                  });
                                }));
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                width: Get.width,
                                height: Get.height * 0.15,
                                child: Center(
                                  child: Material(
                                    elevation: 1,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                    ),
                                    color: AppColor.primaryColor,
                                    child: Container(
                                      height: Get.height * 0.139,
                                      width: Get.height * 0.139,
                                      decoration: const BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(100))),
                                      child: homeController.fileUpdate == null
                                          ? Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(100),
                                          child: Obx(
                                                  () {
                                                return Image.network(
                                                  homeController.image.value ,
                                                  fit: homeController.image.value.isEmpty?BoxFit.cover: BoxFit.cover,
                                                  errorBuilder: (context, exception,
                                                      stackTrace) {
                                                    return ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      child: Image.asset(
                                                        "assets/images/persons.jpg",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                          ),
                                        ),
                                      )
                                          : Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(100),
                                          child: Image.file(
                                            homeController.fileUpdate as File,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: Get.width * 0.51,
                                  top: Get.height * 0.1,
                                  child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: AppColor.primaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: SvgPicture.asset("assets/icons/camera.svg"),
                                      )))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                    AppText(
                      title: "Name",
                      color: AppColor.boldBlackColor,
                      size: AppSizes.size_15,
                      fontFamily: AppFont.semi,
                    ),
                        SizedBox(
                          height: Get.height * 0.01,
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
                          hint: "name",
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


                      ],
                    ),
                  )
              ),
              isKeyBoard?SizedBox.shrink():
              SizedBox(
                height: Get.height * 0.015,
              ),
              isKeyBoard?SizedBox.shrink():
              authButton(text:"Update Profile",onTap:
                        (){
                      showLoadingIndicator(context: context);
                      ApiManger().updateResponse(context: context,
                          title: title.text,


                      );

                  }
              ),
              SizedBox(
                height: Get.height * 0.09,
              ),

            ],
          ),
        )

    );
  }
}



