import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mart/app/authentication/component/auth_component.dart';
import 'package:mart/app/authentication/controller/auth_controller.dart';
import 'package:mart/services/api_manager.dart';
import 'package:mart/util/theme.dart';
import 'package:mart/util/toast.dart';
import 'package:mart/widgets/app_text.dart';
import 'package:mart/widgets/helper_function.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key, this.phone, required this.verificationId})
      : super(key: key);

  var phone;
  final String verificationId;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  late AuthCredential _phoneAuthCredential;


  bool _onEditing = true;
  String _status = '';
  late User _firebaseUser;

  bool isLoading = false;

  String currentText = "";
   TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  // TextEditingController textEditingController1 = TextEditingController();
  //
  // String _comingSms = 'Unknown';
  //
  // Future<void> initSmsListener() async {
  //
  //   String? comingSms = "";
  //   try {
  //     comingSms = await AltSmsAutofill().listenForSms;
  //   } on PlatformException {
  //     comingSms = 'Failed to get Sms.';
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _comingSms = comingSms!;
  //     print("====>Message: ${_comingSms}");
  //     print("${_comingSms[2]}");
  //     textEditingController1.text = _comingSms[0] + _comingSms[1] + _comingSms[2] + _comingSms[3]
  //         + _comingSms[4] + _comingSms[5]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
  //   });
  // }




  bool hasError = false;
  final formKey = GlobalKey<FormState>();
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
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    // textEditingController1 = TextEditingController();
    // initSmsListener();
    getToken();
    HelperFunctions.getFromPreference("tokem").then((value) {
      setState(() {
        token = value;
      });
    });
  }

  @override
  void dispose() {
    // textEditingController1.dispose();
    // AltSmsAutofill().unregisterListener();
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: AppPaddings.mainHorizontal,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: backBtn(
                  context: context,
                  onTap: () {
                    Get.back();
                  }),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      height: size.height * .2,
                      width: size.width * .7,
                    ),
                    AppText(
                      title: "Verify your\nPhone Number",
                      size: size.height * 0.024,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor,
                      fontFamily: AppFont.semi,
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          title: "Enter the Otp send to ",
                          size: size.height * 0.015,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600,
                          color: AppColor.greyColor,
                          fontFamily: AppFont.medium,
                        ),
                        AppText(
                          title: widget.phone ,
                          size: size.height * 0.017,
                          textAlign: TextAlign.center,
                          color: AppColor.blackColor,
                          fontFamily: AppFont.medium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .06,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 6,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 5) {
                            return "Please enter valid otp";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          activeColor: AppColor.primaryColor,
                          inactiveColor: AppColor.greyColor,
                          inactiveFillColor: AppColor.whiteColor,
                          activeFillColor: AppColor.whiteColor,
                          selectedFillColor: AppColor.whiteColor,
                          selectedColor: AppColor.primaryColor,
                          disabledColor: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        cursorColor: AppColor.primaryColor,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          return true;
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),

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
                    authButton(onTap: (){
                      if (currentText != null &&
                          currentText.length == 6) {
                        _submitOTP();
                      }
                      else{
                        flutterToast(msg: "Please enter valid code");
                      }
                    },text: "Verify"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitOTP() {
    String smsCode = currentText;
    this._phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: smsCode);

    _login();
  }

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    /// This method is used to login the user
    /// `AuthCredential`(`_phoneAuthCredential`) is needed for the signIn method
    /// After the signIn method from `AuthResult` we can get `FirebaserUser`(`_firebaseUser`)
    try {} catch (e) {
      _handleError(e);
    }
    await FirebaseAuth.instance
        .signInWithCredential(this._phoneAuthCredential)
        .then((authRes) {
      _firebaseUser = authRes.user!;

      ApiManger().loginResponse(context: context,
        token: token.toString(),
        phone: Get.put(AuthController()).codeValue.value+Get.put(AuthController()).phoneCheckController.text,

      );
      print(_firebaseUser.toString());

    }).catchError((e){
      isLoading = false;
      flutterToast(msg:"invalid-verification-code");
      print("Hamza Alllsss ${e.toString()}");
    });
    setState(() {
      _status += 'Signed In\n';
    });

  }

  void _handleError(e) {
    setState(() {
      isLoading = true;
    });
    print(e.toString());
    setState(() {
      _status += e.toString() + '\n';
    });
  }
}
