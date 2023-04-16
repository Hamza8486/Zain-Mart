// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/app/order_detail/view/order_detail.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_text.dart';



class ActiveList extends StatelessWidget {
   ActiveList({Key? key}) : super(key: key);

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
            homeController.activeList.isNotEmpty?
            ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: homeController.activeList.length,
            itemBuilder: (BuildContext context, int index) {
              DateTime date = DateTime.parse(
                  homeController.activeList[index].deliveryDate??""
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
                                OrderDetail(data: homeController.activeList[index],)));

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
                                    title: homeController.activeList[index].id.toString(),
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
                                title:
                                homeController.activeList[index].status=="new"?"Order Placed":

                                homeController.activeList[index].status=="active"?"Processing":
                                homeController.activeList[index].status=="assigned"?"On The Way":
                                homeController.activeList[index].status.toString(),
                                fontFamily: AppFont.semi,
                                overFlow: TextOverflow.ellipsis,
                                size: AppSizes.size_15,
                                color:
                                homeController.activeList[index].status=="new"?
                                Colors.deepOrange:Colors.lightGreen
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
                                    title: "Rs.${homeController.activeList[index].total.toString()}/- ",
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
