
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mart/app/bottom_tabs/dashboard/model/home_model.dart';
import 'package:mart/app/bottom_tabs/orders/model/get_orders.dart';
import 'package:mart/app/bottom_tabs/profile/model/payment_model.dart';
import 'package:mart/app/products/model/product_model.dart';
import 'package:mart/services/api_manager.dart';
import 'package:mart/widgets/helper_function.dart';



class HomeController extends GetxController {
  var token = "".obs;
  var name = "".obs;
  var image = "".obs;

  File ? fileUpdate;

  var idAddress = "".obs;
  var nameAddress = "".obs;
  var typeAddress = "".obs;

  updateId(val){
    idAddress.value = val;
    update();
  }
  updateImage(val){
    image.value = val;
    update();
  }
  updateName(val){
    name.value = val;
    update();
  }

  updateAddName(val){
    nameAddress.value = val;
    update();
  }

  updateTypeName(val){
    typeAddress.value = val;
    update();
  }








  File ?file;
  File ?file1;
  var phone = "".obs;
  var address = "".obs;
  var tabIndex = 0;

  var totalPrice = "".obs;
  updateTotalPrice(val){
    totalPrice.value = val;
    update();
  }

  var valueComp = "".obs;
  updateValueComplaint(val){
    valueComp.value = val;
    update();
  }


  var valuePay = "".obs;
  updateValuePay(val){
    valuePay.value = val;
    update();
  }


  void changeIndex(int index) {
    tabIndex = index;
    update();
  }



  var isLoading = false.obs;
  var isProductLoading = false.obs;
  var isProductCatLoading = false.obs;
  var isProductCatAllLoading = false.obs;
  var isOrderLoading = false.obs;
  var isPaymentLoading = false.obs;
  var isCartLoading = false.obs;
  var isAddressLoading = false.obs;
  var isProductSearchLoading = false.obs;

  var bannerList= <Banners>[].obs;
  var allList= [].obs;
  var catList= <Categories>[].obs;
  var updateList= <Updates>[].obs;
  var homeList= [].obs;
  var activeList= <Active>[].obs;
  var completeList= <Active>[].obs;
  var paymentList= <PaymentData>[].obs;

  var valueAll = "All".obs;
  updateValueAll(val){
    valueAll.value = val;
    update();

  }
  var productList= <ProductAllModel>[].obs;
  var productCatList= <ProductAllModel>[].obs;
  var cartList= [].obs;
  var addressList= [].obs;
  var productSearchList= <ProductAllModel>[].obs;

  var qty = 0.obs;

  updateQty(val){
    qty.value = val;
    update();

  }

  updateAddQty(){
    qty++;
    update();
  }
  updateDecQty(){
    --qty;
    update();
  }




  @override
  Future<void> onInit() async {
    HelperFunctions.getFromPreference("token").then((value)  {
      token.value = value;
      cartAllData();
      addressAllData();
      orderAllData();
      payAllData();
      AllOrderIdData();

      debugPrint(token.value);

      update();
    });
    HelperFunctions.getFromPreference("name").then((value)  {
      name.value = value;

      debugPrint(name.value);

      update();
    });
    HelperFunctions.getFromPreference("image").then((value)  {
      image.value = value;

      debugPrint(image.value);

      update();
    });
    HelperFunctions.getFromPreference("phone").then((value)  {
      phone.value = value;

      debugPrint(phone.value);

      update();
    });
    HelperFunctions.getFromPreference("address").then((value)  {
      address.value = value;

      debugPrint(address.value);

      update();
    });

    homeData();


    productSearchData(value: "");


    super.onInit();
  }


  homeData() async {
    try {
      isLoading(true);
      update();
      var homeViewData = await ApiManger.getHomeResponse();
      if (homeViewData != null) {
        bannerList.value = homeViewData.data?.banners as dynamic;
        catList.value = homeViewData.data?.categories as dynamic;
        updateList.value = homeViewData.data?.updates as dynamic;
        update();
        print("HomeData");

      } else {
        isLoading(false);
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
      update();
    }
    update();
  }


  productData({id,value=""}) async {
    try {
      isProductLoading(true);
      update();
      var homeViewData = await ApiManger.getProductResponse(id: id,search: value.toString());
      if (homeViewData != null) {
        productList.value = homeViewData.data as dynamic;
        update();
        print("HomeData");

      } else {
        isProductLoading(false);
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isProductLoading(false);
      update();
    }
    update();
  }


  productCatData({id}) async {
    try {
      isProductCatLoading(true);
      update();
      var homeViewData = await ApiManger.getProductCatResponse(id: id);
      if (homeViewData != null) {
        productCatList.value = homeViewData.data as dynamic;
        update();
        print("HomeData");

      } else {
        isProductCatLoading(false);
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isProductCatLoading(false);
      update();
    }
    update();
  }



  AllOrderIdData() async {
    try {
      isProductCatAllLoading(true);
      update();
      var homeViewData = await ApiManger.getAllResponse();
      if (homeViewData != null) {
        allList.value = homeViewData.data as dynamic;
        update();
        print("HomeData");

      } else {
        isProductCatAllLoading(false);
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isProductCatAllLoading(false);
      update();
    }
    update();
  }

  cartAllData() async {
    try {
      isCartLoading(true);
      update();
      var cartViewData = await ApiManger.getCartModelResponse();
      if (cartViewData != null) {
        cartList.value = cartViewData.data?.cart as dynamic;
        updateTotalPrice(cartViewData.data?.total.toString());
        update();
        print("THis is Cart List:::: ${cartViewData.data?.cart?.length}");

      } else {
        isCartLoading(false);
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isCartLoading(false);
      update();
    }
    update();
  }







  payAllData() async {
    try {
      isPaymentLoading(true);
      update();
      var cartViewData = await ApiManger.paymentGetResponse();
      if (cartViewData != null) {
        paymentList.value = cartViewData.data as dynamic;
        update();
        print("THis is payment List:::: ${cartViewData.data?.length}");

      } else {
        isPaymentLoading(false);
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isPaymentLoading(false);
      update();
    }
    update();
  }




  orderAllData() async {
    try {
      isOrderLoading(true);
      update();
      var cartViewData = await ApiManger.getOrdersResponse();
      if (cartViewData != null) {
        activeList.value = cartViewData.data?.active as dynamic;
        completeList.value = cartViewData.data?.complete as dynamic;
        update();
        print("THis is order List:::: ${cartViewData.data?.active?.length}");

      } else {
        isOrderLoading(false);
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isOrderLoading(false);
      update();
    }
    update();
  }



  addressAllData() async {
    try {
      isAddressLoading(true);
      update();
      var cartViewData = await ApiManger.getAddressResponse();
      if (cartViewData != null) {
        addressList.value = cartViewData.data as dynamic;
        update();
        print("THis is address List:::: ${cartViewData.data?.length}");

      } else {
        isAddressLoading(false);
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isAddressLoading(false);
      update();
    }
    update();
  }


  productSearchData({value=""}) async {
    try {
      isProductSearchLoading(true);
      update();
      var homeViewData = await ApiManger.getProductSearch(search: value.toString());
      if (homeViewData != null) {
        productSearchList.value = homeViewData.data as dynamic;
        update();
        print("HomeData");

      } else {
        isProductSearchLoading(false);
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isProductSearchLoading(false);
      update();
    }
    update();
  }










}

