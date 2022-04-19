// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: Get.height,
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: loginController.phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                  ),
                ),
                TextFormField(
                  controller: loginController.codeController,
                  decoration: InputDecoration(
                    labelText: 'Code',
                  ),
                ),
                ElevatedButton(
                    onPressed: () => loginController.sendCode(),
                    child: Text('send Code')),
                ElevatedButton(
                    onPressed: () => loginController.signin(),
                    child: Text('Signin')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
