// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:card_app/constant/colors.dart';
import 'package:card_app/controllers/role_controller.dart';
import 'package:card_app/widgets/my_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: SingleChildScrollView(
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
                        'Numéro de email',
                        style: TextStyle(
                            color: MyColors.newTextColor, fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Form(
                        key: loginController.loginformKey,
                        child: TextFormField(
                          controller: loginController.emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre numéro de email';
                            }
                            if (!RegExp(
                                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: MyColors.newTextColor,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.newTextColor,
                              ),
                            ),

                            labelText: 'Numéro de email',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(color: MyColors.newTextColor),
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
                            // prefixIcon: InkWell(
                            //   onTap: () {
                            //     showCountryPicker(
                            //         context: context,
                            //         showPhoneCode: true,
                            //         countryListTheme: CountryListThemeData(
                            //           inputDecoration: InputDecoration(
                            //             focusColor: MyColors.newTextColor,
                            //             focusedBorder: OutlineInputBorder(
                            //               borderSide: BorderSide(
                            //                   color: MyColors.newTextColor),
                            //             ),
                            //             hintText: 'Recherche en français',
                            //             labelStyle: TextStyle(
                            //                 color: MyColors.newTextColor),
                            //             labelText: 'Recherche en français',
                            //             hintStyle: TextStyle(
                            //               color: MyColors.newTextColor,
                            //             ),
                            //             border: OutlineInputBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //             ),
                            //           ),
                            //           backgroundColor:
                            //               Color.fromARGB(255, 163, 157, 157),
                            //         ),
                            //         onSelect: (Country selectedCountry) {
                            //           loginController.selectedCountry.value =
                            //               selectedCountry;
                            //         },
                            //         onClosed: () => loginController
                            //             .isCountrySelected.value = true);
                            //   },
                            //   child: SizedBox(
                            //     width: 30,
                            //     child: Center(
                            //       child: Padding(
                            //         padding: const EdgeInsets.only(bottom: 3),
                            //         child: Text(
                            //           !loginController.isCountrySelected.value
                            //               ? '+ CC'
                            //               : '+ ${loginController.selectedCountry.value.phoneCode}',
                            //           style: TextStyle(
                            //             color: MyColors.newTextColor,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Code que vous avez reçu',
                        style: TextStyle(
                            color: MyColors.newTextColor, fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: loginController.passwordController,
                        style: TextStyle(
                          color: MyColors.newTextColor,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(color: MyColors.newTextColor),
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
                        ),
                      ),
                      SizedBox(height: 5),
                      privacyPolicyLinkAndTermsOfService()
                    ],
                  ),
                  Obx(
                    () => MyElevatedButton(
                      child: loginController.isLoading.isTrue
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Vérifier le numéro de email',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                      onButtonPressed: !agree
                          ? () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                      'Vous devez accepter les conditions d\'utilisation'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              );
                            }
                          : () {
                              loginController.isLoading.value = true;

                              loginController.emailSignUp();
                            },
                    ),
                  ),
                  TextButton(
                    onPressed: () => loginController.resendEmail(),
                    child: Text(
                      'Renvoyer le verification link ?',
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
    );
  }

  Widget privacyPolicyLinkAndTermsOfService() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.black,
          side: BorderSide(color: Colors.white),
          value: agree,
          onChanged: (value) {
            setState(() {
              agree = value ?? false;
            });
          },
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Center(
                child: Text.rich(TextSpan(
                    text: 'By continuing, you agree to our ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    children: <TextSpan>[
                  TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await launchUrl(Uri.parse(
                              "https://github.com/shehzadraheem/Dreeam_Terms-Conditions"));
                        }),
                  TextSpan(
                      text: ' and ',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                await launchUrl(Uri.parse(
                                    "https://github.com/shehzadraheem/Privacy-Policy"));
                              })
                      ])
                ]))),
          ),
        ),
      ],
    );
  }
}
