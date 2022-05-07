import 'dart:async';

import 'package:card_app/constant/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
            return Get.offNamed('/select-role-screen');
          } else if (documentSnapshot['question.answer3'] == '0') {
            return Get.offNamed('/question-screen');
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
      body: Center(
        child: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset('assets/images/logo.png')),
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



