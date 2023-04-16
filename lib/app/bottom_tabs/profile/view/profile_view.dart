// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mart/app/authentication/controller/auth_controller.dart';
import 'package:mart/app/authentication/login/view/login_view.dart';
import 'package:mart/app/bottom_tabs/orders/controller/order_controller.dart';
import 'package:mart/app/bottom_tabs/orders/view/orders_view.dart';
import 'package:mart/app/bottom_tabs/profile/component/about_us.dart';
import 'package:mart/app/bottom_tabs/profile/component/bank_detail.dart';
import 'package:mart/app/bottom_tabs/profile/component/complaints.dart';
import 'package:mart/app/bottom_tabs/profile/component/component.dart';
import 'package:mart/app/bottom_tabs/profile/component/edit_profile.dart';
import 'package:mart/app/bottom_tabs/profile/component/get_address.dart';
import 'package:mart/app/bottom_tabs/profile/component/product_request.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/helper_function.dart';
import 'package:url_launcher/url_launcher.dart';




class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var text = "orders";

  whatsapp() async{
    var contact = "+923103786320";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }
      else{
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception{

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPaddings.mainPadding,
        child:Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.035,
                    ),
                    Center(
                      child: AppText(
                        title: "Profile",
                        color: AppColor.boldBlackColor,
                        size: AppSizes.size_18,
                        fontFamily: AppFont.semi,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Expanded(
                      child: SingleChildScrollView(

                        child: Column(

                          children: [
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Stack(
                              children: [
                                Obx(
                                  () {
                                    return SizedBox(
                                      width: Get.width,
                                      child: Card(

                                        color:Get.put(HomeController()).name.value.isEmpty?AppColor.whiteColor: AppColor.whiteColor,

                                        shadowColor: Colors.grey.withOpacity(0.5),
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                                            side: BorderSide(color: AppColor.borderColorField)
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: Get.height * 0.015,
                                            ),
                                            GestureDetector(
                                              onTap:  Get.put(HomeController()).name.value.isEmpty?(){}: (){
                                                Navigator.of(context,
                                                    rootNavigator:
                                                    false)
                                                    .push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditProfile()));

                                              },
                                              child: Material(
                                                elevation: 1,
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(100)),
                                                ),
                                                color: AppColor.primaryColor,
                                                child: Container(
                                                  height: Get.height * 0.11,
                                                  width: Get.height * 0.11,
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(100))),
                                                  child:  Container(
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: const EdgeInsets.all(2),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(100),
                                                      child: Obx(
                                                              () {
                                                            return Image.network(
                                                              Get.put(HomeController()).image.value ,
                                                              fit: Get.put(HomeController()).image.value.isEmpty?BoxFit.cover: BoxFit.cover,
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

                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.01,
                                            ),
                                          Obx(
                                            () {
                                              return
                                                Get.put(HomeController()).name.value.isEmpty?
                                                GestureDetector(
                                                  onTap: () async{
                                                    await  Get.delete<HomeController>();
                                                    await  Get.delete<AuthController>();
                                                    await  Get.delete<OrderController>();

                                                    await  HelperFunctions().clearPrefs();
                                                    Get.offAll(LoginView());
                                                  },
                                                  child: AppText(
                                                    title: "Login Account",
                                                    color: AppColor.boldBlackColor,
                                                    size: AppSizes.size_16,
                                                    fontFamily: AppFont.semi,
                                                  ),
                                                )

                                                    :

                                                Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Obx(
                                                            () {
                                                          return AppText(
                                                            title: Get.put(HomeController()).name.value,
                                                            color: AppColor.boldBlackColor,
                                                            size: AppSizes.size_15,
                                                            fontFamily: AppFont.semi,
                                                          );
                                                        }
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.008,
                                                  ),
                                                  Center(
                                                    child: Obx(
                                                            () {
                                                          return AppText(
                                                            title: Get.put(HomeController()).phone.value,
                                                            color: AppColor.boldBlackColor.withOpacity(0.7),
                                                            size: AppSizes.size_15,
                                                            fontFamily: AppFont.medium,
                                                          );
                                                        }
                                                    ),
                                                  ),

                                                ],
                                              );

                                            }
                                          ),
                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                ),
                                Positioned(
                                    left: Get.width * 0.49,
                                    top: Get.height * 0.09,
                                    child: GestureDetector(
                                      onTap:
                                      Get.put(HomeController()).name.value.isEmpty?(){}:
                                          (){
                                        Navigator.of(context,
                                            rootNavigator:
                                            false)
                                            .push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfile()));

                                      },
                                      child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: SvgPicture.asset("assets/icons/camera.svg",

                                            ),
                                          )),
                                    ))
                              ],
                            ),


                            SizedBox(
                              height: Get.height * 0.02,
                            ),

                        SizedBox(
                          width: Get.width,
                          child: Card(
                            color: AppColor.whiteColor,

                            shadowColor: Colors.grey.withOpacity(0.5),
                            elevation: 1,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: AppColor.borderColorField)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              child: Column(children: [
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                profileWidget(
                                    text: "My Orders",
                                    icon: Icon(Icons.refresh,color: AppColor.boldGreyColor,size: Get.height*0.027,),
                                    color: AppColor.Color2.withOpacity(0.1),
                                    image: Images.myIcon,
                                    onTap: () {
                                      Navigator.of(context,
                                          rootNavigator:
                                          false)
                                          .push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderView(data: text,)));

                                    }),
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),
                                Obx(
                                  () {
                                    return profileWidget(
                                        text: "Address",
                                        icon: Icon(Icons.location_on_outlined,color: AppColor.boldGreyColor,size: Get.height*0.027,),
                                        color: Get.put(HomeController()).token.value.isEmpty?AppColor.Color2: AppColor.Color2,
                                        image: Images.myIcon,
                                        onTap:
                                        Get.put(HomeController()).name.value.isEmpty?(){
                                          flutterToast(msg: "Please create your account first");
                                        }:

                                            () {
                                          Navigator.of(context,
                                              rootNavigator:
                                              false)
                                              .push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GetAddress(data: text,)));

                                        });
                                  }
                                ),

                                SizedBox(
                                  height: Get.height * 0.005,
                                ),

                                profileWidget(
                                    icon: Icon(Icons.whatsapp,color: AppColor.boldGreyColor,size: Get.height*0.027,),
                                    text: "HelpLine",
                                    color: AppColor.Color6,
                                    image: Get.put(HomeController()).token.value.isEmpty?Images.pri_icon:Images.pri_icon,
                                    onTap:


                                        () {
                                      whatsapp();

                                    }),

                                SizedBox(
                                  height: Get.height * 0.005,
                                ),


                                Obx(
                                  () {
                                    return profileWidget(
                                        icon: Icon(Icons.payment,color: AppColor.boldGreyColor,size: Get.height*0.027,),
                                        text: "Online Payment",
                                        color: Get.put(HomeController()).token.value.isEmpty?AppColor.Color4: AppColor.Color4,
                                        image: Images.re_icon,
                                        onTap:
                                        Get.put(HomeController()).name.value.isEmpty?(){
                                          flutterToast(msg: "Please create your account first");
                                        }:

                                            () {
                                              Get.put(HomeController()).AllOrderIdData();
                                              Navigator.of(context,
                                                  rootNavigator:
                                                  false)
                                                  .push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BankRequest()));


                                        });
                                  }
                                ),
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),


                                Obx(
                                        () {
                                      return profileWidget(
                                          icon: Icon(Icons.account_balance,color: AppColor.boldGreyColor,size: Get.height*0.027,),
                                          text: "Bank Details",
                                          color: Get.put(HomeController()).token.value.isEmpty?AppColor.Color4: AppColor.Color4,
                                          image: Images.re_icon,
                                          onTap:
                                          Get.put(HomeController()).name.value.isEmpty?(){
                                            flutterToast(msg: "Please create your account first");
                                          }:

                                              () {
                                            Get.put(HomeController()).AllOrderIdData();
                                            Navigator.of(context,
                                                rootNavigator:
                                                false)
                                                .push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BankDetail()));


                                          });
                                    }
                                ),





                                SizedBox(
                                  height: Get.height * 0.005,
                                ),

                                Obx(
                                        () {
                                      return profileWidget(
                                          icon: Icon(Icons.comment_bank,color: AppColor.boldGreyColor,size: Get.height*0.027,),
                                          text: "Complaints",
                                          color: AppColor.Color6,
                                          image: Get.put(HomeController()).token.value.isEmpty?Images.pri_icon:Images.pri_icon,
                                          onTap:
                                          Get.put(HomeController()).name.value.isEmpty?(){
                                            flutterToast(msg: "Please create your account first");
                                          }:


                                              () {
                                            Navigator.of(context,
                                                rootNavigator:
                                                false)
                                                .push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ComplaintRequest()));


                                          });
                                    }
                                ),
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),

                                profileWidget(
                                    icon: Icon(Icons.details,color: AppColor.boldGreyColor,size: Get.height*0.027,),
                                    text: "About Us",
                                    color: AppColor.Color7,
                                    image: Images.termIcon,
                                    onTap: () {
                                      Navigator.of(context,
                                          rootNavigator:
                                          false)
                                          .push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AboutUs()));



                                    }),
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),
                                profileWidget(
                                    icon: Icon(Icons.logout,color: AppColor.boldGreyColor,size: Get.height*0.027,),
                                    text: "Logout",
                                    color: AppColor.Color8,
                                    colorDiv:Colors.transparent,
                                    image: Images.logout,
                                    onTap: ()  {
                                      showExit(context: context);
                                    }),

                              ],),
                            ),
                          ),
                        ),
                            SizedBox(
                              height: Get.height * 0.09,
                            ),


                          ],
                        ),
                      ),
    ),
        ]
      )
      )
    );
  }
}


