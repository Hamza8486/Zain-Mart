import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:mart/app/bottom_tabs/dashboard/component/component.dart';
import 'package:mart/app/bottom_tabs/dashboard/component/search_product.dart';
import 'package:mart/app/cart_list/view/cart_view.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/app/products/component/components.dart';
import 'package:mart/services/api_manager.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/bottom_sheet.dart';



class SubCategoryAll extends StatefulWidget {
   SubCategoryAll({Key? key,this.data}) : super(key: key);

  var data;

  @override
  State<SubCategoryAll> createState() => _SubCategoryAllState();
}

class _SubCategoryAllState extends State<SubCategoryAll> {
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

        body:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.06,
            ),
            Padding(
              padding: AppPaddings.mainHorizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(onTap: (){
                   Navigator.pop(context);


                  }),

                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: AppText(
                      title: "Sub-Categories",
                      color: AppColor.boldBlackColor,
                      size: AppSizes.size_16,
                      fontFamily: AppFont.semi,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        homeController.cartAllData();
                        Navigator.of(context,
                            rootNavigator:
                            false)
                            .push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    CartView(data: data ,)));

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
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            // widget.data.subCategories.isEmpty?noData():
            Expanded(child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                GridView.builder(

                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: Get.width/Get.height*2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 1),
                    itemCount: widget.data.subCategories.length+1,
                    itemBuilder: (BuildContext ctx, index) {
                      return index == 0
                          ? GestureDetector(
                        onTap: () {
                          homeController.updateValueAll("All");
                          homeController.productCatData(id: widget.data.id.toString());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Column(
                            children: [
                              Container(
                                width: Get.height*0.07,
                                height: Get.height*0.07,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color:


                                    AppColor.boldBlackColor, width: 1.3)),
                                child: Center(
                                  child: AppText(
                                    title: "All",
                                    color:
                                    AppColor.boldBlackColor,
                                    size: AppSizes.size_13,
                                    fontFamily: AppFont.semi,
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height*0.01,),
                              AppText(
                                title: "All",
                                size: AppSizes.size_12,
                                overFlow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                color: AppColor.boldBlackColor,

                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      )
                          : GestureDetector(
                        onTap: () {
                          homeController.updateValueAll(widget.data.subCategories[index-1].name.toString());
                          homeController.productData(id:widget.data.subCategories[index-1].id.toString() );
                        },
                        child:  Padding(
                          padding: EdgeInsets.only(left: 0,right: 17),
                          child: Column(

                            children: [
                              Container(
                                width: Get.height*0.07,
                                height: Get.height*0.07,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color:


                                    AppColor.boldBlackColor, width: 1.3)),
                                child:  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child:CachedNetworkImage(
                                      placeholder: (context, url) =>const Center(
                                        child: SpinKitThreeBounce(
                                            size: 15,
                                            color: AppColor.primaryColor
                                        ),
                                      ),
                                      imageUrl:widget.data.subCategories[index-1].image,

                                      fit: BoxFit.fill,

                                      errorWidget: (context, url, error) => ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.asset(
                                          "assets/images/grocery.png",

                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),




                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height*0.005,),
                              AppText(
                                title: widget.data.subCategories[index-1].name??"",
                                size: AppSizes.size_12,

                                textAlign: TextAlign.center,
                                color: AppColor.boldBlackColor,
                                maxLines: 2,
                                overFlow: TextOverflow.ellipsis,


                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),

                      );
                    }),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Padding(
                  padding: AppPaddings.mainHorizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () {
                          return AppText(
                            title: "${homeController.valueAll.value} Products",
                            color: AppColor.boldBlackColor,
                            size: AppSizes.size_16,
                            fontFamily: AppFont.semi,
                          );
                        }
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(SearchProduct());
                        },
                        child: AppText(
                          title: "View All",
                          size: AppSizes.size_12,
                          overFlow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          color: AppColor.boldBlackColor,

                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.02,),



                Obx(
                        () {
                      return
                      homeController.valueAll.value == "All"?
                       ( homeController.isProductCatLoading.value?
                        Padding(
                          padding: AppPaddings.mainHorizontal,
                          child: GridView.builder(

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
                              }),
                        )
                            :
                        homeController.productCatList.isNotEmpty?
                        Padding(
                          padding: AppPaddings.mainHorizontal,
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: Get.width/Get.height*1.52,
                                  crossAxisSpacing: 35,
                                  mainAxisSpacing: 20),
                              itemCount: homeController.productCatList.length,
                              itemBuilder: (BuildContext ctx, index) {
                                double discountVal =  double.parse("${100 * ((double.parse(homeController.productCatList[index].discount.toString())) / double.parse(homeController.productCatList[index].sellingPrice.toString()))}");
                                double dicAll =  ((double.parse(homeController.productCatList[index].sellingPrice.toString())) - double.parse(homeController.productCatList[index].discount.toString()));

                                return Obx(
                                        () {
                                      return GestureDetector(

                                          onTap:
                                          homeController.productCatList[index].status=="0"?(){
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
                                                    discount:homeController.productCatList[index].discount.toString() ,
                                                    name:  homeController.productCatList[index].title.toString(),

                                                    totalAll:homeController.productCatList[index].sellingPrice.toString(),
                                                    image:homeController.productCatList[index].productImages![0].image!,
                                                    qty: homeController.productCatList[index].quantity.toString().split(".").first,
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
                                                      ApiManger().addCartResponse(context: context,id:homeController.productCatList[index].id.toString());
                                                      flutterToastSuccess(msg: "Item added to cart successfully");
                                                    },
                                                    price: homeController.productCatList[index].sellingPrice.toString()
                                                ));



                                          },


                                          child: productWidget(
                                            dis:
                                            homeController.productCatList[index].discount=="0"?"":
                                                "${discountVal.toStringAsFixed(0)}% OFF"
                                            ,
                                            child:
                                            homeController.productCatList[index].discount=="0"?SizedBox.shrink():
                                            Text("Rs.${homeController.productCatList[index].sellingPrice.toString()}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color:Colors.grey.shade900,
                                                decoration: TextDecoration.lineThrough,
                                                overflow: TextOverflow.ellipsis,

                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w500,
                                              ),),
                                            priceColro:
                                            homeController.productCatList[index].discount=="0"?
                                            Colors.grey.shade900:Colors.red,
                                            price:
                                            homeController.productCatList[index].discount=="0"?"Rs.${homeController.productCatList[index].sellingPrice.toString()}":
                                            "Rs.${dicAll.toStringAsFixed(1)}",
                                            text:
                                            (homeController.productCatList[index].status=="0")?
                                            "":"",
                                            discountColor:
                                            homeController.productCatList[index].discount=="0"?Colors.transparent:
                                            Colors.teal.withOpacity(0.6),
                                            isSold: homeController.productCatList[index].status=="0"?true:false,
                                            color:(homeController.productCatList[index].status=="0")?
                                            Colors.transparent: Colors.transparent ,
                                            name: homeController.productCatList[index].title.toString(),
                                            image:homeController.productCatList[index].productImages![0].image!,img: "assets/images/grocery.png",


                                          ));
                                    }
                                );
                              }),
                        ):noData()): ( homeController.isProductLoading.value?
                      Padding(
                        padding: AppPaddings.mainHorizontal,
                        child: GridView.builder(

                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: Get.width/Get.height*1.5,
                                crossAxisSpacing: 35,
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
                            }),
                      )
                          :
                      homeController.productList.isNotEmpty?
                      Padding(
                        padding: AppPaddings.mainHorizontal,
                        child: GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: Get.width/Get.height*1.52,
                                crossAxisSpacing: 35,
                                mainAxisSpacing: 20),
                            itemCount: homeController.productList.length,
                            itemBuilder: (BuildContext ctx, index) {
                              double discountVal =  double.parse("${100 * ((double.parse(homeController.productList[index].discount.toString())) / double.parse(homeController.productList[index].sellingPrice.toString()))}");
                              double dicAll =  ((double.parse(homeController.productList[index].sellingPrice.toString())) - double.parse(homeController.productList[index].discount.toString()));
                              return Obx(
                                      () {
                                    return GestureDetector(

                                        onTap:
                                        homeController.productList[index].status=="0"?(){
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
                                                  discount:homeController.productList[index].discount.toString() ,
                                                  name:  homeController.productList[index].title.toString(),

                                                  totalAll:homeController.productList[index].sellingPrice.toString(),
                                                  image:homeController.productList[index].productImages![0].image!,
                                                  qty: homeController.productList[index].quantity.toString().split(".").first,
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
                                                    ApiManger().addCartResponse(context: context,id:homeController.productList[index].id.toString());
                                                    flutterToastSuccess(msg: "Item added to cart successfully");
                                                  },
                                                  price: homeController.productList[index].sellingPrice.toString()
                                              ));



                                        },



                                        child: productWidget(
                                          dis:
                                          homeController.productList[index].discount=="0"?"":
                                          "${discountVal.toStringAsFixed(0)}% OFF"
                                          ,
                                          child:
                                          homeController.productList[index].discount=="0"?SizedBox.shrink():
                                          Text("Rs.${homeController.productList[index].sellingPrice.toString()}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color:Colors.grey.shade900,
                                              decoration: TextDecoration.lineThrough,
                                              overflow: TextOverflow.ellipsis,

                                              fontFamily: AppFont.medium,
                                              fontWeight: FontWeight.w500,
                                            ),),
                                          priceColro:
                                          homeController.productList[index].discount=="0"?
                                          Colors.grey.shade900:Colors.red,
                                          price:
                                          homeController.productList[index].discount=="0"?"Rs.${homeController.productList[index].sellingPrice.toString()}":


                                          "Rs.${dicAll.toStringAsFixed(0)}",
                                          text:
                                          (homeController.productList[index].status=="0")?
                                          "":"",
                                          discountColor:
                                          homeController.productList[index].discount=="0"?Colors.transparent:
                                          Colors.teal.withOpacity(0.6),
                                          isSold: homeController.productList[index].status=="0"?true:false,
                                          color:(homeController.productList[index].status=="0")?
                                          Colors.transparent: Colors.transparent ,
                                          name: homeController.productList[index].title.toString(),
                                          image:homeController.productList[index].productImages![0].image!,img: "assets/images/grocery.png",

                                        ));
                                  }
                              );
                            }),
                      ):noData());
                    }
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),


              ],),
            )),


          ],
        )

    );
  }
}



