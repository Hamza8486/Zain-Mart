

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mart/app/bottom_tabs/dashboard/component/category_list.dart';
import 'package:mart/app/bottom_tabs/dashboard/component/search_product.dart';
import 'package:mart/app/bottom_tabs/dashboard/component/updates.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/app_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  whatsapp() async{
    var contact = "+923032120991";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }
      else{
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception{

    }
  }
  int _current = 0;

  final CarouselController _controller = CarouselController();
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    setState(() {
      log(homeController.image.value);
      log(homeController.image.value);
      log(homeController.image.value);
    });
    return Scaffold(
      body: Padding(
        padding: AppPaddings.mainHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.07,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.lightAppColor2.withOpacity(0.25),
                        ),
                        borderRadius: BorderRadius.circular(40)),
                    child: AppTextFied(
                      onTap: () {
                        Navigator.of(context,
                            rootNavigator:
                            false)
                            .push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchProduct()));

                      },
                      isborderline: true,
                      isFill: true,

                      isShowCursor: false,
                      isReadOnly: true,
                      isSuffix: true,


                      hint: "Search for products",
                      hintColor: AppColor.greyColor,
                      fontFamily: AppFont.regular,
                      hintSize: Get.height * 0.014,
                      prefixIcon: Image.asset(
                        Images.search,
                        scale: 22,
                        color: AppColor.blackColor,
                      ),

                      padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.014,
                          horizontal: Get.width * 0.02),
                      fillColor: AppColor.lightAppColor2.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(40),
                      borderRadius1: BorderRadius.circular(40),
                      borderRadius2: BorderRadius.circular(40),
                      isborderline2: true,
                      isborderline1: true,

                      isPrefix: true,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.of(context,
                        rootNavigator:
                        false)
                        .push(
                        MaterialPageRoute(
                            builder: (context) =>
                                UpdatesView()));

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.lightAppColor2.withOpacity(0.25),),
                        color:AppColor.lightAppColor2.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: SvgPicture.asset(
                        "assets/icons/noti.svg",
                        height: Get.height * 0.03,
                        color: AppColor.boldBlackColor,
                      ),
                    ),
                  ),
                )

              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Expanded(child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: Get.height * 0.015,
                ),
                Obx(
                        () {
                      return Stack(
                        children: [
                          CarouselSlider(
                            carouselController: _controller,
                            options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              pageSnapping: false,
                              height: Get.height * 0.2,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              pauseAutoPlayInFiniteScroll: false,
                              reverse: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 2),
                              autoPlayAnimationDuration: const Duration(milliseconds: 400),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                            ),
                            items: homeController.bannerList
                                .map((item) => Container(
                              margin: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => const Center(
                                    child: SpinKitThreeBounce(
                                        size: 25,
                                        color: AppColor.primaryColor
                                    ),
                                  ),
                                  imageUrl: item.banner.toString(),

                                  width: Get.width,
                                  fit: BoxFit.fill,

                                  errorWidget: (context, url, error) => ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      "assets/images/banner.png",
                                      fit: BoxFit.cover,
                                      width: Get.width,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                                .toList(),
                          ),
                          Positioned(
                              right: Get.width*0.37,
                              top:Get.height*0.16,
                              child:   Obx(
                                      () {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: homeController.bannerList.asMap().entries.map((entry) {
                                        return GestureDetector(
                                          onTap: () => _controller.animateToPage(entry.key),
                                          child: Container(
                                            width: 9.0,
                                            height: 9.0,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 4.0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: (Theme.of(context).brightness ==
                                                    Brightness.dark
                                                    ? Colors.white
                                                    : Colors.deepOrange)
                                                    .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }
                              ))

                        ],
                      );
                    }
                ),

                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                        title: "Category ",
                        size: AppSizes.size_16,
                        color: AppColor.boldBlackColor,
                        fontFamily: AppFont.semi),
                    SizedBox()
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CategoryList(),
                SizedBox(
                  height: Get.height * 0.02,
                ),
              ],),
            )),
            SizedBox(
              height: Get.height * 0.08,
            ),
          ],
        ),
      ),
    );
  }
}
