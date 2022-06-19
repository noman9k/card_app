// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:card_app/controllers/userdata_controller.dart';
import 'package:card_app/widgets/my_widgets.dart';
import 'package:country_picker/country_picker.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    const Text(
                      'AVANT DE COMMENCER',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: MyColors.newTextColor,
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    const Text(
                      'Répondez aux questions en étant vous-même, C\'est comme ça que vous ferez vos plus belles rencontres.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: MyColors.newTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.03),
                Form(
                  key: userDataController.userDataFormKey,
                  child: Column(
                    children: [
                      myTextFormFiled(
                        text: 'Nom',
                        controller: userDataController.name,
                        validator: userDataController.nameValidation(),
                      ),
                      SizedBox(height: height * 0.04),
                      myTextFormFiled(
                        ontap: () {
                          showCountryPicker(
                            // ignore: prefer_const_constructors
                            countryListTheme: CountryListThemeData(
                                bottomSheetHeight: Get.height * 0.7,
                                backgroundColor: Colors.grey),
                            context: context,
                            showPhoneCode:
                                true, // optional. Shows phone code before the country name.
                            onSelect: (Country country) {
                              userDataController.country.text = country.name;
                              userDataController.selectedCountry.value =
                                  country;
                            },
                          );
                        },
                        text: 'Pays',
                        controller: userDataController.country,
                        validator: userDataController.countryValidation(),
                      ),
                      SizedBox(height: height * 0.04),
                      myTextFormFiled(
                        text: 'Que recherchez-vous sur cette plateforme ?',
                        controller: userDataController.description,
                        validator: userDataController.descriptionValidation(),
                        maxlines: 3,
                      ),
                      SizedBox(height: height * 0.04),
                      myTextFormFiled(
                        text: ' Dans quelle ville habitez-vous ? ',
                        controller: userDataController.city,
                        validator: userDataController.cityValidation(),
                      ),
                      SizedBox(height: height * 0.04),
                      myTextFormFiled(
                        text: 'Votre niveau de jeu en un mot ',
                        controller: userDataController.game,
                        validator: userDataController.gameValidation(),
                      ),
                      SizedBox(height: height * 0.04),
                      myTextFormFiled(
                        text: 'Cash Game ou Tournois ',
                        controller: userDataController.level,
                        validator: userDataController.levelValidation(),
                        inputType: TextInputType.text,
                      ),
                      SizedBox(height: height * 0.05),
                      myTextFormFiled(
                          text: ' Live ou Online',
                          controller: userDataController.cash,
                          validator: userDataController.cashValidation(),
                          inputType: TextInputType.text),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.05),
                Obx(
                  () => MyElevatedButton(
                    child: userDataController.isLoading.isTrue
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Suivant',
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
  Function()? ontap,
}) {
  return TextFormField(
    onTap: ontap,
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
