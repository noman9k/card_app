// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:card_app/controllers/userdata_controller.dart';
import 'package:card_app/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/colors.dart';

// ignore: must_be_immutable
class UserDataScreen extends StatelessWidget {
  UserDataScreen({Key? key}) : super(key: key);

  UserDataController userDataController = Get.put(UserDataController());

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Fill the Information',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: MyColors.newTextColor,
                  ),
                ),
                SizedBox(height: height * 0.05),
                Form(
                  key: userDataController.userDataFormKey,
                  child: Column(
                    children: [
                      myTextFormFiled(
                        text: 'Name',
                        controller: userDataController.name,
                        validator: userDataController.nameValidation(),
                      ),
                      SizedBox(height: height * 0.04),
                      myTextFormFiled(
                        text: 'Dedscription',
                        controller: userDataController.description,
                        validator: userDataController.descriptionValidation(),
                        maxlines: 3,
                      ),
                      SizedBox(height: height * 0.04),
                      myTextFormFiled(
                        text: 'Game You Paly',
                        controller: userDataController.game,
                        validator: userDataController.gameValidation(),
                      ),
                      SizedBox(height: height * 0.04),
                      myTextFormFiled(
                        text: 'Level you are on',
                        controller: userDataController.level,
                        validator: userDataController.levelValidation(),
                        inputType: TextInputType.number,
                      ),
                      SizedBox(height: height * 0.05),
                      myTextFormFiled(
                          text: 'Cash you have',
                          controller: userDataController.cash,
                          validator: userDataController.cashValidation(),
                          inputType: TextInputType.number),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.05),
                MyElevatedButton(
                  child: const Text('Submit',
                      style: TextStyle(
                        fontSize: 20,
                        color: MyColors.newTextColor,
                      )),
                  onButtonPressed: () {
                    if (userDataController.isValid()) {
                      userDataController.upload();
                    }
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget myTextFormFiled({
  required String text,
  TextEditingController? controller,
  String? Function(String?)? validator,
  int? maxlines,
  TextInputType? inputType,
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    maxLines: maxlines,
    keyboardType: inputType,
    style: const TextStyle(
      fontSize: 18,
      color: MyColors.newTextColor,
    ),
    decoration: InputDecoration(
      labelText: text,
      labelStyle: TextStyle(
        color: MyColors.newTextColor.withOpacity(0.7),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: MyColors.newTextColor,
        ),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.newTextColor),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.newTextColor),
      ),
    ),
  );
}
