// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/comunity_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import '/screens/select_role_screen.dart';
import 'screens/question_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Card App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: LoginScreen(),
      home: SelectRoleScreen(),
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/select-role-screen', page: () => SelectRoleScreen()),
        GetPage(name: '/question-screen', page: () => QuestionScreen()),
        GetPage(name: '/home-screen', page: () => HomeScreen()),
        GetPage(name: '/comunity-screen', page: () => ComunityScreen()),
      ],
    );
  }
}
