import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mart/app/authentication/register/view/register_view.dart';
import 'package:mart/app/bottom_tabs/dashboard/model/home_model.dart';
import 'package:mart/app/bottom_tabs/orders/model/get_orders.dart';
import 'package:mart/app/bottom_tabs/profile/model/order_model.dart';
import 'package:mart/app/bottom_tabs/profile/model/payment_model.dart';
import 'package:mart/app/cart_list/model/update_cart.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/app/home/view/home_view.dart';
import 'package:mart/app/my_orders/all_orders.dart';
import 'package:mart/app/order_place/model/get_address.dart';
import 'package:mart/app/products/model/get_cart_model.dart';
import 'package:mart/app/products/model/product_model.dart';
import 'package:mart/util/constant.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/helper_function.dart';


class ApiManger extends GetConnect {
  static var client = http.Client();
  var isLoading = false.obs;

  static Uri uriPath({required String nameUrl}) {
    log("Url: ${AppConstants.baseURL}$nameUrl");
    return Uri.parse(AppConstants.baseURL + nameUrl);
  }


  loginResponse({required BuildContext context, phone,token}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'phone': phone,
        'device_token': token,
      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.login,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        // Navigator.pop(context);

        HelperFunctions.saveInPreference(
            "name", response.data["data"]['name'].toString());
        HelperFunctions.saveInPreference(
            "image",
            response.data["data"]['image'] == null
                ? ""
                :

            response.data["data"]['image'].toString());
        HelperFunctions.saveInPreference("phone",
            response.data["data"]['phone'].toString());
        HelperFunctions.saveInPreference(
            "address", response.data["data"]['address'].toString());
        HelperFunctions.saveInPreference(
            "id", response.data["data"]['id'].toString());
        HelperFunctions.saveInPreference(
            "token", response.data["token"].toString());

        Get.offAll(() => BottomNavBar(), transition: Transition.cupertinoDialog);

        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
      else if(response.statusCode == 202){
        Navigator.pop(context);
        flutterToast(msg:"Create your account!" );
        Get.to(RegisterView(phone: phone,));

      }
    } on dio.DioError catch (e) {
      Navigator.pop(context);
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }


  registerResponse({required BuildContext context, phone,token,name,address}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'phone': phone,
        'name': name,
        'address': address,
        'device_token': token,
      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.register,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        // Navigator.pop(context);

        HelperFunctions.saveInPreference(
            "name", response.data["data"]['name'].toString());
        HelperFunctions.saveInPreference("phone",
            response.data["data"]['phone'].toString());
        HelperFunctions.saveInPreference(
            "address", response.data["data"]['address'].toString());
        HelperFunctions.saveInPreference(
            "id", response.data["data"]['id'].toString());
        HelperFunctions.saveInPreference(
            "token", response.data["token"].toString());
        flutterToastSuccess(msg: "Account Created Successfully!");

        Get.offAll(() =>  BottomNavBar(), transition: Transition.cupertinoDialog);

        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
      else if(response.statusCode == 202){
        Navigator.pop(context);


      }
    } on dio.DioError catch (e) {
      Navigator.pop(context);
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }



