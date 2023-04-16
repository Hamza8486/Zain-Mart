import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mart/app/bottom_tabs/profile/component/new_add_address.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/services/api_manager.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';




class GetAddress extends StatefulWidget {
   GetAddress({Key? key,this.data}) : super(key: key);
  var data;

  @override
  State<GetAddress> createState() => _GetAddressState();
}

class _GetAddressState extends State<GetAddress> {
  final homeController = Get.put(HomeController());
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
                    padding: const EdgeInsets.only(left: 60),
                    child: AppText(
                      title: "Address",
                      color: AppColor.blackColor,
                      size: AppSizes.size_16,
                      fontFamily: AppFont.semi,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context,
                          rootNavigator:
                          false)
                          .push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddAddress()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blueAccent
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppText(
                          title: "Add Address",
                          color: Colors.blueAccent,
                          size: AppSizes.size_14,
                          fontFamily: AppFont.semi,
                        ),
                      ),
                    ),
                  ),
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
                          height: Get.height * 0.02,
                        ),
                        Obx(
                          () {
                            return
                             homeController.isAddressLoading.value?loader():
                             homeController.addressList.isNotEmpty?

                              ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                padding: EdgeInsets.zero,
                                itemCount: homeController.addressList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap:
                                    widget.data =="back"?


                                        (){
                                      homeController.updateAddName(homeController.addressList[index].location);
                                      homeController.updateId(homeController.addressList[index].id.toString());
                                      homeController.updateTypeName(homeController.addressList[index].name);
                                      Get.back();
                                    }:(){},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      child: Card(
                                          margin: EdgeInsets.zero,
                                          color: AppColor.whiteColor,

                                          shadowColor: Colors.grey.withOpacity(0.5),
                                          elevation: 1,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                                              side: const BorderSide(color: AppColor.borderColorField)
                                          ),


                                          child:

                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        AppText(
                                                          title: "Address name:  ",
                                                          size: AppSizes.size_14,
                                                          overFlow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.start,
                                                          color: AppColor.blackColor,
                                                          fontFamily: AppFont.regular,
                                                        ),
                                                        AppText(
                                                          title: homeController.addressList[index].name,
                                                          size: AppSizes.size_14,
                                                          textAlign: TextAlign.start,
                                                          color: AppColor.boldBlackColor,
                                                          fontFamily: AppFont.semi,
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                        onTap:


                                                            (){

                                                              deleteAddress(context: context,onTap: (){
                                                                Get.back();
                                                                showLoadingIndicator(context: context);
                                                                ApiManger().deleteAddressResponse(context: context,id: homeController.addressList[index].id.toString());

                                                              });

                                                        },
                                                        child: SvgPicture.asset(
                                                          "assets/images/delete.svg",
                                                          height: Get.height * 0.03,

                                                        )),

                                                  ],
                                                ),
                                                homeController.addressList[index].streetNo.isEmpty?SizedBox.shrink():
                                                SizedBox(
                                                  height: Get.height * 0.01,),
                                                homeController.addressList[index].streetNo.isEmpty?SizedBox.shrink():
                                                Row(
                                                  children: [
                                                    AppText(
                                                      title: "Street No : ",
                                                      size: AppSizes.size_14,
                                                      overFlow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.start,
                                                      color: AppColor.blackColor,
                                                      fontFamily: AppFont.regular,
                                                    ),
                                                    Expanded(
                                                      child: AppText(
                                                        title: homeController.addressList[index].streetNo,
                                                        size: AppSizes.size_14,
                                                        textAlign: TextAlign.start,
                                                        color: AppColor.boldBlackColor,
                                                        fontFamily: AppFont.semi,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    AppText(
                                                      title: "Address : ",
                                                      size: AppSizes.size_14,
                                                      overFlow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.start,
                                                      color: AppColor.blackColor,
                                                      fontFamily: AppFont.regular,
                                                    ),
                                                    Expanded(
                                                      child: AppText(
                                                        title:homeController.addressList[index].location,
                                                        size: AppSizes.size_14,
                                                        textAlign: TextAlign.start,
                                                        color: AppColor.boldBlackColor,
                                                        fontFamily: AppFont.semi,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                    ),
                                  );
                                }):noData();
                          }
                        ),
                        SizedBox(
                          height: Get.height * 0.08,
                        ),


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



