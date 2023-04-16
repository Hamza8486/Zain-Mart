import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mart/app/authentication/component/auth_component.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/services/api_manager.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_button.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/app_textfield.dart';
import 'package:mart/widgets/drop_down.dart';



class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final homeController = Get.put(HomeController());
  late GoogleMapController _controller;
  String location = "";
  TextEditingController title = TextEditingController();
  TextEditingController street = TextEditingController();
  String ?locationType;
  var lat;
  var lng;

  CameraPosition? cameraPosition;
  late Position currentLocation;
  var geoLocator = Geolocator();
  void locationPosition() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLocation = position;
    LatLng latlatPostion = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPositions =
    CameraPosition(target: latlatPostion, zoom: 16);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPositions));
  }

  @override
  void initState() {
    locationPosition();

    super.initState();
    locationPosition();
  }
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
                    padding: const EdgeInsets.only(right: 20),
                    child: AppText(
                      title: "Create Address",
                      color: AppColor.blackColor,
                      size: AppSizes.size_16,
                      fontFamily: AppFont.semi,
                    ),
                  ),
                  SizedBox()
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),



              Expanded(
                  child:SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              height: Get.height*0.3,
                              decoration: BoxDecoration(border: Border.all(color: AppColor.primaryColor,

                              ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: GoogleMap(
                                  zoomControlsEnabled: false,
                                  initialCameraPosition: const CameraPosition(
                                    target: LatLng(48.8561, 2.2930),
                                    zoom: 13.0,
                                  ),
                                  myLocationEnabled: true,
                                  zoomGesturesEnabled: true,
                                  mapToolbarEnabled: false,
                                  myLocationButtonEnabled: false,
                                  onMapCreated: (GoogleMapController controller) {
                                    _controller = controller;
                                    locationPosition();
                                  },
                                  onCameraMove: (CameraPosition cameraPositiona) {
                                    cameraPosition = cameraPositiona;
                                  },
                                  onCameraIdle: () async {
                                    List<Placemark> placemarks = await placemarkFromCoordinates(
                                        cameraPosition!.target.latitude,
                                        cameraPosition!.target.longitude);
                                    setState(() {
                                      print(placemarks);
                                      print(cameraPosition!.target.latitude);
                                      print(cameraPosition!.target.longitude);

                                      location = placemarks.first.administrativeArea.toString() +
                                          ", " +
                                          placemarks.first.street.toString() +
                                          ", " +
                                          placemarks.first.subLocality.toString() +
                                          ", " +
                                          placemarks.first.locality.toString();

                                      title.text = location;
                                     lat = cameraPosition!.target.latitude;
                                      lng = cameraPosition!.target.longitude;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                                top: Get.height * 0.01,
                                right: Get.width * 0.03,
                                child: InkWell(
                                    onTap: () {
                                      locationPosition();
                                    },
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: AppColor.whiteColor.withOpacity(0.9),
                                      child: const Icon(
                                        Icons.location_searching,
                                        color: AppColor.blackColor,
                                      ),
                                    ))),
                            Padding(
                              padding:  EdgeInsets.only(top: Get.height*0.12),
                              child: Center(
                                //picker image on google map
                                child: InkWell(
                                    onTap: () {
                                      location;
                                      print(location);
                                    },
                                    child: Image.asset("assets/images/pin.png",
                                      height: Get.height*0.06,
                                    )),
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        AppText(
                          title: "Select Address Type",
                          color: AppColor.blackColor,
                          size: AppSizes.size_14,
                          fontFamily: AppFont.medium,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: SortedByDropDown(
                              hint: "Select address type",
                              icon: null,
                              buttonDecoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                border: Border.all(
                                    color: AppColor.borderColorField, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fontSize: AppSizes.size_14,
                              fontFamily: AppFont.medium,
                              hintColor: AppColor.blackColor.withOpacity(0.5),
                              fontFamily1: AppFont.medium,
                              fontSize1: AppSizes.size_13,
                              dropdownItems: ["Home","Office","Shop","Other"],
                              value: locationType,
                              buttonHeight: Get.height * 0.06,
                              dropdownHeight: Get.height * 0.3,
                              dropdownWidth: Get.width*0.92,
                              buttonElevation: 0,
                              onChanged: (val){
                                setState(() {
                                  locationType = val.toString();
                                });
                              }
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AppText(
                          title: "Street No.",
                          color: AppColor.blackColor,
                          size: AppSizes.size_14,
                          fontFamily: AppFont.medium,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        AppTextFied(
                          fillColor:AppColor.whiteColor,
                          isFill: true,

                          isborderline: true,
                          controller: street,
                          autovalidateMode:  AutovalidateMode.onUserInteraction,
                          isborderline2: true,
                          isSuffix: true,
                          padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0185),                        borderRadius: BorderRadius.circular(10),
                          borderRadius2: BorderRadius.circular(10),
                          borderColor:AppColor.borderColorField,
                          hint: "Enter Street No.",

                          hintColor: AppColor.blackColor.withOpacity(0.5),
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,

                          hintSize: AppSizes.size_13,
                          fontFamily:AppFont.medium,
                          borderColor2: AppColor.primaryColor,

                          maxLines: 1,
                        ),

                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AppText(
                          title: "Address",
                          color: AppColor.blackColor,
                          size: AppSizes.size_14,
                          fontFamily: AppFont.medium,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        AppTextFied(
                          fillColor:AppColor.whiteColor,
                          isFill: true,

                          isborderline: true,
                          controller: title,
                          autovalidateMode:  AutovalidateMode.onUserInteraction,
                          isborderline2: true,
                          isSuffix: true,
                          padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0185),                        borderRadius: BorderRadius.circular(10),
                          borderRadius2: BorderRadius.circular(10),
                          borderColor:AppColor.borderColorField,
                          hint: "Enter Address",

                          hintColor: AppColor.blackColor.withOpacity(0.5),
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,

                          hintSize: AppSizes.size_13,
                          fontFamily:AppFont.medium,
                          borderColor2: AppColor.primaryColor,

                          maxLines: 1,
                        ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    authButton(text:"Create",onTap:
                        (){
                      if(validateAddress(context)){
                        showLoadingIndicator(context: context);
                        ApiManger().addAddressResponse(context: context,
                            title: street.text,
                            desc: title.text,
                            type: locationType.toString()

                        );
                      }

                    }
                    )
                      ],
                    ),
                  )
              ),

            ],
          ),
        )

    );
  }

  bool validateAddress(BuildContext context) {

    if (locationType==null) {
      flutterToast(msg: "Please select address type");
      return false;
    }
    if (street.text.isEmpty) {
      flutterToast(msg: "Please enter street no.");
      return false;
    }
    if (title.text.isEmpty) {
      flutterToast(msg: "Please enter address");
      return false;
    }

    return true;
  }
}



