
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mart/app/authentication/controller/auth_controller.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/widgets/app_textfield.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:get/get.dart';



class ChangeAddress extends StatefulWidget {
  ChangeAddress({
    Key? key,this.onTap
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  State<ChangeAddress> createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  final dropOffFocus = FocusNode();

  String _sessionToken2 = '12345';
  var uuid = Uuid();
  bool isListViewOpenDropOf = false;
  List<dynamic> placesListDropOf = [];
  Timer? _debounce;

  Future<LatLng> getLatLngFromAddress(var address) async {
    GeoData data = await Geocoder2.getDataFromAddress(
        address: address, googleMapApiKey:"AIzaSyBfd3J1uwYr-qhOrk8dke78tE8hMPvStXc");
    return LatLng(data.latitude, data.longitude);
  }

  final authController = Get.put(AuthController());






  void onChangeDropOff() {
    if (_sessionToken2 == null || _sessionToken2.isEmpty) {
      setState(() {
        _sessionToken2 = uuid.v4();
      });
    }
    if (authController.addressController.text.isNotEmpty) {
      setState(() {
        getSuggessionDrop(authController.addressController.text);
      });
    }
  }
  String  status = "";


  void getSuggessionDrop(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=AIzaSyBfd3J1uwYr-qhOrk8dke78tE8hMPvStXc&sessiontoken=$_sessionToken2';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    debugPrint('data:::::::::${data}');
    if (response.statusCode == 200) {
      setState(() {
        placesListDropOf = jsonDecode(response.body.toString())['predictions'];
        status = jsonDecode(response.body.toString())['status'];
        print("This is status$status");
      });
    } else {
      print("hamzaaa");
      throw Exception();
    }
  }

  @override
  void initState() {
    authController.addressController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 00), () {
        onChangeDropOff();
      });
    });
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        AppTextFied(
          fillColor:AppColor.whiteColor,
          isFill: true,
          isborderline: true,
          controller: authController.addressController,
          autovalidateMode:  AutovalidateMode.onUserInteraction,
          isborderline2: true,
          isSuffix: true,
          padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0185),                        borderRadius: BorderRadius.circular(10),
          borderRadius2: BorderRadius.circular(10),
          borderColor:AppColor.borderColorField,
          hint: "Enter Address",
          // onFieldSubmitted: (val) {
          //   FocusScope.of(context)
          //       .requestFocus(this.dropOffFocus);
          // },
          // onChange: (value) {
          //   setState(() {
          //     if (authController.addressController
          //         .text.isNotEmpty) {
          //       isListViewOpenDropOf = true;
          //       setState(() {
          //         authController.lat.value = 0.0;
          //         authController.lng.value = 0.0;
          //       });
          //     } else {
          //       isListViewOpenDropOf = false;
          //     }
          //   });
          // },

          hintColor: AppColor.blackColor.withOpacity(0.5),
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.done,

          hintSize: AppSizes.size_13,
          fontFamily:AppFont.medium,
          borderColor2: AppColor.primaryColor,

          maxLines: 1,
        ),



        status =="ZERO_RESULTS"?SizedBox.shrink():
        isListViewOpenDropOf
            ?SizedBox(height: Get.height*0.01,):Container(),
        status =="ZERO_RESULTS"?SizedBox.shrink():
        isListViewOpenDropOf
            ? Padding(
          padding:
          const EdgeInsets.only(top: 0.0),
          child: Container(
            height: Get.height*0.2,
            color: Colors.transparent,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,

                itemCount:
                placesListDropOf.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      LatLng latLng =
                      await getLatLngFromAddress(
                          placesListDropOf[
                          index][
                          'description']);
                      debugPrint("Lat Lng");
                      debugPrint(
                        latLng.latitude.toString(),
                      );
                      print(
                        latLng.longitude,
                      );

                      setState(() {
                        authController.lat = latLng.latitude;
                        authController.lng = latLng.longitude;
                        log(authController.lat.toString());
                        debugPrint(authController.lat.toString() );
                        authController.addressController
                            .text =
                        placesListDropOf[
                        index]
                        ['description'];
                        isListViewOpenDropOf =
                        false;
                        FocusScope.of(context)
                            .unfocus();
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            CircleAvatar(
                              radius: 9,
                              backgroundColor: AppColor.blackColor,
                              child: Icon(
                                Icons.location_on_rounded,
                                color: AppColor.whiteColor,
                                size: Get.height * 0.014,
                              ),
                            ),
                            SizedBox(width: Get.width*0.02,),
                            Expanded(
                              child: Text(
                                placesListDropOf[index]
                                ['description'],
                                style: TextStyle(
                                    color: AppColor
                                        .blackColor,
                                    fontSize: AppSizes.size_13,fontFamily: AppFont.medium
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );



                }),
          ),
        )
            : Container(),

      ],
    );
  }
}
