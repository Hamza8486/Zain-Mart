
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mart/app/authentication/component/auth_component.dart';
import 'package:mart/app/authentication/controller/auth_controller.dart';
import 'package:mart/services/api_manager.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/addresss_widgte.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/helper_function.dart';




class RegisterView extends StatefulWidget {
  RegisterView({Key? key,this.phone}) : super(key: key);
  var phone;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentPosition = position;
      flutterToast(msg: "Please enable your location");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        Get.put(AuthController()).addressCheckController.text =
        '${place.street}, ${place.subLocality}';
      });
    }).catchError((e) {
    });
  }

  String ? token;
  void getToken() async{
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    HelperFunctions.saveInPreference("token", token!);
    print("token");
    print(token);
  }
  @override
  void initState() {
    _getCurrentPosition();
    _getCurrentPosition();
    super.initState();
    phoneController.text = widget.phone.toString();
    getToken();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom!=0;

    var size = Get.size;
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05, vertical: Get.height * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            Center(
              child: AppText(
                title: "Create an account",
                color: AppColor.blackColor,
                size: 20,
                fontFamily: AppFont.semi,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: size.height * 0.004,
            ),
            Center(
              child: AppText(
                title: "Enter information to complete profile",
                color: AppColor.blackColor,
                size: 14,
                fontFamily: AppFont.regular,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    AppText(
                      title: "Full Name",
                      color: AppColor.blackColor,
                      size: AppSizes.size_15,
                      fontFamily: AppFont.medium,
                    ),




                    TextFormField(
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColor.blackColor,
                        fontFamily: AppFont.medium,
                      ),
                      cursorColor: AppColor.primaryColor,
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      autofocus: true,
                      decoration: const InputDecoration(

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.primaryColor,   width: 2),
                        ),
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
                        hintText: 'Enter your Name',

                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColor.greyColor,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.035,
                    ),
                    AppText(
                      title: "Address",
                      color: AppColor.blackColor,
                      size: AppSizes.size_15,
                      fontFamily: AppFont.medium,
                    ),




                    AddressWidget(onTap: (){
                      setState(() {
                        _getCurrentPosition();
                      });
                    },),


                    SizedBox(
                      height: size.height * 0.035,
                    ),

                    AppText(
                      title: "Mobile Number",
                      color: AppColor.blackColor,
                      size: AppSizes.size_15,
                      fontFamily: AppFont.medium,
                    ),


                    TextFormField(
                      readOnly: true,

                      style: TextStyle(
                        fontSize: 15,
                        color: AppColor.blackColor,
                        fontFamily: AppFont.medium,
                      ),
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      cursorColor: AppColor.primaryColor,

                      textInputAction: TextInputAction.done,
                      decoration:  const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.primaryColor,
                          width: 2
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.phone_android_outlined,
                              color: AppColor.primaryColor),
                        ),


                        hintText: 'Enter your mobile number',

                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColor.greyColor,
                        ),
                        contentPadding: EdgeInsets.only(top: 16.0, left: 0.0),
                        prefixStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),



                  ],
                ),
              ),
            ),
            isKeyBoard?const SizedBox.shrink():
            SizedBox(
              height: size.height * 0.015,
            ),
            isKeyBoard?const SizedBox.shrink():
            authButton(onTap: (){
              if(validate(context)){
                showLoadingIndicator(context: context);
                ApiManger().registerResponse(context: context,
                  token: token.toString(),
                  phone: phoneController.text,
                  name: nameController.text,
                  address: Get.put(AuthController()).addressCheckController.text,

                );
              }
            },text: "Register"),
            SizedBox(
              height: size.height * 0.015,
            ),

          ],
        ),
      ),
    );
  }

  bool validate(BuildContext context) {

    if (nameController.text.isEmpty) {
      flutterToast(msg: "Please enter name");
      return false;
    }
    if (Get.put(AuthController()).addressCheckController.text.isEmpty) {
      flutterToast(msg: "Please enter address");
      return false;
    }
    if (phoneController.text.isEmpty) {
      flutterToast(msg: "Please enter phone");
      return false;
    }

    return true;
  }

}