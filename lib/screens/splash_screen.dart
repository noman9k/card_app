import 'dart:async';

import 'package:card_app/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.offNamed('/login');
        return;
      }
      Get.offNamed('/home-screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Center(
        child: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset('assets/images/logo.png')),
      ),
    );
  }
}
