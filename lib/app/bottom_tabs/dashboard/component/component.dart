import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mart/app/authentication/login/view/login_view.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/util/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';

Widget boxWidget(
    {image, name, img, text, double? height, Color? color, TOTAL}) {
  return Column(
    children: [
      Card(
        margin: EdgeInsets.zero,
        color: AppColor.whiteColor,
        shadowColor: Colors.grey.withOpacity(0.5),
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColor.borderColorField.withOpacity(0.5))),
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                      color: color ?? Colors.greenAccent,
                      border: Border.all(width: 1,color: color ?? Colors.greenAccent),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: AppText(
                      title: text,
                      size: Get.height * 0.007,
                      fontFamily: AppFont.semi,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>  Center(
                    child: SpinKitThreeBounce(
                        size: 22,
                        color: AppColor.primaryColor
                    ),
                  ),
                  imageUrl: image,
                  height: Get.height * 0.12,
                  width: Get.height * 0.16,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      img,
                      height: Get.height * 0.083,
                      width: Get.width * 0.2,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.013,)

            ],
          ),
        ),
      ),
      SizedBox(
        height: 8,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: Get.width,
          child: AppText(
            title: name,
            size: AppSizes.size_11,
            maxLines: 2,
            overFlow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            color: AppColor.boldBlackColor,
            fontFamily: AppFont.medium,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

DraggableScrollableSheet openBottomSheet({image, name, onTap, remove, add, price, qty,totalAll,discount,disPrice
,Widget?imageChild
}) {
  return DraggableScrollableSheet(
    initialChildSize:0.7,
    minChildSize:0.7,
    maxChildSize:0.7,
    builder: (_, controller) => Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.01, horizontal: Get.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            SizedBox(
              height: Get.height * 0.01,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Obx(
                      () {
                    return SizedBox(
                      width: Get.put(HomeController()).qty.value == 0?Get.width:Get.width,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/images/frames.png",
                              height: Get.height * 0.02,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          imageChild??

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.black26,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              AppColor.primaryColor //<-- SEE HERE

                                          ),
                                        ),
                                      ),
                                      imageUrl: image,
                                      height: Get.height * 0.17,
                                      width: Get.height * 0.17,
                                      fit: BoxFit.contain,
                                      errorWidget: (context, url, error) => ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          "assets/images/product.png",
                                          height: Get.height * 0.14,
                                          width: Get.height * 0.16,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: AppText(
                                title: name,
                                size: AppSizes.size_13,
                                maxLines: 2,
                                overFlow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                color: AppColor.boldBlackColor,
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                AppText(
                                  title:
                                  discount == "0"?
                                  "Rs.$price":"Rs.${((double.parse(price)) - double.parse(discount))}",
                                  size: AppSizes.size_16,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  color:
                                  discount == "0"?
                                  Colors.grey:Colors.red,
                                  fontFamily: AppFont.medium,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(width: 10,),
                                discount=="0"?SizedBox.shrink():
                                Text("Rs.$price",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                    Colors.grey,
                                    fontSize: AppSizes.size_16,
                                    decoration: TextDecoration.lineThrough,
                                    overflow: TextOverflow.ellipsis,

                                    fontFamily: AppFont.medium,
                                    fontWeight: FontWeight.w500,
                                  ),),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.038,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: AppText(
                                      title: " Add Quantity",
                                      size: AppSizes.size_14,
                                      overFlow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      color: AppColor.boldBlackColor.withOpacity(0.5),
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container()
                                ],
                              ),
                              Obx(() {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: Get.put(HomeController()).qty.value > 0
                                          ? remove
                                          : () {},
                                      child: Container(
                                        height: Get.height * 0.045,
                                        width: Get.put(HomeController()).name.value.isEmpty
                                            ? Get.height * 0.045
                                            : Get.height * 0.045,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                            Border.all(color: AppColor.boldBlackColor)),
                                        child: Center(
                                            child: Icon(
                                              Icons.remove,
                                              color: AppColor.boldBlackColor,
                                              size: Get.height * 0.023,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                    Obx(() {
                                      return AppText(
                                        title:
                                        Get.put(HomeController()).qty.value.toString(),
                                        size: AppSizes.size_16,
                                        overFlow: TextOverflow.ellipsis,
                                        color: AppColor.boldBlackColor,
                                        fontFamily: AppFont.semi,
                                        fontWeight: FontWeight.w500,
                                      );
                                    }),
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                    GestureDetector(
                                      onTap: Get.put(HomeController()).qty.value <
                                          double.parse(qty).toInt()
                                          ? add
                                          : () {
                                        flutterToast(
                                            msg: "You have reached maximum limit");
                                      },
                                      child: Container(
                                        height: Get.height * 0.045,
                                        width: Get.height * 0.045,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                            Border.all(color: AppColor.boldBlackColor)),
                                        child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: AppColor.boldBlackColor,
                                              size: Get.height * 0.023,
                                            )),
                                      ),
                                    )
                                  ],
                                );
                              })
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          const Divider(
                            color: AppColor.boldGreyColor,
                          ),

                          Obx(
                                  () {
                                return SizedBox(
                                  height:
                                  Get.put(HomeController()).qty.value==0?Get.height * 0.02:
                                  Get.height * 0.02,
                                );
                              }
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                title: "Total Amount",
                                size: AppSizes.size_16,
                                overFlow: TextOverflow.ellipsis,
                                color: AppColor.greyColor,
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w500,
                              ),
                              Row(
                                children: [
                                  AppText(
                                    title: "Rs. ",
                                    size: AppSizes.size_13,
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    color: AppColor.boldBlackColor,
                                    fontFamily: AppFont.medium,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Obx(
                                          () {
                                        return
                                          disPrice=="0"?

                                          AppText(
                                            title: ( double.parse(Get.put(HomeController()).qty.value.toString()).toInt() * double.parse(

                                                totalAll)).toStringAsFixed(1),
                                            size: AppSizes.size_13,
                                            maxLines: 1,
                                            overFlow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            color: AppColor.boldBlackColor,
                                            fontFamily:Get.put(HomeController()).qty.value==1? AppFont.medium:AppFont.medium,
                                            fontWeight: FontWeight.w500,
                                          ):
                                          AppText(
                                            title: ( double.parse(Get.put(HomeController()).qty.value.toString()).toInt() * double.parse(
                                                disPrice)).toStringAsFixed(1),
                                            size: AppSizes.size_13,
                                            maxLines: 1,
                                            overFlow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            color: AppColor.boldBlackColor,
                                            fontFamily:Get.put(HomeController()).qty.value==1? AppFont.medium:AppFont.medium,
                                            fontWeight: FontWeight.w500,
                                          )

                                        ;
                                      }
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          Obx(() {
                            return AppButton(
                              buttonWidth: Get.width,
                              buttonHeight: Get.height * 0.055,
                              buttonName: "Add to cart",
                              fontFamily: Get.put(HomeController()).name.value.isEmpty
                                  ? AppFont.medium
                                  : AppFont.medium,
                              textSize: Get.height * 0.017,
                              buttonColor: AppColor.primaryColor,
                              textColor: AppColor.whiteColor,
                              onTap: Get.put(HomeController()).name.value.isEmpty
                                  ? () {
                                flutterToast(msg: "Please Create your account!");
                                Get.offAll(LoginView());
                              }
                                  :    Get.put(HomeController()).qty.value == 0?(){
                                flutterToast(msg: "Please Select Quantity");
                              }:



                              onTap,
                              buttonRadius: BorderRadius.circular(10),
                            );
                          })
                        ],
                      ),
                    );
                  }
              ),
            ),

          ],
        ),
      ),
    ),
  );
}
