import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mart/app/bottom_tabs/profile/component/get_address.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/services/api_manager.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/app_textfield.dart';

class Checkout extends StatefulWidget {
  Checkout({Key? key,}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final homeController = Get.put(HomeController());
  String datetime = DateTime.now().toString();
  TextEditingController date = TextEditingController();
  TextEditingController notes = TextEditingController();
  var dataBack="back";

  @override
  void initState() {

    super.initState();

    setState(() {

      date.text = datetime.split(" ").first;

    });
  }

  @override
  Widget build(BuildContext context) {
    print(date.text);
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding:AppPaddings.mainPadding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: Get.height * 0.035,
          ),
          Row(

            children: [
              backButton(onTap: () {
               Navigator.pop(context);
              }),
              SizedBox(width: Get.width*0.28,),
              AppText(
                title: "Checkout",
                color: AppColor.boldBlackColor,
                size: AppSizes.size_16,
                fontFamily: AppFont.semi,
              ),
              SizedBox()
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  AppText(
                    title: "Delivery Option",
                    color: AppColor.boldBlackColor,
                    fontFamily: AppFont.regular,
                    size: size.height * 0.019,
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 17,
                        color: AppColor.boldBlackColor,
                      ),
                      SizedBox(width: Get.width*0.03,),
                      AppText(
                        title: "Cash On Delivery",
                        size: size.height * 0.016,
                        color: AppColor.boldBlackColor,
                        fontFamily: AppFont.medium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        title: "Delivery Address",
                        color: AppColor.boldBlackColor,
                        fontFamily: AppFont.regular,
                        size: size.height * 0.019,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(GetAddress(data: dataBack,),
                              transition: Transition.rightToLeft
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: AppText(
                              title: "Change Address",
                              color: Colors.red,
                              fontFamily: AppFont.semi,
                              size: AppSizes.size_13
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () {
                          return
                            homeController.idAddress.value.isEmpty?
                            Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 22,
                                color: AppColor.primaryColor,
                              ),
                              SizedBox(width: Get.width*0.03,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(

                                    title:
                              homeController.addressList.isEmpty?"":
                                    homeController.addressList[0].name.toString(),
                                    size:AppSizes.size_15,
                                    color: AppColor.boldBlackColor,
                                    fontFamily: AppFont.medium,
                                  ),
                                  SizedBox(height: Get.height*0.005,),
                                  SizedBox(
                                    width:Get.width*0.8,
                                    child: AppText(
                                      title:
                                      homeController.addressList.isEmpty?"":
                                      homeController.addressList[0].location.toString(),
                                      size:AppSizes.size_15,
                                      maxLines: 2,
                                      overFlow: TextOverflow.ellipsis,
                                      color: AppColor.boldBlackColor,
                                      fontFamily: AppFont.medium,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ): Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 22,
                                  color: AppColor.primaryColor,
                                ),
                                SizedBox(width: Get.width*0.03,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(

                                      title:homeController.typeAddress.value.isEmpty?"Home":homeController.typeAddress.value,
                                      size:AppSizes.size_15,
                                      color: AppColor.boldBlackColor,
                                      fontFamily: AppFont.medium,
                                    ),
                                    SizedBox(height: Get.height*0.005,),
                                    SizedBox(
                                      width:Get.width*0.8,
                                      child: AppText(
                                        title:homeController.nameAddress.value,
                                        size:AppSizes.size_15,
                                        maxLines: 2,
                                        overFlow: TextOverflow.ellipsis,
                                        color: AppColor.boldBlackColor,
                                        fontFamily: AppFont.medium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                        }
                      ),

                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  AppText(
                    title: "Order Instruction",
                    color: AppColor.boldBlackColor,
                    fontFamily: AppFont.regular,
                    size: size.height * 0.019,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  AppTextFied(
                    maxLines: 2,
                    hint: "Order Instruction",
                    isborderline1: true,
                    controller: notes,
                    borderRadius: BorderRadius.circular(10),
                    borderColor: AppColor.boldBlackColor,
                    borderColor1: AppColor.boldBlackColor,
                    borderRadius1: BorderRadius.circular(10),
                    borderColor2: AppColor.boldBlackColor,
                    isborderline2: true,
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                    isborderline: true,
                    borderRadius2: BorderRadius.circular(10),

                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  AppText(
                    title: "Order Date",
                    color: AppColor.boldBlackColor,
                    fontFamily: AppFont.regular,
                    size: size.height * 0.019,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  AppTextFied(
                    maxLines: 1,
                    hint: "Select order date",
                    isborderline1: true,
                    isReadOnly: true,
                    isShowCursor: false,
                    isSuffix: true,
                    borderRadius: BorderRadius.circular(10),
                    borderColor: AppColor.boldBlackColor,
                    controller: date,
                    onTap: () async{
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,

                          builder: (BuildContext? context,
                              Widget? child) {
                            return Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                  width: 350.0,
                                  // height: Get.height,
                                  child: Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor:
                                      AppColor.blackColor,
                                      accentColor:
                                      AppColor.blackColor,
                                      colorScheme: ColorScheme.light(
                                        primary:
                                        AppColor.blackColor,),
                                      buttonTheme: ButtonThemeData(
                                          buttonColor:
                                          AppColor.primaryColor),
                                    ),
                                    child: child!,
                                  ),
                                ));
                          },

                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050));


                      if (pickedDate != null) {
                        date.text =
                            DateFormat('yyyy-MM-dd')
                                .format(pickedDate);
                      }
                    },
                    suffixIcon:Icon(Icons.calendar_month_sharp,color: AppColor.primaryColor,
                    size: Get.height*0.03,
                    ),

                    borderColor1: AppColor.boldBlackColor,
                    borderRadius1: BorderRadius.circular(10),
                    borderColor2: AppColor.boldBlackColor,
                    isborderline2: true,
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                    isborderline: true,
                    borderRadius2: BorderRadius.circular(10),

                  )
                ],
              ),
            ),
          ),
          isKeyBoard?SizedBox.shrink():
          Obx(
            () {
              return Column(children: [
                Column(
                  children: [
                    data(
                      context: context,
                      title:homeController.cartList.isEmpty?"Total Items": "Total Items",
                      title1: homeController.cartList.length.toString(),
                    ),
                    data(
                      context: context,
                      title: "Subtotal",
                      title1: "Rs.${homeController.totalPrice.value.toString()}",
                    ),
                  ],
                ),
                const DottedLine(
                  lineThickness: 0.5,
                  dashLength: 7.0,
                  dashColor: AppColor.boldBlackColor,
                  dashRadius: 0.0,
                  dashGapLength: 7.0,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Obx(
                  () {
                    return _textRow(
                      context: context,
                      text: homeController.cartList.isEmpty?"Total Amount":"Total Amount",
                      color: AppColor.boldBlackColor,
                      text1: "Rs.${homeController.totalPrice.value.toString()}",
                      colorText: AppColor.boldBlackColor,
                    );
                  }
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Obx(
                  () {
                    return AppButton(
                            buttonWidth: Get.width,
                            buttonName: "Order Place",
                            fontFamily:Get.put(HomeController()).name.value.isEmpty?AppFont.medium: AppFont.medium,
                            textSize: Get.height * 0.017,
                            buttonColor: AppColor.primaryColor,

                            textColor: AppColor.whiteColor,
                            onTap:
                            double.parse(homeController.totalPrice.value).toInt() >= 500?

                                (){
                              print(homeController.addressList[0].id.toString());
                              print(notes.text);
                              print(date.text);
                              showLoadingIndicator(context: context);
                              ApiManger().placeOrderResponse(
                                id:
                                homeController.idAddress.value.isEmpty?
                                homeController.addressList[0].id.toString(): homeController.idAddress.value,
                                context: context,
                                instruction: notes.text,
                                date: date.text
                              );
                            }:(){
                              flutterToast(msg: "Minimum order Rs 500/-");
                            },

                            buttonRadius: BorderRadius.circular(10),
                          );
                  }
                ),
                SizedBox(
                  height: Get.height * 0.09,
                ),

              ]);
            }
          )
        ]),
      ),
    );
  }

  Widget _textRow(
      {text, required BuildContext context, color, text1, colorText}) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
            fontFamily: AppFont.medium,
            title: text,
            size: size.height * 0.02,
            color: color),
        AppText(
            fontFamily: AppFont.medium,
            title: text1,
            size: size.height * 0.02,
            color: colorText),
      ],
    );
  }

  Widget data({required BuildContext context, title, title1}) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title: title,
            color: AppColor.boldBlackColor,
            fontFamily: AppFont.regular,
            size: size.height * 0.019,
          ),
          AppText(
            title: title1,
            color: AppColor.boldBlackColor,
            fontFamily: AppFont.medium,
            size: size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
