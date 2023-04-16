import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mart/app/bottom_tabs/dashboard/view/dashboard_view.dart';
import 'package:mart/app/bottom_tabs/orders/view/orders_view.dart';
import 'package:mart/app/bottom_tabs/profile/view/profile_view.dart';
import 'package:mart/app/cart_list/view/cart_view.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';



class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final homeController = Get.put(HomeController());
  PersistentTabController? _controller;
  bool? _hideNavBar;
  int currentIndex = 0;
  TextEditingController descCon = TextEditingController();
  int? ratingStarValue;





  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
    // TODO: implement initState
    super.initState();
    descCon.text = '';
  }

  List<Widget> _buildScreens() {
    return [
      Dashboard(),
      CartView(),
      OrderView(),
      ProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: currentIndex == 0
                      ? AppColor.whiteColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6)),
              child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Icon(Icons.home_outlined,
                      size: Get.height * 0.027,
                      color: currentIndex == 0
                          ? AppColor.boldBlackColor
                          : AppColor.greyColor
                  )


              ),
            ),

            Text(
              'Home',
              style: TextStyle(
                fontSize: AppSizes.size_12,
                fontFamily: AppFont.semi,
                fontWeight: FontWeight.w400,
                color: currentIndex == 0 ? Colors.black : Colors.grey,
              ),
            )
          ],
        ),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(),
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: currentIndex == 1
                      ? AppColor.whiteColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6)),
              child:  Stack(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Icon(Icons.shopping_cart_outlined,
                        size: Get.height * 0.027,
                        color: currentIndex == 1
                            ? AppColor.boldBlackColor
                            : AppColor.greyColor,
                      )


                  ),






                  Positioned(
                    left: Get.width*0.05,
                    top: 5,
                    child: Container(
                      height: 13,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primaryColor,width: 0.3),
                          borderRadius: BorderRadius.circular(30),
                          color:
                          currentIndex == 1
                              ?
                          AppColor.blackColor:AppColor.primaryColor


                      ),
                      width: 13,
                      child: Center(
                          child: Obx(
                                  () {
                                return AppText(
                                    title:Get.put(HomeController()).cartList.length.toString(),
                                    size: Get.height * 0.008,
                                    color: currentIndex == 1
                                        ? AppColor.whiteColor:AppColor.whiteColor,
                                    fontFamily: AppFont.semi);
                              }
                          )),
                    ),
                  ),
                ],
              ),
            ),

            Text(
              'Cart',
              style: TextStyle(
                fontSize: AppSizes.size_12,
                fontFamily: AppFont.semi,
                fontWeight: FontWeight.w400,
                color: currentIndex == 1 ? Colors.black : Colors.grey,
              ),
            )
          ],
        ),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(),
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: currentIndex == 2
                      ? AppColor.whiteColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6)),
              child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Icon(Icons.shopping_bag_outlined,
                      size: Get.height * 0.027,
                      color: currentIndex == 2
                          ? AppColor.boldBlackColor
                          : AppColor.greyColor
                  )


              ),
            ),
            Text(
              'Orders',
              style: TextStyle(
                fontSize: AppSizes.size_12,
                fontFamily: AppFont.semi,
                fontWeight: FontWeight.w400,
                color: currentIndex == 2 ? Colors.black : Colors.grey,
              ),
            )
          ],
        ),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(),
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: currentIndex == 2
                      ? AppColor.whiteColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6)),
              child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Icon(Icons.person,
                      size: Get.height * 0.027,
                      color: currentIndex == 3
                          ? AppColor.boldBlackColor
                          : AppColor.greyColor
                  )


              ),
            ),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: AppSizes.size_12,
                fontFamily: AppFont.semi,
                fontWeight: FontWeight.w400,
                color: currentIndex == 3 ? Colors.black : Colors.grey,
              ),
            )
          ],
        ),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(),
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
      PersistentTabView(
        context,
        onItemSelected: (index) {
          // if(index == 1||index == 2 || index ==3 || index == 4 ){
          //   if (iPrefHelper.getUserData()?.user?.id == 253) {
          //     Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OnBoardingScreen()), (route) => false);
          //     return;
          //   }
          // }
          currentIndex = index;
          print(index);
          print('currentIndex:::::${currentIndex}');
          setState(() {});
        },
        padding: NavBarPadding.only(left: 10, right: 10),
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: false,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: false,
        stateManagement: true,
        navBarHeight: Get.height*0.087,
        /*kBottomNavigationBarHeight*/
        hideNavigationBarWhenKeyboardShows: true,
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,

        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
          colorBehindNavBar: Colors.indigo,),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
        NavBarStyle.style3, // Choose the nav bar style with this property
      ),
    );
  }


}
