import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mart/app/bottom_tabs/dashboard/component/component.dart';
import 'package:mart/app/cart_list/view/cart_view.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/app/products/component/components.dart';
import 'package:mart/services/api_manager.dart';
import 'package:mart/util/constant.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/app_textfield.dart';
import 'package:mart/widgets/bottom_sheet.dart';



class ProductsView extends StatefulWidget {
   ProductsView({Key? key,this.data}) : super(key: key);
  var data;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
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
                    Get.back();


                  }),

                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: AppText(
                      title: widget.data.name,
                      color: AppColor.blackColor,
                      size: AppSizes.size_16,
                      fontFamily: AppFont.semi,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        homeController.cartAllData();
                        Get.to(CartView());
                      },
                      child: SizedBox(
                        height: Get.height * 0.04,
                        width: Get.height * 0.04,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                size: Get.height * 0.032,
                                color: AppColor.blackColor,
                              ),
                            ),
                            Positioned(
                              left: Get.width * 0.032,
                              child: Container(
                                height: 14,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                        AppColor.primaryColor,
                                        width: 0.3),
                                    borderRadius:
                                    BorderRadius.circular(30),
                                    color: AppColor.primaryColor),
                                width: 14,
                                child: Center(child:  Padding(
                                  padding: const EdgeInsets.only(
                                      left: 1),
                                  child: Obx(
                                    () {
                                      return AppText(
                                          title: homeController.cartList.length.toString(),
                                          size: Get.height * 0.01,
                                          color:
                                          homeController.cartList.isEmpty? AppColor.whiteColor:
                                          AppColor.whiteColor,
                                          fontFamily: AppFont.medium);
                                    }
                                  ),
                                )
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.borderColorField,),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: AppTextFied(
                        onTap: () {

                        },
                        isborderline: true,
                        isFill: true,
                        onChange: (val){
                          setState(() {
                            homeController.productData(id: widget.data.id.toString(),
                            value: val
                            );
                          });
                        },

                        isShowCursor: true,
                        // isReadOnly: true,
                        isSuffix: true,

                        hint: "What do you looking for?",
                        hintColor: AppColor.greyColor,
                        fontFamily: AppFont.regular,
                        hintSize: Get.height * 0.014,
                        prefixIcon: Image.asset(
                          Images.search,
                          scale: 22,
                          color: AppColor.blackColor,
                        ),

                        padding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.015,
                            horizontal: Get.width * 0.02),
                        fillColor: AppColor.pinColor,
                        borderRadius: BorderRadius.circular(10),
                        borderRadius1: BorderRadius.circular(10),
                        borderRadius2: BorderRadius.circular(10),
                        isborderline2: true,
                        isborderline1: true,

                        isPrefix: true,



                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),

              Expanded(
                  child:

                  Obx(
                     () {
                      return
                      homeController.isProductLoading.value?
                      GridView.builder(

                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: Get.width/Get.height*2.3,
                              crossAxisSpacing: 25,
                              mainAxisSpacing: 20),
                          itemCount: 12,
                          itemBuilder: (BuildContext ctx, index) {
                            return Card(
                              margin:  const EdgeInsets.only(left: 8, right: 8),
                              color: AppColor.whiteColor,
                              elevation: 0.3,
                              shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(10),

                              ),


                              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: getShimmerAllLoading(),);
                          })
                          :
                      homeController.productList.isNotEmpty?
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: Get.width/Get.height*2,
                              crossAxisSpacing: 25,
                              mainAxisSpacing: 20),
                          itemCount: homeController.productList.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Obx(
                              () {
                                return GestureDetector(

                                 onTap: (){},


                                    child: productWidget(
                                      name: homeController.productList[index].title.toString(),
                                      image:homeController.productList[index].productImages![0].image!,img: "assets/images/grocery.png",
                                      price: "Rs.${homeController.productList[index].sellingPrice.toString()}/${homeController.productList[index].quantity.toString().split(".").first} ${homeController.productList[index].unit.toString()}",

                                    ));
                              }
                            );
                          }):noData();
                    }
                  )
              )

            ],
          ),
        )

    );
  }
}



