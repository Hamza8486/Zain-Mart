import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';

Widget authButton({onTap,text,Color?color}){
  return   AppButton(
    buttonWidth: Get.width,
    buttonHeight: Get.height * 0.062,
    buttonName: text,
    fontFamily: AppFont.semi,
    textSize: Get.height * 0.019,
    buttonColor:color?? AppColor.primaryColor,

    textColor: AppColor.whiteColor,
    onTap: onTap,

    buttonRadius: BorderRadius.circular(10),
  );
}



Widget backBtn({required BuildContext context, required VoidCallback onTap}) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: size.height * 0.05,
      width: size.width * 0.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.greyColor.withOpacity(0.5),
          )),
      child: const Center(
          child: Padding(
            padding: EdgeInsets.only(left: 6),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColor.blackColor,
              size: 16,
            ),
          )),
    ),
  );
}
Widget socialButton({text, image, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.height * 0.06,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.greyColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: Get.height * 0.023,
          ),
          const SizedBox(
            width: 6,
          ),
          AppText(
            title: text,
            color: AppColor.boldBlackColor,
            size: Get.height * 0.015,
            fontFamily: AppFont.semi,
          )
        ],
      ),
    ),
  );
}

class TextWidget extends StatelessWidget {
   TextWidget({Key? key,this.hint = "",this.color}) : super(key: key);
   String  hint;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      hint,
      style: TextStyle(
        fontSize: AppSizes.size_12,
        fontFamily: AppFont.semi,
        fontWeight: FontWeight.w400,
        color: color
      ),
    );
  }
}
