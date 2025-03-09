import 'dart:async';

import 'package:e_commece/utils/colors.dart';
import 'package:e_commece/utils/config.dart';
import 'package:e_commece/view/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}


class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3),(){
      Get.offAll(()=>const Welcome());
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        child:const Center(
          child: Text(AppConfig.appname,style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    ));
  }
}
