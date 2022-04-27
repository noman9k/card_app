import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController {
  final userDataFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController game = TextEditingController();
  TextEditingController level = TextEditingController();
  TextEditingController cash = TextEditingController();
  String uId = FirebaseAuth.instance.currentUser!.uid;
  // ProfileController profileController = Get.put(ProfileController());

  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');

  bool isValid() {
    return userDataFormKey.currentState!.validate();
  }

  void upload() async {
    await _saveUserData();
    Get.offNamed('/select-role-screen');
  }

  Future<void> _saveUserData() {
    return usersReference.doc(uId).update({
      'userName': name.text,
      'description': description.text,
      'details.game': game.text,
      'details.level': level.text,
      'details.cash': cash.text
    });
  }

  nameValidation() {
    if (name.text.isEmpty) {
      'Name is required';
    } else {
      return null;
    }
  }

  descriptionValidation() {
    if (description.text.isEmpty) {
      'Description is required';
    } else {
      return null;
    }
  }

  gameValidation() {
    if (game.text.isEmpty) {
      'You need to specify a game you plays';
    } else {
      return null;
    }
  }

  levelValidation() {
    if (level.text.isEmpty) {
      'Level is required';
    } else {
      return null;
    }
  }

  cashValidation() {
    if (cash.text.isEmpty) {
      'Cash is required';
    } else {
      return null;
    }
  }
}