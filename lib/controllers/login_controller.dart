// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  // final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final codeController = TextEditingController();
  late String _verificationId;

  void dispose() {
    phoneNumberController.dispose();
    codeController.dispose();
  }

  void sendCode() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) =>
            print('verificationCompleted'),
        verificationFailed: (FirebaseAuthException e) =>
            print('verificationFailed'),
        codeSent: (String verificationId, i) {
          _verificationId = verificationId;

          print('codeSent');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          print('codeAutoRetrievalTimeout');
        });
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  void signin() async {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: codeController.text,
    );
    await auth.signInWithCredential(credential);
    print('signin');
  }

  void signinp() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumberController.text,
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = codeController.text;

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }

        // Handle other errors
      },
    );
  }
}
