// ignore_for_file: prefer_const_constructors, must_be_immutable


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mart/app/order_detail/component/item_list.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';

class OrderDetail extends StatelessWidget {
   OrderDetail({Key? key,this.data}) : super(key: key);
  var data;



  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(
        data.deliveryDate??""
    );
    return Scaffold(
      body: Padding(
        padding: AppPaddings.mainPadding,
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.035,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backButton(onTap: () {
                  Navigator.pop(context);
                }),
                AppText(
                  title: "Order Details",
                  color: AppColor.blackColor,
                  size: AppSizes.size_16,
                  fontFamily: AppFont.semi,
                ),
                SizedBox()
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height*0.04,),
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
                              title: data.id.toString(),
                              fontFamily: AppFont.semi,
                              overFlow: TextOverflow.ellipsis,
                              size: AppSizes.size_13,
                              color: AppColor.blackColor,
                            ),
                          ],
                        ),
                        AppText(
                          title:"${DateFormat('dd MMM yyyy').format(
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
                      height: Get.height * 0.02,
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
                          data.status=="new"?"Order Placed":

                          data.status=="active"?"Processing":
                          data.status=="assigned"?"On The Way":

                          data.status,
                          fontFamily: AppFont.semi,
                          overFlow: TextOverflow.ellipsis,
                          size: AppSizes.size_13,
                          color:   data.status=="new"?
                          Colors.deepOrange:Colors.lightGreen
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
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


                    SizedBox(height: Get.height*0.02,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_outlined),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: Get.width * 0.6,
                            child: AppText(
                              maxLines: 2,
                              overFlow: TextOverflow.ellipsis,
                              title: data.deliveryAddress.location,
                              color: Color.fromRGBO(14, 15, 25, .65),
                              fontFamily: AppFont.medium,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height*0.02,),
                    AppText(
                      title: "Items :  ",
                      fontFamily: AppFont.medium,
                      overFlow: TextOverflow.ellipsis,
                      size: AppSizes.size_16,
                      color: AppColor.boldBlackColor,
                    ),
                    Items(
                      data: data,
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Divider(
              color: Colors.grey.withOpacity(0.2),
              thickness: 1.5,
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  title: 'Total Amount',
                  fontFamily: AppFont.medium,
                  color: AppColor.boldBlackColor,
                  size: AppSizes.size_15,
                ),
                AppText(
                  title: "Rs.${data.total.toString()}/-",
                  fontFamily: AppFont.semi,
                  color: AppColor.boldBlackColor,
                  size: 16,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.09,
            ),
          ],
        ),
      ),
    );
  }
}
