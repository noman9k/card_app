import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController {
  final userDataFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController game = TextEditingController();
  TextEditingController level = TextEditingController();
  TextEditingController cash = TextEditingController();
  TextEditingController country = TextEditingController();
  String uId = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = false.obs;
  Rx<Country> selectedCountry = Country(
          countryCode: '',
          level: 1,
          phoneCode: '  ',
          name: '',
          displayName: '',
          displayNameNoCountryCode: '',
          geographic: true,
          e164Key: '',
          e164Sc: 1,
          example: '')
      .obs;
  // ProfileController profileController = Get.put(ProfileController());

  // var locationDetails = ''.obs;

  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');

  bool isValid() {
    return userDataFormKey.currentState!.validate();
  }

  void upload() async {
    isLoading.value = true;
    await _saveUserData();
    Get.offNamed('/select-role-screen', arguments: [false]);
  }

  Future<void> _saveUserData() async {
    String country = await usersReference.doc(uId).get().then((value) {
      return value['locationDetails'];
    });

    return usersReference.doc(uId).update({
      'userName': name.text,
      'country': selectedCountry.value.flagEmoji,
      'locationDetails': selectedCountry.value.name,
      'description': description.text,
      'locationDetails': '${city.text}_$country',
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

  cityValidation() {
    if (city.text.isEmpty) {
      'You need to specify a city';
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

  countryValidation() {
    if (selectedCountry.value.name.isEmpty) {
      'Country is required';
    } else {
      return null;
    }
  }
}
