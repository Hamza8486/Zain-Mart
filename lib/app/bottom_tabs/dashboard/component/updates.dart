import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/util/constant.dart';

import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/helper_function.dart';



class UpdatesView extends StatelessWidget {
   UpdatesView({Key? key}) : super(key: key);
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
                children: [
                  backButton(onTap: (){
                    Navigator.pop(context);


                  }),


                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: AppText(
                      title: "Zain Mart",
                      color: AppColor.blackColor,
                      size: AppSizes.size_16,
                      fontFamily: AppFont.semi,
                    ),
                  ),
                  SizedBox()
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
                        homeController.isLoading.value
                            ? loader()
                            : homeController.updateList.isNotEmpty
                            ?

                        ListView.builder(
                          itemCount: homeController.updateList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Card(
                                margin: EdgeInsets.zero,
                                color: AppColor.whiteColor,

                                shadowColor: Colors.grey.withOpacity(0.5),
                                elevation: 1,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: AppColor.borderColorField)
                                ),


                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    homeController.updateList[index].image==null?SizedBox.shrink():
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 6),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),
                                            topRight: Radius.circular(10)),
                                        child:CachedNetworkImage(
                                          placeholder: (context, url) => const Center(
                                            child: SpinKitThreeBounce(
                                                size: 22,
                                                color: AppColor.primaryColor
                                            ),
                                          ),
                                          imageUrl:homeController.updateList[index].image.toString(),
                                          height: Get.height * 0.2,
                                          width: Get.width,
                                          fit: BoxFit.contain,

                                          errorWidget: (context, url, error) => ClipRRect(
                                            borderRadius:BorderRadius.circular(10),
                                            child: Image.asset(
                                              "assets/images/update.jpg",
                                              height: Get.height * 0.12,
                                              width: Get.width,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),




                                      ),
                                    ),
                                    homeController.updateList[index].update==null?SizedBox.shrink():
                                    SizedBox(height: Get.height*0.01,),
                                    homeController.updateList[index].update==null?SizedBox.shrink():
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: AppText(
                                        title: homeController.updateList[index].update.toString(),
                                        size: AppSizes.size_11,
                                        overFlow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        color: AppColor.blackColor,
                                        fontFamily: AppFont.medium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }):noData();
                    }
                  ),

              ),
              SizedBox(
                height: Get.height * 0.08,
              ),

            ],
          ),
        )

    );
  }


}



