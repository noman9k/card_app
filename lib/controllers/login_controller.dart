// ignore_for_file: avoid_print, prefer_function_declarations_over_variables

import 'package:card_app/constant/colors.dart';
import 'package:card_app/modals/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final loginformKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final codeController = TextEditingController();
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');
  var codeSended = false.obs;
  var isLoading = false.obs;
  RxString phoneNumber = RxString('');
  late String _verificationId;
  var isCountrySelected = false.obs;
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

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendCode() async {
    if (loginformKey.currentState!.validate()) {
      loginformKey.currentState!.save();

      final PhoneVerificationCompleted verificationCompleted =
          (AuthCredential phoneAuthCredential) {
        print('verificationCompleted');
        print(phoneAuthCredential);
      };

      final PhoneVerificationFailed verificationFailed =
          (FirebaseAuthException authException) {
        print('verificationFailed');
        print(authException.message);
      };

      final PhoneCodeSent codeSent =
          (String verificationId, [forceResendingToken]) {
        print('codeSent');
        print(verificationId);
        codeSended.value = true;
        _verificationId = verificationId;
      };

      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verificationId) {
        print('codeAutoRetrievalTimeout');
        print(verificationId);
        _verificationId = verificationId;
      };

      await auth.verifyPhoneNumber(
          phoneNumber:
              '+${selectedCountry.value.phoneCode} ${phoneNumberController.text}',
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    }
  }

  void verifyNumber() async {
    isLoading.value = true;
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: codeController.text,
    );
    await auth
        .signInWithCredential(credential)
        .then((value) => saveUserToDb())
        .onError((error, stackTrace) => Get.snackbar('Oups !', 'Erreur OTP',
            backgroundColor: MyColors.newTextColor,
            snackPosition: SnackPosition.BOTTOM));

    print('signin');
    if (auth.currentUser == null) {
      Get.snackbar(
        'Signin Failed',
        'Please check your code',
        backgroundColor: Colors.red,
      );
      return;
    }
  }

  void setCountry(Country country) {
    selectedCountry.value = country;
  }

  void saveUserToDb() async {
    try {
      String uId = FirebaseAuth.instance.currentUser!.uid;
      await usersReference
          .doc(uId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          isLoading.value = false;

          Get.offNamed('/home-screen');
          return;
        }
        throw Exception('User not found');
      });
    } catch (e) {
      String uId = FirebaseAuth.instance.currentUser!.uid;

      await usersReference.doc(uId).set({
        'userName': '0',
        'description': '',
        'uId': uId,
        'phone': phoneNumber.value,
        'image': '0',
        'country': selectedCountry.value.flagEmoji,
        'locationDetails': selectedCountry.value.name,
        'role': '0',
        'details': {
          'game': '',
          'level': '',
          'cash': '',
        },
        'number_of_edits': {
          'description': '0',
          'question': '0',
          'role': '0',
        },
        'question': {
          'answer1': '',
          'answer2': '',
          'answer3': '0',
        },
      }).then(
        (value) {
          isLoading.value = false;

          Get.offNamed('/userdata-screen');
        },
      );
    }
  }

  @override
  // ignore: must_call_super
  void dispose() {
    phoneNumberController.dispose();
    codeController.dispose();
  }
}
