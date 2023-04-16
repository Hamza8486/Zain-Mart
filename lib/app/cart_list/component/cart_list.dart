import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/services/api_manager.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_text.dart';



class CartList extends StatefulWidget {
  const CartList({Key? key,required}) : super(key: key);



@override
State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  final homeController = Get.put(HomeController());

  double price = 0.0;

  @override
  Widget build(BuildContext context) {

    return Obx(
            () {
        return
          homeController.isCartLoading.value
              ?ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: const BouncingScrollPhysics(),
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
              homeController.cartList.isNotEmpty?
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount:homeController.cartList.length,
            itemBuilder: (BuildContext context, int index) {
              double discountVal =  double.parse("${100 * ((double.parse(homeController.cartList[index].product.discount.toString())) / double.parse(homeController.cartList[index].product.sellingPrice.toString()))}");

              return Padding(
                padding:  EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      color: AppColor.whiteColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                          side:  BorderSide(


                              color:
                             Colors.grey.withOpacity(0.5))
                      ),

                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                placeholder: (context, url) => const Center(
                                  child: SpinKitThreeBounce(
                                      size: 15,
                                      color: AppColor.primaryColor
                                  ),
                                ),
                                imageUrl: homeController.cartList[index].product!.productImages![0].image.toString(),
                                height: Get.height * 0.06,
                                width: Get.height*0.05,
                                fit: BoxFit.fill,

                                errorWidget: (context, url, error) => ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      "assets/images/product.png",
                                      height: Get.height * 0.07,
                                      width: Get.height*0.07,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                ),
                              ),





                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.03),
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width:Get.width*0.6,
                                              child: AppText(
                                                title: homeController.cartList[index].product?.title??"",
                                                fontFamily: AppFont.regular,
                                                overFlow: TextOverflow.ellipsis,
                                                size: AppSizes.size_15,
                                                color: AppColor.blackColor,
                                              ),
                                            ),
                                            SizedBox(height:5,),
                                            Row(
                                              children: [
                                                AppText(
                                                  title: "Rs.",
                                                  color: AppColor.boldBlackColor,
                                                  fontFamily: AppFont.regular,
                                                  size: AppSizes.size_14,
                                                ),
                                                homeController.cartList[index].discount=="0"?

                                                AppText(
                                                  title:( homeController.cartList[index].quantity * double.parse(homeController.cartList[index].product.sellingPrice.toString())).toStringAsFixed(1),
                                                  color: AppColor.boldBlackColor,
                                                  fontFamily: AppFont.regular,
                                                  size: AppSizes.size_14,
                                                ):AppText(
                                                  title:( homeController.cartList[index].quantity * (double.parse(homeController.cartList[index].product.sellingPrice.toString()) - double.parse(homeController.cartList[index].product.discount.toString()))).toStringAsFixed(1),
                                                  color: AppColor.boldBlackColor,
                                                  fontFamily: AppFont.regular,
                                                  size: AppSizes.size_14,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                            onTap:(){
                                              showLoadingIndicator(context: context);
                                              ApiManger().deleteCartResponse(context: context,id: homeController.cartList[index].id.toString());
                                            },
                                            child: SvgPicture.asset(
                                              "assets/images/delete.svg",
                                              height: Get.height * 0.03,

                                            )),
                                      ],
                                    ),
                                    SizedBox(height:
                                    homeController.cartList[index].discount=="0"?0:
                                    5,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        homeController.cartList[index].discount=="0"?Container():
                                        AppText(
                                          title:  "${discountVal.toStringAsFixed(0)}% OFF",
                                          color: Colors.teal,
                                          fontFamily: AppFont.medium,
                                          size: AppSizes.size_12,
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap:
                                              homeController.cartList[index].quantity >
                                                  1
                                                  ?

                                                  (){

                                                setState(() {

                                                  homeController.cartList[index].quantity =
                                                  (homeController.cartList[index].quantity -
                                                      1);


                                                  ApiManger.updateCartResp(
                                                      catId: homeController.cartList[index].id,
                                                      id: homeController.cartList[index].product.id.toString(),
                                                      qty:homeController.cartList[index].quantity
                                                  );



                                                });

                                              }:(){
                                                showLoadingIndicator(context: context);

                                                ApiManger().deleteCartResponse(context: context,
                                                  id: homeController.cartList[index].id.toString(),

                                                );
                                              },
                                              child: Container(
                                                height:25,
                                                width: 25,
                                                decoration: BoxDecoration(

                                                    border: Border.all(color: AppColor.greyColor),
                                                    shape: BoxShape.circle
                                                ),
                                                child: const Center(child: Icon(Icons.remove,color: AppColor.greyColor,
                                                  size: 14,)),

                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            AppText(
                                              title: homeController.cartList[index].quantity.toString() ,
                                              color: AppColor.boldBlackColor,
                                              fontFamily: AppFont.medium,
                                              size: AppSizes.size_14,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  homeController.cartList[index].quantity =
                                                  (homeController.cartList[index].quantity +
                                                      1);
                                                  ApiManger.updateCartResp(
                                                      catId: homeController.cartList[index].id,
                                                      id: homeController.cartList[index].product.id.toString(),
                                                      qty:homeController.cartList[index].quantity
                                                  );


                                                });

                                              },
                                              child: Container(
                                                height:25,
                                                width: 25,
                                                decoration: BoxDecoration(

                                                    border: Border.all(color: AppColor.greyColor),
                                                    shape: BoxShape.circle
                                                ),
                                                child: const Center(child: Icon(Icons.add,color: AppColor.greyColor,
                                                  size: 14,)),

                                              ),
                                            ),
                                          ],
                                        )


                                      ],
                                    ),


                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              );
            }):noData(height: Get.height*0.35);
      }
    );


  }
}
