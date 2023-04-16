import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:mart/app/bottom_tabs/dashboard/component/component.dart';
import 'package:mart/app/cart_list/view/cart_view.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/app/products/component/components.dart';
import 'package:mart/services/api_manager.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/app_textfield.dart';
import 'package:mart/widgets/bottom_sheet.dart';



class SearchProduct extends StatefulWidget {
   SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  bool _canVibrate = true;
  final Iterable<Duration> pauses = [
    const Duration(milliseconds: 500),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 500),
  ];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
      _canVibrate
          ? debugPrint('This device can vibrate')
          : debugPrint('This device cannot vibrate');
    });
  }
  final homeController = Get.put(HomeController());
  var data = "back";
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
                    Navigator.pop(context);


                  }),

                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: AppText(
                      title: "Search Product",
                      color: AppColor.boldBlackColor,
                      size: AppSizes.size_16,
                      fontFamily: AppFont.semi,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        homeController.cartAllData();
                        Get.to(CartView(data: data,));
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

                        isShowCursor: true,
                        // isReadOnly: true,
                        isSuffix: true,
                        onChange: (val){
                          setState(() {
                            homeController.productSearchData(value: val.toString());
                          });
                        },

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

                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(
                                () {
                              return
                                homeController.isProductSearchLoading.value?
                                GridView.builder(

                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    primary: false,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: Get.width/Get.height*2,
                                        crossAxisSpacing: 25,
                                        mainAxisSpacing: 20),
                                    itemCount: 12,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return Card(
                                        margin:  EdgeInsets.only(left: 8, right: 8),
                                        color: AppColor.whiteColor,
                                        elevation: 0.3,
                                        shape: RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(10),

                                        ),


                                        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: getShimmerAllLoading(),);
                                    })
                                    :
                                homeController.productSearchList.isNotEmpty?
                                GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    primary: false,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: Get.width/Get.height*1.5,
                                        crossAxisSpacing: 35,
                                        mainAxisSpacing: 20),
                                    itemCount: homeController.productSearchList.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      double discountVal =  double.parse("${100 * ((double.parse(homeController.productSearchList[index].discount.toString())) / double.parse(homeController.productSearchList[index].sellingPrice.toString()))}");
                                      double dicAll =  ((double.parse(homeController.productSearchList[index].sellingPrice.toString())) - double.parse(homeController.productSearchList[index].discount.toString()));

                                      return GestureDetector(
                                          onTap:
                                          homeController.productSearchList[index].status=="0"?(){
                                            flutterToast(msg: "Product out of stock");
                                          }:

                                              (){
                                            Get.put(HomeController()).updateQty(0);
                                            showModalBottomSheet(
                                                backgroundColor: Colors.transparent,
                                                isScrollControlled: true,
                                                isDismissible: true,
                                                context: context,
                                                builder: (context) => openBottomSheet(
                                                    disPrice:dicAll.toString(),
                                                    discount:homeController.productSearchList[index].discount.toString() ,
                                                    name:  homeController.productSearchList[index].title.toString(),

                                                    totalAll:homeController.productSearchList[index].sellingPrice.toString(),
                                                    image:homeController.productSearchList[index].productImages![0].image!,
                                                    qty: homeController.productSearchList[index].quantity.toString().split(".").first,
                                                    remove: (){
                                                      setState(() {
                                                        if (_canVibrate) {
                                                          Vibrate.feedback(FeedbackType.medium);
                                                          homeController.updateDecQty();
                                                        }

                                                      });
                                                    },
                                                    add: (){
                                                      setState(() {
                                                        if (_canVibrate) {
                                                          Vibrate.feedback(FeedbackType.medium);
                                                          homeController.updateAddQty();
                                                        }
                                                        //
                                                      });
                                                    },
                                                    onTap:


                                                        (){
                                                      Navigator.pop(context);
                                                      ApiManger().addCartResponse(context: context,id:homeController.productSearchList[index].id.toString());
                                                      flutterToastSuccess(msg: "Item added to cart successfully");
                                                    },
                                                    price: homeController.productSearchList[index].sellingPrice.toString()
                                                ));



                                          },


                                          child: productWidget(
                                            dis:
                                            homeController.productSearchList[index].discount=="0"?"":
                                            "${discountVal.toStringAsFixed(0)}% OFF"
                                            ,
                                            child:
                                            homeController.productSearchList[index].discount=="0"?SizedBox.shrink():
                                            Text("Rs.${homeController.productSearchList[index].sellingPrice.toString()}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color:Colors.grey.shade900,
                                                decoration: TextDecoration.lineThrough,
                                                overflow: TextOverflow.ellipsis,

                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w500,
                                              ),),
                                            priceColro:
                                            homeController.productSearchList[index].discount=="0"?
                                            Colors.grey.shade900:Colors.red,
                                            price:
                                            homeController.productSearchList[index].discount=="0"?"Rs.${homeController.productSearchList[index].sellingPrice.toString()}":
                                            "Rs.${dicAll.toStringAsFixed(0)}",
                                            text:
                                            (homeController.productSearchList[index].status=="0")?
                                            "":"",
                                            discountColor:
                                            homeController.productSearchList[index].discount=="0"?Colors.transparent:
                                            Colors.teal.withOpacity(0.6),
                                            isSold: homeController.productSearchList[index].status=="0"?true:false,
                                            color:(homeController.productSearchList[index].status=="0")?
                                            Colors.transparent: Colors.transparent ,
                                            name: homeController.productSearchList[index].title.toString(),
                                            image:homeController.productSearchList[index].productImages![0].image!,img: "assets/images/grocery.png",


                                          ));
                                    }):noData();
                            }
                        ),
                        SizedBox(
                          height: Get.height * 0.1,
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



