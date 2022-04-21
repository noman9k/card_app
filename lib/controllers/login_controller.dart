// ignore_for_file: avoid_print, prefer_function_declarations_over_variables

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController {
  final loginformKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final codeController = TextEditingController();
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
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    }
  }

  void verifyNumber() async {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: codeController.text,
    );
    await auth.signInWithCredential(credential);
    print('signin');
    Get.snackbar('Signin Successfull', 'With User ID ${auth.currentUser!.uid}');
  }

  void setCountry(Country country) {
    selectedCountry.value = country;
  }

  void dispose() {
    phoneNumberController.dispose();
    codeController.dispose();
  }
}
