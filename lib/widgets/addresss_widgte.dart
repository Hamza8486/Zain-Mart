
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mart/app/authentication/controller/auth_controller.dart';
import 'package:mart/util/theme.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:get/get.dart';



class AddressWidget extends StatefulWidget {
  AddressWidget({
    Key? key,this.onTap
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
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
    if (authController.addressCheckController.text.isNotEmpty) {
      setState(() {
        getSuggessionDrop(authController.addressCheckController.text);
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
    authController.addressCheckController.addListener(() {
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

        TextFormField(
          style: TextStyle(
            fontSize: 15,
            color: AppColor.blackColor,
            fontFamily: AppFont.medium,
          ),
          cursorColor: AppColor.primaryColor,
          controller: authController.addressCheckController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          autofocus: true,
          onFieldSubmitted: (val) {
            FocusScope.of(context)
                .requestFocus(this.dropOffFocus);
          },
          onChanged: (value) {
            setState(() {
              if (authController.addressCheckController
                  .text.isNotEmpty) {
                isListViewOpenDropOf = true;
                setState(() {
                  authController.lat.value = 0.0;
                  authController.lng.value = 0.0;
                });
              } else {
                isListViewOpenDropOf = false;
              }
            });
          },
          decoration:  InputDecoration(

            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryColor,   width: 2),
            ),
            suffixIcon: GestureDetector(
                onTap: widget.onTap,
                child: Icon(Icons.location_searching,color: AppColor.primaryColor,size: AppSizes.size_20,)),
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.person,
                  color: AppColor.primaryColor),

            ),
            contentPadding: EdgeInsets.only(top: 16.0, left: 0.0),
            prefixStyle: TextStyle(
              fontSize: 15.0,
              color: AppColor.blackColor,
            ),
            hintText: 'Enter your address',

            hintStyle: TextStyle(
              fontSize: 15.0,
              color: AppColor.greyColor,
            ),
          ),
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
                        authController.addressCheckController
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
