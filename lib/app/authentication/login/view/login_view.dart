// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mart/app/authentication/component/auth_component.dart';
import 'package:mart/app/authentication/controller/auth_controller.dart';
import 'package:mart/app/authentication/otp/otp.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/helper_function.dart';
import 'package:mart/widgets/phone_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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

  String _status = '';
  bool isLoading = false;
  late User? _firebaseUser;

  late AuthCredential _phoneAuthCredential;

  late String _verificationId;

  late int _code;

  late String phoneNumber;
  final authController = Get.put(AuthController());

  String? token;
  void getToken() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    HelperFunctions.saveInPreference("token", token!);
    print("token");
    print(token);
  }

  @override
  void initState() {
    // _getCurrentPosition();
    // _getCurrentPosition();
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.mainHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * .37,
              ),

              AppText(
                title: "SignIn",
                size: AppSizes.size_19,
                color: AppColor.boldBlackColor,
                fontFamily: AppFont.semi,
              ),
              SizedBox(
                height: size.height * .003,
              ),
              AppText(
                title: 'SignIn into your Account',
                size: AppSizes.size_15,
                fontWeight: FontWeight.w400,
                color: AppColor.boldBlackColor,
                fontFamily: AppFont.regular,
              ),
              SizedBox(
                height: size.height * .05,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  title: 'Phone Number',
                  size: size.height * .017,
                  color: AppColor.boldBlackColor,
                  fontFamily: AppFont.medium,
                ),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              CountryCodeWid(
                onPickCode: (code) {
                  authController.updateCodeValue(code.toString());
                },
                value: authController.codeValue.value,
                phoneController: authController.phoneCheckController,
              ),

              SizedBox(
                height: size.height * .05,
              ),
              Obx(() {
                return
                  isLoading
                      ? Center(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        color: AppColor.primaryColor,
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColor.whiteColor //<-- SEE HERE

                            ),
                            // strokeWidth: 5,
                          ),
                        ),
                      ),
                    ),
                  ):

                  authButton(
                    onTap: () {
                      if (validate()) {
                        String number = authController.codeValue.value +
                            authController.phoneCheckController.text;
                        print('value: ' + number);
                       _submitPhoneNumber(number);
                      }
                    },
                    text: authController.codeValue.value == "+92"
                        ? "Continue"
                        : "Continue");
              }),
              //   SizedBox(
              //     height: Get.height * 0.03,
              //   ),
              //   Image.asset("assets/images/or.png"),
              //   SizedBox(
              //     height: Get.height * 0.03,
              //   ),
              // socialButton(
              //     onTap: () {
              //
              //     },
              //
              //     text: "Continue with Google",
              //     image:"assets/images/google_icon.png"),
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    phoneNumber = authController.phoneCheckController.text;
    if (phoneNumber.isEmpty) {
      flutterToast(msg: "Please enter phone number");

      return false;
    }
    if (authController.phoneCheckController.text.length != 10) {
      flutterToast(msg: "Please enter valid phone number");

      return false;
    }
    return true;
  }

  void _handleError(e) {
    print(e.message);
    setState(() {
      _status += e.message + '\n';
    });
  }

  void _showError(e) {
    print(e.message);
    setState(() {
      _status += e.message + '\n';
    });
    flutterToast(msg: "Invalid Phone Number");
  }

  Future<void> _login(String number) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(this._phoneAuthCredential)
          .then((authRes) {
        _firebaseUser = authRes.user;
        print(_firebaseUser.toString());
      }).catchError((e) => _handleError(e));
      setState(() {
        _status += 'Signed In\n';
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _submitPhoneNumber(String number) async {
    setState(() {
      isLoading = true;
    });

    String phoneNumber = number.trim();
    print(phoneNumber);
    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      setState(() {
        _status += 'verificationCompleted\n';
      });
      _phoneAuthCredential = phoneAuthCredential;
      _login(number);
    }

    void verificationFailed(error) {
      setState(() {
        isLoading = false;
      });
      _showError(error);
    }

    void codeSent(String verificationId, [int? code]) {
      _verificationId = verificationId;
      _code = code!;
      setState(() {
        _status += 'Code Sent\n';
        isLoading = false;
      });
      Get.to(OtpScreen(
        verificationId: verificationId,
        phone: phoneNumber,
      ));

      flutterToastSuccess(msg: "Code sent to mobile number");
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      setState(() {
        _status += 'codeAutoRetrievalTimeout\n';
        isLoading = false;
      });
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(milliseconds: 10000),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
  }
}
