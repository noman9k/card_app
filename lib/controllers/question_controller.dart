// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'profile_controller.dart';

class QuestionController extends GetxController {
  final questionFormKey = GlobalKey<FormState>();
  var q1Controller = TextEditingController();
  var q2Controller = TextEditingController();
  var q3Controller = TextEditingController();
  String uId = FirebaseAuth.instance.currentUser!.uid;
  ProfileController profileController = Get.put(ProfileController());

  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');

  final questionList = [
    'What is your name?',
    'What is your age?',
    'What is your favorite color?'
  ];

  submitAnswers() async {
    if (!questionFormKey.currentState!.validate()) {
      print('Form is invalid');
      return;
    } else {
      print('Form is valid');
    }

    await _saveAnswersData(
        q1Controller.text, q2Controller.text, q3Controller.text);
    Get.toNamed('/image-upload-screen');
  }

  Future<void> _saveAnswersData(
      String answer1, String answer2, String answer3) {
    return usersReference.doc(uId).update({
      'question.answer1': answer1,
      'question.answer2': answer2,
      'question.answer3': answer3
    }).then((value) => profileController.getProfileData());

    // print('Answer 1: $answer1');
    // print('Answer 2: $answer2');
    // print('Answer 3: $answer3');
  }

  @override
  void dispose() {
    super.dispose();
    q1Controller.dispose();
    q2Controller.dispose();
    q3Controller.dispose();
  }
}
