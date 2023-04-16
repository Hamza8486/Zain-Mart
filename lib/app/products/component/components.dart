import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_text.dart';

Widget productWidget({image,name,img,price,Color? color,text, bool isSold = false,
  Widget?child,Color?discountColor,String?dis,Color?priceColro


}){
  return Column(
    children: [
      Card(
        margin: EdgeInsets.zero,
        color: AppColor.whiteColor,

        shadowColor: Colors.grey.withOpacity(0.5),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColor.borderColorField)
        ),


        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isSold==true?
           Container(
             decoration: BoxDecoration(borderRadius:BorderRadius.only(topRight: Radius.circular(10),
             topLeft: Radius.circular(10)
             ),
             color: Colors.black12.withOpacity(0.03)
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Align(
                   alignment: Alignment.topRight,
                   child: Container(
                     decoration: BoxDecoration(
                         color: color ?? Colors.greenAccent,
                         borderRadius: const BorderRadius.only(
                             topRight: Radius.circular(10),
                             bottomLeft: Radius.circular(10))),
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                       child: AppText(
                         title: text,
                         size: Get.height * 0.009,
                         fontFamily: AppFont.semi,
                         color: AppColor.whiteColor,
                       ),
                     ),
                   ),
                 ),
                 SizedBox(
                   height: Get.height * 0.007,
                 ),
                 Container(
                   height: Get.height*0.12,
                   width: Get.width,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       image: DecorationImage(
                           image: NetworkImage(image,),
                           fit: BoxFit.fitHeight
                       )
                   ),
                   child: Image.asset("assets/images/sold.png",
                     scale: 11,
                   ),
                 ),
                 SizedBox(height: Get.height*0.015,),
               ],
             ),
           ):Column(

             children: [
               Align(
                 alignment: Alignment.center,
                 child: Container(
                   decoration: BoxDecoration(
                       color:discountColor??  Colors.teal.withOpacity(0.6),
                       borderRadius: const BorderRadius.only(
                           bottomRight: Radius.circular(15),
                           bottomLeft: Radius.circular(15))),
                   child: Padding(
                     padding:  EdgeInsets.symmetric(horizontal: Get.width*0.09, vertical: 3),
                     child: AppText(
                       title: dis??"",
                       size: Get.height * 0.016,
                       fontFamily: AppFont.bold,
                       color: AppColor.whiteColor,
                     ),
                   ),
                 ),
               ),
               SizedBox(
                 height: Get.height * 0.005,
               ),
               Padding(
                 padding:  EdgeInsets.only(bottom: 5),
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                   child: CachedNetworkImage(
                     placeholder: (context, url) =>const Center(
                       child: SpinKitThreeBounce(
                           size: 22,
                           color: AppColor.primaryColor
                       ),
                     ),
                     imageUrl: image,
                     height: Get.height * 0.14,
                     width: Get.height * 0.16,
                     fit: BoxFit.contain,

                     errorWidget: (context, url, error) => ClipRRect(
                         borderRadius: BorderRadius.circular(10),
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(10),
                           child: Image.asset(
                             img,
                             height: Get.height * 0.14,
                             width: Get.height * 0.16,
                             fit: BoxFit.contain,
                           ),
                         )
                     ),
                   ),
                 ),
               ),

             ],
           ),
              SizedBox(height: Get.height*0.013,),



            ],
          ),
        ),
      ),
      SizedBox(height: Get.height*0.01,),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Row(
              children: [


                Text(price,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:priceColro?? Colors.red,
                    fontSize: AppSizes.size_15,
                    decoration: TextDecoration.none,
                    overflow: TextOverflow.ellipsis,

                    fontFamily: AppFont.medium,
                    fontWeight: FontWeight.w500,
                  ),),
                SizedBox(width: 5,),
                child??
                    Text("",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.transparent,
                        fontSize: AppSizes.size_16,
                        decoration: TextDecoration.none,
                        overflow: TextOverflow.ellipsis,

                        fontFamily: AppFont.medium,
                        fontWeight: FontWeight.w500,
                      ),),
              ],
            ),


          ],
        ),
      ),

      SizedBox(height: 2,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: Get.width,
          child: AppText(
            title: name,
            size: AppSizes.size_13,
            maxLines: 2,
            overFlow: TextOverflow.ellipsis,
            // textAlign: TextAlign.justify,
            color: AppColor.blackColor,
            fontFamily: AppFont.medium,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}