  static Future<HomeModel?> getHomeResponse() async {
    var response = await client.get(uriPath(nameUrl: AppConstants.getHome),);
    log("response.statusCode");
    log(response.statusCode.toString());
    log(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return homeModelFromJson(jsonString);
    } else {
      debugPrint(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<ProductModel?> getProductResponse({id,search=""}) async {
    var response = await client.get(uriPath(nameUrl: "${AppConstants.getProduct+id}/$search"),);
    log("response.statusCode");
    log(response.statusCode.toString());
    log(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productModelFromJson(jsonString);
    } else {
      debugPrint(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  static Future<ProductModel?> getProductCatResponse({id}) async {
    var response = await client.get(uriPath(nameUrl: AppConstants.prodCat+id),);
    log("response.statusCode");
    log(response.statusCode.toString());
    log(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productModelFromJson(jsonString);
    } else {
      debugPrint(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  static Future<CartListModel?> getCartModelResponse() async {
    var response = await client.get(uriPath(nameUrl: AppConstants.cartGet),
        headers: {
          // HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"

        });

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      return cartListModelFromJson(response.body);
    } else {
      debugPrint(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<GetAddressModel?> getAddressResponse() async {
    var response = await client.get(uriPath(nameUrl: AppConstants.getAddress),
        headers: {
          // HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"

        });

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      return getAddressModelFromJson(response.body);
    } else {
      debugPrint(response.statusCode.toString());

      //show error message
      return null;
    }
  }




  static Future<AllOrderIdModel?> getAllResponse() async {
    var response = await client.get(uriPath(nameUrl: AppConstants.activeAll),
        headers: {
          // HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"

        });

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      return allOrderIdModelFromJson(response.body);
    } else {
      debugPrint(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<GetOrdersModel?> getOrdersResponse() async {
    var response = await client.get(uriPath(nameUrl: AppConstants.orderGet),
        headers: {
          // HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"

        });

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      return getOrdersModelFromJson(response.body);
    } else {
      debugPrint(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<PaymentModel?> paymentGetResponse() async {
    var response = await client.get(uriPath(nameUrl: AppConstants.paymentsAll),
        headers: {
          // HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"

        });

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      return paymentModelFromJson(response.body);
    } else {
      debugPrint(response.statusCode.toString());

      //show error message
      return null;
    }
  }




  // static Future<CartDelete?> deleteResponse() async {
  //   var response = await client.get(uriPath(nameUrl: AppConstants.cartGet),
  //       headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //         HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token}"
  //
  //       });
  //
  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     return getCartListModelFromJson(jsonString);
  //   } else {
  //     debugPrint(response.statusCode.toString());
  //
  //     //show error message
  //     return null;
  //   }
  // }

  static Future<ProductModel?> getProductSearch({search=""}) async {
    var response = await client.get(uriPath(nameUrl: "${AppConstants.searchProd}/$search"),);
    log("response.statusCode");
    log(response.statusCode.toString());
    log(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productModelFromJson(jsonString);
    } else {
      debugPrint(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  addCartResponse(
      {required BuildContext context,
        id,
      }) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'product_id': id,
        'quantity': Get.put(HomeController()).qty.value.toString(),

      });
      print(data);

      var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.cart,
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
            }


          ));

      if (response.statusCode == 200) {
        print(response.data.toString());
        Get.put(HomeController()).cartAllData();


      } else if(response.statusCode==202) {
        flutterToast(msg:response.data["error"].toString() );
        print(response.data.toString());
      }
    } on dio.DioError catch (e) {
      Navigator.pop(context);
      print(e.response?.data.toString());


      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }




  deleteCartResponse(
      {required BuildContext context,
        id,
      }) async {
    try {


      var response = await dio.Dio().delete(
          AppConstants.baseURL + AppConstants.delCart+id,

          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
          }


          ));

      if (response.statusCode == 200) {
        print(response.data.toString());
        Navigator.pop(context);
        Get.put(HomeController()).cartAllData();
        flutterToast(msg:"Item deleted successfully!" );

      } else if(response.statusCode==202) {
        Navigator.pop(context);
        flutterToast(msg:response.data["error"].toString() );
        print(response.data.toString());
      }
    } on dio.DioError catch (e) {
      print(e.response?.data.toString());


      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }





  complaintResponse({required BuildContext context, title, desc,file}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'title': title,
          'description': desc,

          'image': Get.put(HomeController()).file == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(HomeController()).file!.path),
        });
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.complaintsGet,
            data: data,
            options: dio.Options(headers: {
              // HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"

            }));
        if (response.statusCode == 200) {
          Get.put(HomeController()).file = null;
          Get.put(HomeController()).updateValueComplaint("");

          Navigator.pop(context);
          Navigator.pop(context);

          flutterToastSuccess(msg: "Complaint Submit Successfully");
        } else if(response.statusCode == 202) {

          Navigator.pop(context);
          flutterToast(msg: response.data["error"].toString());
        }
      } on dio.DioError catch (e) {
        Navigator.pop(context);


        debugPrint("e.response");
        debugPrint(e.response.toString());
      }
    } on dio.DioError catch (e) {
      Navigator.pop(context);
      debugPrint(e.toString());
    }
  }






  updateResponse({required BuildContext context, title,}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'name': title,
          'image': Get.put(HomeController()).fileUpdate == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(HomeController()).fileUpdate!.path),
        });
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.update,
            data: data,
            options: dio.Options(headers: {
              // HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"

            }));
        if (response.statusCode == 200) {

          HelperFunctions.saveInPreference("name",
              response.data["data"]['name'].toString());
          Get.put(HomeController()).updateName(
              response.data["data"]['name'].toString());
          Get.put(HomeController()).fileUpdate == null
              ? ""
              : HelperFunctions.saveInPreference("image",
              response.data["data"]['image'].toString());
          Get.put(HomeController()).fileUpdate == null
              ? ""
              : Get.put(HomeController()).updateImage(
              response.data["data"]['image'].toString());
          Get.put(HomeController()).fileUpdate = null;
          Navigator.pop(context);
          Navigator.pop(context);

          flutterToastSuccess(msg: "Profile Update Successfully");
        } else if(response.statusCode == 202) {
          print(response);
          print(response.statusCode);

          Navigator.pop(context);
          flutterToast(msg: response.data["error"].toString());
        }
      } on dio.DioError catch (e) {
        Navigator.pop(context);

        debugPrint(e.response?.statusCode.toString());
        debugPrint("e.response");
        debugPrint(e.response.toString());

      }
    } on dio.DioError catch (e) {
      Navigator.pop(context);
      debugPrint(e.toString());
    }
  }





  addAddressResponse({  context, title, desc,type}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'name': type,
          'street_no': title,
          'location': desc,
        });
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.addAddress,
            data: data,
            options: dio.Options(headers: {
              // HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"

            }));
        if (response.statusCode == 200) {
          Get.put(HomeController()).addressAllData() ;

          Navigator.pop(context);
          Navigator.pop(context);

          flutterToastSuccess(msg: "Address Created Successfully");
        } else if(response.statusCode == 202) {

          Navigator.pop(context);
          flutterToast(msg: response.data["error"].toString());
        }
      } on dio.DioError catch (e) {
        Navigator.pop(context);


        debugPrint("e.response");
        debugPrint(e.response.toString());
      }
    } on dio.DioError catch (e) {
      Navigator.pop(context);
      debugPrint(e.toString());
    }
  }

  deleteAddressResponse(
      {required BuildContext context,
        id,
      }) async {
    try {


      var response = await dio.Dio().delete(
          AppConstants.baseURL + AppConstants.delAddress+id,

          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
          }


          ));

      if (response.statusCode == 200) {
        print(response.data.toString());
        Navigator.pop(context);
        Get.put(HomeController()).addressAllData();
        flutterToast(msg:"address deleted successfully!" );

      } else if(response.statusCode==202) {
        Navigator.pop(context);
        flutterToast(msg:response.data["error"].toString() );
        print(response.data.toString());
      }
    } on dio.DioError catch (e) {
      print(e.response?.data.toString());


      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }






  paymentResponse({required BuildContext context, title,file,id}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'text': title,
          'order_id': id,

          'image': Get.put(HomeController()).file1 == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(HomeController()).file1!.path),
        });
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.paymentsAll,
            data: data,
            options: dio.Options(headers: {
              // HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"

            }));
        if (response.statusCode == 200) {
          Get.put(HomeController()).payAllData();
          Get.put(HomeController()).AllOrderIdData();
          Get.put(HomeController()).file1 = null;
          Get.put(HomeController()).updateValuePay("");

          Navigator.pop(context);
          Navigator.pop(context);

          flutterToastSuccess(msg: "Data Uploaded Successfully");
        } else if(response.statusCode == 202) {

          Navigator.pop(context);
          flutterToast(msg: response.data["error"].toString());
        }
      } on dio.DioError catch (e) {
        Navigator.pop(context);


        debugPrint("e.response");
        debugPrint(e.response.toString());
      }
    } on dio.DioError catch (e) {
      Navigator.pop(context);
      debugPrint(e.toString());
    }
  }












  placeOrderResponse(
      {required BuildContext context,
        id,
        date,

        instruction
      }) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'delivery_address_id': id,
        'delivery_date': date,
        'instructions': instruction,

      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");

      var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.order,
          data: data,
          options: dio.Options(headers: {
           HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
          }


          ));

      if (response.statusCode == 200) {
        print(response.data.toString());
        Get.put(HomeController()).orderAllData();
        Get.put(HomeController()).updateTypeName("");
        Get.put(HomeController()).updateId("");
        Get.put(HomeController()).updateAddName("");
        Get.offAll(AllOrders());
        Get.put(HomeController()).cartAllData();



      } else if(response.statusCode==202) {
        flutterToast(msg:response.data["error"].toString() );
        Navigator.pop(context);
        print(response.data.toString());
      }
    } on dio.DioError catch (e) {
     Navigator.pop(context);
      print(e.response?.data.toString());


      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }



  static Future<UpdateCartModel?> updateCartResp(
      {var qty,
        catId,

        var id}) async {
    Map<String, dynamic> body = Map<String, dynamic>();
    body['product_id'] = id.toString();
    body['quantity'] = qty.toString();


    print(jsonEncode(body));

    var response = await client.put(uriPath(nameUrl: "${AppConstants.updCart}$catId"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
   //  Get.put(HomeController()).cartAllData();
      //flutterToastSuccess(msg: "Cart Updated successfully");

      print(response.statusCode);
      print(response.body);

      print(jsonString.toString());
      return updateCartModelFromJson(response.body);
    } else if(response.statusCode == 202) {

      var jsonString = jsonDecode(response.body);
      flutterToast(msg: jsonString["error"].toString());
     // Navigator.pop(context);
      print(jsonString.toString());
      print(response.statusCode);

      //show error message
      return null;
    }
  }


}
