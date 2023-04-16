import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mart/app/bottom_tabs/profile/component/pay_online.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';



class BankRequest extends StatefulWidget {
  const BankRequest({Key? key}) : super(key: key);

  @override
  State<BankRequest> createState() => _BankRequestState();
}

class _BankRequestState extends State<BankRequest> {
final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
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
                    padding: const EdgeInsets.only(left: 40),
                    child: AppText(
                      title: "Payment History",
                      color: AppColor.blackColor,
                      size: AppSizes.size_16,
                      fontFamily: AppFont.semi,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context,
                          rootNavigator:
                          false)
                          .push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  PayOnline()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blueAccent,
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppText(
                          title: "Pay Online",
                          color: Colors.blueAccent,
                          size: AppSizes.size_14,
                          fontFamily: AppFont.semi,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),



              Expanded(
                  child:SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Obx(
                          () {
                            return
                              homeController.isPaymentLoading.value?loader():
                              homeController.paymentList.isNotEmpty?
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: homeController.paymentList.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    color: AppColor.whiteColor,

                                    shadowColor: Colors.grey.withOpacity(0.5),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: AppColor.borderColorField)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 75,
                                                height: 75,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color: AppColor.borderColorField),
                                                  color: Color.fromRGBO(249, 249, 249, 1),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    placeholder: (context, url) => const Center(
                                                      child: CircularProgressIndicator(
                                                        backgroundColor: Colors.black26,
                                                        valueColor: AlwaysStoppedAnimation<Color>(
                                                            AppColor.primaryColor //<-- SEE HERE

                                                        ),
                                                      ),
                                                    ),
                                                    imageUrl: homeController.paymentList[index].image.toString(),
                                                    fit: BoxFit.fill,

                                                    errorWidget: (context, url, error) => Icon(Icons.credit_card,color: AppColor.boldGreyColor,size: Get.height*0.05,)
                                                  ),






                                                ),
                                              ),
                                              SizedBox(width: Get.width*0.03,),
                                              SizedBox(
                                                width: Get.width*0.39,
                                                child: AppText(
                                                  title:
                                                  homeController.paymentList[index].text==null?"Online Payment":
                                                  homeController.paymentList[index].text.toString(),
                                                  fontFamily: AppFont.medium,
                                                  maxLines: 5,
                                                  color: AppColor.boldBlackColor,
                                                  overFlow: TextOverflow.ellipsis,
                                                  size: AppSizes.size_13,
                                                ),
                                              ),
                                            ],
                                          ),

                                          AppText(
                                            title: homeController.paymentList[index].status=="1"?"Pending":"Verify",
                                            fontFamily: AppFont.semi,
                                            color:homeController.paymentList[index].status=="1"?Colors.orange:Colors.green,
                                            overFlow: TextOverflow.ellipsis,
                                            size: AppSizes.size_13,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }):noData();
                          }
                        ),
                        SizedBox(
                          height: Get.height * 0.08,
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



