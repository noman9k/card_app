// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:card_app/constant/colors.dart';
import 'package:card_app/controllers/role_controller.dart';
import 'package:card_app/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Obx(
          () => SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    SizedBox(
                      height: Get.height * 0.15,
                      child: Center(
                        child: Text(
                          'Dreeam',
                          style: TextStyle(
                            color: MyColors.newTextColor,
                            fontSize: Get.height * 0.10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Numéro de téléphone',
                          style: TextStyle(
                              color: MyColors.newTextColor, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Form(
                          key: loginController.loginformKey,
                          child: TextFormField(
                            controller: loginController.phoneNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre numéro de téléphone';
                              } else if (!loginController
                                  .isCountrySelected.value) {
                                return 'Veuillez d\'abord sélectionner votre pays';
                              }
                              loginController.isLoading.value = true;
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              color: MyColors.newTextColor,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyColors.newTextColor,
                                ),
                              ),
                              labelText: 'Numéro de téléphone',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle:
                                  TextStyle(color: MyColors.newTextColor),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.newTextColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 228, 23, 125),
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: InkWell(
                                onTap: () {
                                  showCountryPicker(
                                      context: context,
                                      showPhoneCode: true,
                                      countryListTheme: CountryListThemeData(
                                        inputDecoration: InputDecoration(
                                          focusColor: MyColors.newTextColor,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: MyColors.newTextColor),
                                          ),
                                          hintText: 'Recherche en français',
                                          labelStyle: TextStyle(
                                              color: MyColors.newTextColor),
                                          labelText: 'Recherche en français',
                                          hintStyle: TextStyle(
                                            color: MyColors.newTextColor,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(255, 163, 157, 157),
                                      ),
                                      onSelect: (Country selectedCountry) {
                                        loginController.selectedCountry.value =
                                            selectedCountry;
                                      },
                                      onClosed: () => loginController
                                          .isCountrySelected.value = true);
                                },
                                child: SizedBox(
                                  width: 30,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        !loginController.isCountrySelected.value
                                            ? '+ CC'
                                            : '+ ${loginController.selectedCountry.value.phoneCode}',
                                        style: TextStyle(
                                          color: MyColors.newTextColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        loginController.codeSended.value
                            ? Text(
                                'Code que vous avez reçu',
                                style: TextStyle(
                                    color: MyColors.newTextColor, fontSize: 16),
                              )
                            : SizedBox(),
                        SizedBox(height: 5),
                        loginController.codeSended.value
                            ? TextFormField(
                                controller: loginController.codeController,
                                style: TextStyle(
                                  color: MyColors.newTextColor,
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Code',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelStyle:
                                      TextStyle(color: MyColors.newTextColor),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MyColors.newTextColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 228, 23, 125),
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    MyElevatedButton(
                      child: loginController.codeSended.value
                          ? Text(
                              'Vérifier le numéro de téléphone',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white),
                            )
                          : loginController.isLoading.value
                              ? CircularProgressIndicator(
                                  color: MyColors.newTextColor,
                                )
                              : Text(
                                  'Envoyer le code',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                      onButtonPressed: () {
                        loginController.isLoading.value = true;

                        loginController.codeSended.value
                            ? loginController.verifyNumber()
                            : loginController.sendCode();
                      },
                    ),
                    TextButton(
                      onPressed: () => loginController.sendCode(),
                      child: Text(
                        'Renvoyer le code ?',
                        style: TextStyle(color: MyColors.newTextColor),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
