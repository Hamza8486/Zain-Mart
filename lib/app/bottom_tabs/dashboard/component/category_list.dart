import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mart/app/bottom_tabs/dashboard/component/component.dart';
import 'package:mart/app/bottom_tabs/dashboard/component/sub_category.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/bottom_sheet.dart';
import 'package:mart/widgets/helper_function.dart';

class CategoryList extends StatelessWidget {
   CategoryList({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return    Obx(
      () {
        return
          homeController.isLoading.value?
          GridView.builder(

              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: Get.width/Get.height*1.95,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 10),
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
          homeController.catList.isNotEmpty?


          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            primary: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,

                childAspectRatio: 1.7/2.5 ,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7),
            itemCount: homeController.catList.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                  onTap: (){
                    homeController.updateValueAll("All");
                    homeController.productCatData(id:homeController.catList[index].id.toString() );
                    Navigator.of(context,
                        rootNavigator:
                        false)
                        .push(
                        MaterialPageRoute(
                            builder: (context) =>
                                SubCategoryAll(data:homeController.catList[index] ,)));

                  },
                  child: boxWidget(name: homeController.catList[index].name??"",image:homeController.catList[index].image.toString(),img: "assets/images/grocery.png",

                      text: homeController.catList[index].promote=="0"?"": "PROMOTED",
                    color: homeController.catList[index].promote=="0"?Colors.transparent:Colors.green,
                    height: homeController.catList[index].promote=="0"?0:Get.height*0.01
                  ));
            }):noData();
      }
    );
  }
}
