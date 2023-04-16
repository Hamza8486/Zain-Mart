// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mart/util/constant.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_text.dart';

class Items extends StatelessWidget {
  Items({Key? key,this.data}) : super(key: key);
  var data;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: data.orderProducts.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(top: 10, right: 10),
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromRGBO(249, 249, 249, 1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                                placeholder: (context, url) => Center(
                                  child: SpinKitThreeBounce(
                                      size: 15,
                                      color: AppColor.primaryColor
                                  ),
                                ),
                                imageUrl:  data.orderProducts[index].product.productImages.isEmpty?"":
                                data.orderProducts[index].product.productImages[0].image,
                                fit: BoxFit.fill,

                                errorWidget: (context, url, error) => Image.asset("assets/images/product.png")
                            ),









                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width * 0.4,
                              child: AppText(
                                title: data.orderProducts[index].product.title,
                                fontFamily: AppFont.medium,
                                color: AppColor.boldBlackColor,
                                maxLines: 1,
                                overFlow: TextOverflow.ellipsis,
                                size: AppSizes.size_13,
                              ),
                            ),
                            AppText(
                              title:
                              'qty# ${data.orderProducts[index].quantity.toString()}',
                              fontFamily: AppFont.medium,
                              color: Color.fromRGBO(14, 15, 25, .65),
                              size: AppSizes.size_13,
                            ),
                          ],
                        ),
                      ],
                    ),
                    AppText(
                      title: "Rs.${data.orderProducts[index].quantity* (double.parse(data.orderProducts[index].product.sellingPrice) - double.parse(data.orderProducts[index].product.discount)).toInt()}/-",
                      fontFamily: AppFont.semi,
                      color: AppColor.boldBlackColor,
                      size: AppSizes.size_14,
                    ),
                  ],
                ),
              );
            }),

      ],
    );
  }
}
