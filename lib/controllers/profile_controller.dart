import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // final profileFormKey = GlobalKey<FormState>();
  // final nameController = TextEditingController();
  // final ageController = TextEditingController();
  // final colorController = TextEditingController();
  // final phoneNumberController = TextEditingController();
  // final codeController = TextEditingController();
  var uId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');
  var name = ''.obs;
  var flag = ''.obs;
  var description = ''.obs;
  var answer1 = ''.obs;
  var answer2 = ''.obs;
  var answer3 = ''.obs;
  var role = ''.obs;
  var picture = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }

  void getProfileData() {
    usersReference.doc(uId).get().then((DocumentSnapshot documentSnapshot) {
      name.value = documentSnapshot['userName'];
      role.value = documentSnapshot['role'];
      flag.value = documentSnapshot['country'];
      picture.value = documentSnapshot['image'];

      answer1.value = documentSnapshot['question.answer1'];
      answer2.value = documentSnapshot['question.answer2'];
      answer3.value = documentSnapshot['question.answer3'];
    });
  }
}
