import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mart/app/cart_list/component/cart_list.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/app/order_place/order_place.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';

class CartView extends StatefulWidget {
  CartView({Key? key,this.data}) : super(key: key);
  var data;

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
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
                widget.data == "back"?
                backButton(onTap: () {
                  Navigator.pop(context);
                }):Container(),
                AppText(
                  title: "My Cart",
                  color: AppColor.boldBlackColor,
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
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CartList(),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Obx(
                    () {
                  return
                    homeController.cartList.isNotEmpty?

                    AppButton(
                    buttonWidth: Get.width,
                    buttonHeight: Get.height * 0.055,
                    buttonName: "Checkout",
                    fontFamily:Get.put(HomeController()).name.value.isEmpty?AppFont.medium: AppFont.medium,
                    textSize: Get.height * 0.017,
                    buttonColor:
                    homeController.cartList.isNotEmpty?
                    AppColor.primaryColor:AppColor.primaryColor.withOpacity(0.5),

                    textColor: AppColor.whiteColor,
                    onTap:
                    homeController.cartList.isNotEmpty?
                        (){

                          Navigator.of(context,
                              rootNavigator:
                              false)
                              .push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Checkout()));
                        homeController.cartAllData();

                        }:(){
                      print("object");
                    },


                    buttonRadius: BorderRadius.circular(10),
                  ):SizedBox.shrink();
                }
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
