// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/app/order_detail/view/order_detail.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_text.dart';



class CompleteList extends StatelessWidget {
  CompleteList({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    return


      Obx(
              () {
            return

              homeController.isOrderLoading.value
                  ?ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: 12,
                  itemBuilder: (BuildContext context, int index) {
                    return  Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only( bottom: 10),
                      child: getShimmerLoading(),
                    );
                  })
                  :
              homeController.completeList.isNotEmpty?
              ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: homeController.completeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    DateTime date = DateTime.parse(
                        homeController.completeList[index].deliveryDate??""
                    );
                    return Padding(
                      padding:  EdgeInsets.only(top: 10, bottom: 10),
                      child:  GestureDetector(
                        onTap: (){
                          Navigator.of(context,
                              rootNavigator:
                              false)
                              .push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderDetail(data: homeController.completeList[index],)));
                        },
                        child: Card(

                          margin: EdgeInsets.zero,
                          color: AppColor.whiteColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                              side: BorderSide(



                                  color:
                                  Colors.grey.withOpacity(0.4))
                          ),

                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                        AppText(
                                          title: "Order Id#:  ",
                                          fontFamily: AppFont.regular,
                                          overFlow: TextOverflow.ellipsis,
                                          size: AppSizes.size_13,
                                          color: AppColor.blackColor,
                                        ),
                                        AppText(
                                          title: homeController.completeList[index].id.toString(),
                                          fontFamily: AppFont.semi,
                                          overFlow: TextOverflow.ellipsis,
                                          size: AppSizes.size_13,
                                          color: AppColor.blackColor,
                                        ),
                                      ],
                                    ),
                                    AppText(
                                      title: "${DateFormat('dd MMM yyyy').format(
                                          date
                                      )} ",
                                      fontFamily: AppFont.semi,
                                      overFlow: TextOverflow.ellipsis,
                                      size: AppSizes.size_13,
                                      color: AppColor.blackColor,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.008,
                                ),
                                Row(
                                  children: [
                                    AppText(
                                      title: "Order Status:  ",
                                      fontFamily: AppFont.regular,
                                      overFlow: TextOverflow.ellipsis,
                                      size: AppSizes.size_13,
                                      color: AppColor.blackColor,
                                    ),
                                    AppText(
                                      title: homeController.completeList[index].status.toString(),
                                      fontFamily: AppFont.semi,
                                      overFlow: TextOverflow.ellipsis,
                                      size: AppSizes.size_13,
                                      color: AppColor.blackColor,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.008,
                                ),
                                Row(
                                  children: [
                                    AppText(
                                      title: "Payment Method:  ",
                                      fontFamily: AppFont.regular,
                                      overFlow: TextOverflow.ellipsis,
                                      size: AppSizes.size_13,
                                      color: AppColor.blackColor,
                                    ),
                                    AppText(
                                      title: "COD ",
                                      fontFamily: AppFont.semi,
                                      overFlow: TextOverflow.ellipsis,
                                      size: AppSizes.size_13,
                                      color: AppColor.blackColor,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.008,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        AppText(
                                          title: "Total amount:  ",
                                          fontFamily: AppFont.regular,
                                          overFlow: TextOverflow.ellipsis,
                                          size: AppSizes.size_13,
                                          color: AppColor.blackColor,
                                        ),
                                        AppText(
                                          title: "Rs.${homeController.completeList[index].total.toString()}/- ",
                                          fontFamily: AppFont.semi,
                                          overFlow: TextOverflow.ellipsis,
                                          size: AppSizes.size_13,
                                          color: AppColor.blackColor,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: AppColor.primaryColor)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AppText(
                                          title: "Order Detail",
                                          fontFamily: AppFont.medium,
                                          overFlow: TextOverflow.ellipsis,
                                          size: AppSizes.size_13,
                                          color: AppColor.blackColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }):noData();
          }
      );


  }
}
