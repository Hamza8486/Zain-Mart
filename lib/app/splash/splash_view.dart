import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mart/app/home/view/home_view.dart';
import 'package:mart/widgets/helper_function.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {




  String id = "";


  @override
  void initState() {

    super.initState();
    HelperFunctions.getFromPreference("id").then((value) {
      setState(() {
        id = value;
      });
      log(id);
  moveToNext();
    });
  }

  void moveToNext() {
    Timer(const Duration(seconds: 3), () {
      if (id != "") {
        Get.offAll(()=>BottomNavBar(),
            transition: Transition.cupertinoDialog
        );

      } else {
        Get.offAll(()=>BottomNavBar(),
            transition: Transition.cupertinoDialog
        );

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height*0.43,),
              Center(
                child: Image.asset("assets/images/logos.png",
               height: Get.height*0.2,
                ),
              )

            ],
          ),
        ));
  }
}
