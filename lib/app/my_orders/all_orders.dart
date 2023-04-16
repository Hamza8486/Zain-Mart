import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mart/app/bottom_tabs/orders/component/complete_list.dart';
import 'package:mart/app/bottom_tabs/orders/component/order_list.dart';
import 'package:mart/app/bottom_tabs/orders/controller/order_controller.dart';
import 'package:mart/app/home/view/home_view.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';

class AllOrders extends StatefulWidget {
  AllOrders({Key? key}) : super(key: key);


  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  final orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>

      false,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.025),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.035,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(onTap: () {
                    Get.offAll(BottomNavBar());

                  }),

                  AppText(
                    title: "My Orders",
                    color: AppColor.blackColor,
                    size: AppSizes.size_16,
                    fontFamily: AppFont.semi,
                  ),
                  SizedBox()
                ],
              ),
              SizedBox(height: Get.height*0.02,),
              Obx(
                      () {
                    return Material(
                      color: AppColor.tabsColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: AppColor.primaryColor.withOpacity(0.3))
                      ),

                      child: SizedBox(
                          width: Get.width,

                          height: Get.height * 0.06,
                          child:    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Expanded(
                                  child: tabBusinessList1(
                                    text: "Active",
                                    onTap: () {
                                      orderController.updateTab(0);
                                    },
                                    color: !(orderController.tab.value == 0)
                                        ? AppColor.tabsColor
                                        : AppColor.primaryColor,
                                    color1: !(orderController.tab.value == 0)
                                        ? AppColor.boldBlackColor
                                        : AppColor.whiteColor,
                                  ),
                                ),

                                Expanded(
                                  child: tabBusinessList1(
                                    text: "Completed",
                                    onTap: () {
                                      orderController.updateTab(1);
                                    },
                                    color: !(orderController.tab.value == 1)
                                        ? AppColor.tabsColor
                                        : AppColor.primaryColor,
                                    color1: !(orderController.tab.value == 1)
                                        ? AppColor.boldBlackColor
                                        : AppColor.whiteColor,
                                  ),
                                ),



                              ],
                            ),
                          )
                      ),
                    );
                  }
              ),
              SizedBox(height: Get.height*0.02,),
              Expanded(
                child:

                SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                              () {
                            return
                              orderController.tab.value == 0?

                              ActiveList():CompleteList();
                          }
                      ),
                      SizedBox(
                        height: Get.height * 0.08,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
Widget tabBusinessList1({text, color, color1, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.08, vertical: 5),
        child: Center(
          child: AppText(
            title: text,
            color: color1,
            size: AppSizes.size_13,
            fontFamily: AppFont.semi,
          ),
        ),
      ),
    ),
  );
}