// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'profile_controller.dart';

class QuestionController extends GetxController {
  final questionFormKey = GlobalKey<FormState>();
  var q0Controller = TextEditingController();
  var q1Controller = TextEditingController();
  var q2Controller = TextEditingController();
  String uId = FirebaseAuth.instance.currentUser!.uid;
  ProfileController profileController = Get.put(ProfileController());

  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');

  final questionList = [
    'What are your Ambisionsin Poker?',
    'What Kind Of Player you want ?',
    'What Kind Of Player you want ?'
  ];
  var nextScreenRoute = '/image-upload-screen';

  void updateReturnRoute(String route) {
    nextScreenRoute = route;
  }

  submitAnswers() async {
    if (!questionFormKey.currentState!.validate()) {
      print('Form is invalid');
      return;
    }

    await _saveAnswersData(
        q0Controller.text, q1Controller.text, q2Controller.text);
    Get.offNamed(nextScreenRoute);
  }

  Future<void> _saveAnswersData(
      String answer0, String answer1, String answer2) {
    return usersReference.doc(uId).update({
      'question.answer1': answer0,
      'question.answer2': answer1,
      'question.answer3': answer2
    }).then((value) => profileController.getProfileData());
  }

  void setControllerValues(String answer1, String answer2, String answer3) {
    q0Controller = TextEditingController(text: answer1);
    q1Controller = TextEditingController(text: answer2);
    q2Controller = TextEditingController(text: answer3);
  }

  @override
  void dispose() {
    super.dispose();
    q0Controller.dispose();
    q1Controller.dispose();
    q2Controller.dispose();
  }

  String? q0validate(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return 'Please enter some text';
    }
    return null;
  }

  String? q1validate(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return 'Please enter some text';
    }
    return null;
  }

  String? q2validate(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return 'Please enter some text';
    }
    return null;
  }
}
