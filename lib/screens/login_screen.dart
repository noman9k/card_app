// ignore_for_file: prefer_const_constructors, must_be_immutable

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
        backgroundColor: Color.fromARGB(255, 18, 21, 27),
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
                        height: Get.height * 0.15,
                        child: Center(
                            child: Image.asset('assets/images/logo.png'))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number',
                          style: TextStyle(color: Colors.brown, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Form(
                          key: loginController.loginformKey,
                          child: TextFormField(
                            controller: loginController.phoneNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              } else if (!loginController
                                  .isCountrySelected.value) {
                                return 'Please select your country first';
                              }
                              loginController.isLoading.value = true;
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              color: Colors.brown,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.brown),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown),
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
                                          focusColor: Colors.black,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          hintText: 'Search in french',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          labelText: 'Search in french',
                                          hintStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(255, 104, 87, 82),
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
                                          color: Colors.brown,
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
                                'Code you received',
                                style: TextStyle(
                                    color: Colors.brown, fontSize: 16),
                              )
                            : SizedBox(),
                        SizedBox(height: 5),
                        loginController.codeSended.value
                            ? TextFormField(
                                controller: loginController.codeController,
                                style: TextStyle(
                                  color: Colors.brown,
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Code',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelStyle: TextStyle(color: Colors.brown),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.brown),
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
                              'Verify Phone Number',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 59, 42, 35)),
                            )
                          : loginController.isLoading.value
                              ? CircularProgressIndicator(
                                  color: Colors.brown,
                                )
                              : Text(
                                  'Send Code',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 59, 42, 35)),
                                ),
                      onButtonPressed: () {
                        loginController.codeSended.value
                            ? loginController.verifyNumber()
                            : loginController.sendCode();
                      },
                    ),
                    TextButton(
                      onPressed: () => loginController.sendCode(),
                      child: Text(
                        'Resend Code ?',
                        style: TextStyle(color: Colors.brown),
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
