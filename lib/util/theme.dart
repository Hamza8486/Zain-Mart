import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {
  static const primaryColor = Color(0xFF013D29);

  static const borderColorField = Color(0xFFD5D5E7);
  static Color tabsColor = const Color(0xffF7F7F7);

  static const whiteColor = Colors.white;
  static const lightAppColor2 = Color(0xFFBAD3FC);
  static const boxAppColor = Color(0xFFBAD3FC);
  static const blackColor = Color(0xFF000000);
  static Color catBorderColors = const Color(0xffD8D1D1);
  static const boldBlackColor = Color(0xFF101828);
  static const pinColor = Color(0xFFF8F8FC);
  static const textGreyColor = Color(0xFF9099A8);
  static const boldGreyColor = Color(0xFF9A9A9A);
  static const greyColor = Colors.grey;
  static Color catColor = const Color(0xffF9F9FD);
  static const backgroundColor = Color.fromARGB(255, 243, 243, 243);
  static const transParent = Colors.transparent;

  static Color Color1 =  const Color(0xffDBFDDF);
  static Color Color2 =  const Color(0xff6BAE00);
  static Color Color3 =  const Color(0xffFFE6F3);
  static Color Color4 =  const Color(0xffFDF4DB);
  static Color Color5 =  const Color(0xffFFE8E0);
  static Color Color6 =  const Color(0xffF2E1FF);
  static Color Color7 =  const Color(0xffE1F4FF);
  static Color Color8 =  const Color(0xffFFDFDF);



}

class AppSizes {
  static double size_10 = Get.height / 81.2;
  static double size_11 = Get.height / 73.8;
  static double size_12 = Get.height / 67.7;
  static double size_13 = Get.height / 62.5;
  static double size_14 = Get.height / 58;
  static double size_15 = Get.height / 54.1;
  static double size_16 = Get.height / 50.8;
  static double size_17 = Get.height / 47.8;
  static double size_18 = Get.height / 45.1;
  static double size_19 = Get.height / 42.7;
  static double size_20 = Get.height / 40.6;
  static double size_21 = Get.height / 38.7;
  static double size_22 = Get.height / 36.9;
  static double size_23 = Get.height / 35.3;
  static double size_24 = Get.height / 33.8;
  static double size_25 = Get.height / 32.5;
  static double size_26 = Get.height / 31.2;
  static double size_27 = Get.height / 30.1;
  static double size_28 = Get.height / 29;
  static double size_29 = Get.height / 28;
  static double size_30 = Get.height / 27.1;
}

class Images {
  // Images
  static const home = "$_path/home.png";
  static const menue = "$_path/menue.png";
  static const search = "$_path/searchs.png";
  static const profile = "$_path/profile.png";
  static const _path = "assets/images";


  // Icons
  static const _path1 = "assets/icons";
  static const face = "$_path1/facebook.png";
  static const google = "$_path1/google.png";
  static const user = "$_path1/user.svg";
  static const down = "$_path1/down.png";
  static const homeType = "$_path1/home.svg";
  static const email = "$_path1/email.png";
  static const facebookIcon = "$_path1/facebook_icon.png";
  static const googleIcon = "$_path1/google_icon.png";
  static const backIcon = "$_path1/back.png";
  static const like = "$_path1/like.png";
  static const notification = "$_path1/noti.png";
  static const setting = "$_path1/setting.png";
  static const add = "$_path1/add.png";
  static const deal = "$_path1/deal.svg";
  static const cat_icon = "$_path1/cat_icon.svg";
  static const bag = "$_path1/bag.svg";
  static const invoice = "$_path1/invoice.svg";
  static const location = "$_path1/location.png";
  static const delete = "$_path1/delete.svg";
  static const tags = "$_path1/tag.svg";
  static const edit = "$_path1/edit.svg";
  static const edits = "$_path1/edits.svg";
  static const edit1 = "$_path1/";
  static const del = "$_path1/del.svg";
  static const store = "$_path1/store.svg";
  static const star = "$_path1/star.svg";
  static const downs = "$_path1/downs.svg";
  static const logout = "$_path1/logout.svg";
  static const settings = "$_path1/setting.svg";
  static const cart = "$_path1/cart.svg";
  static const calendar = "$_path1/calendar.svg";
  static const camera = "$_path1/camera.svg";
  static const set_icon = "$_path1/setting_icon.svg";
  static const re_icon = "$_path1/reward_icon.svg";
  static const pri_icon = "$_path1/privacy_icon.svg";
  static const myIcon = "$_path1/my_icon.svg";
  static const editIcon = "$_path1/edit_icon.svg";
  static const termIcon = "$_path1/term_icon.svg";
  static const credit_icon = "$_path1/credit_icon.svg";


}


class AppFont {
  static String semi = 'semi';
  static String regular = 'regular';
  static String medium = 'medium';
  static String bold = 'bold';
  static String light = 'light';

}
class AppPaddings {
  static EdgeInsets mainPadding = EdgeInsets.only(
      right: Get.width * 0.04,left: Get.width * 0.04, top: Get.height * 0.025, bottom: Get.height * 0.01);


  static EdgeInsets mainHomePadding = EdgeInsets.only(
      left: Get.width * 0.04,right: Get.width * 0.04, top: Get.height * 0.04);
  static EdgeInsets mainHorizontal = EdgeInsets.symmetric(
      horizontal: Get.width * 0.04);
  static EdgeInsets mainVertical = EdgeInsets.symmetric(
      vertical: Get.height * 0.025);
}

void showLoadingIndicator({required BuildContext context}) {
  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          height: 65,width: 65,

          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),     color: Colors.white,),
          child: Container(

            height: 25,width: 25,color: Colors.transparent,child:  const Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.black26,
              valueColor: AlwaysStoppedAnimation<Color>(
                  AppColor.primaryColor //<-- SEE HERE

              ),
                // strokeWidth: 5,
          ),
            ),),
        ),
      );
    },
  );
}