import 'dart:async';

import 'package:card_app/constant/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.offNamed('/login');
        return;
      } else {
        var uId = FirebaseAuth.instance.currentUser!.uid;

        usersReference.doc(uId).get().then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot['userName'] == '0') {
            return Get.offNamed('/userdata-screen');
          } else if (documentSnapshot['role'] == '0') {
            return Get.offNamed('/select-role-screen',arguments: [false]);
          } else if (documentSnapshot['question.answer3'] == '0') {
            return Get.offNamed('/question-screen',arguments: [false]);
          } else if (documentSnapshot['image'] == '0') {
            return Get.offNamed('/image-upload-screen',arguments: [false]);
          } else {
            return Get.offNamed('/home-screen');
          }
        });
      }

      // Get.offNamed('/home-screen');
      // Get.offNamed(returnNewRoute());
    });
  }

  String returnNewRoute() {
    var uId = FirebaseAuth.instance.currentUser!.uid;

    usersReference.doc(uId).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot['userName'] == '') {
        return '/userdata-screen';
      } else if (documentSnapshot['role'] == '') {
        return '/select-role-screen';
      } else if (documentSnapshot['question.answer3'] == '') {
        return '/question-screen';
      } else {
        return '/home-screen';
      }
    });
    return '/home-screen';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Dreeam',
                style: TextStyle(
                  color: MyColors.newTextColor,
                  fontSize: 0.3.sw,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/heart.svg',width: 0.2.sw,),
                  SvgPicture.asset('assets/icons/spades.svg',color: Colors.white,width: 0.25.sw,),
                  SvgPicture.asset('assets/icons/diamond.svg',width: 0.25.sw,),
                  SvgPicture.asset('assets/icons/club.svg',color: Colors.white,width: 0.25.sw,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
    // static String returnNewRoute() {
    //   if (FirebaseAuth.instance.currentUser != null &&
    //       FirebaseAuth.instance.currentUser!.phoneNumber != null) {
    //     return '/userdata-screen';
    //   }
    //   if (FirebaseAuth.instance.currentUser != null) {
    //     return '/userdata-screen';
    //   }
    //   return '/login-screen';
    // }



