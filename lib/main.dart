// ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:card_app/constant/colors.dart';
import 'package:card_app/screens/create_post.dart';
import 'package:card_app/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'screens/comunity_screen.dart';
import 'screens/edit_description_screen.dart';
import 'screens/get_userdata_screen.dart';
import 'screens/home_screen.dart';
import 'screens/image_upload_screen.dart';
import 'screens/login_screen.dart';
import '/screens/select_role_screen.dart';
import 'screens/message_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/question_screen.dart';

List<CameraDescription> cameras = [];
bool isNewChatAvl = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Card App',
          theme: ThemeData(
            primarySwatch: MyColors.backgrnd,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen(),
          // home: SelectRoleScreen(),
          getPages: [
            GetPage(name: '/', page: () => LoginScreen()),
            GetPage(name: '/userdata-screen', page: () => UserDataScreen()),
            GetPage(name: '/select-role-screen', page: () => SelectRoleScreen()),
            GetPage(name: '/profile-screen', page: () => ProfileScreen()),
            GetPage(name: '/question-screen', page: () => QuestionScreen()),
            GetPage(name: '/image-upload-screen', page: () => ImageUploadScreen()),
            GetPage(name: '/home-screen', page: () => HomeScreen()),
            GetPage(name: '/comunity-screen', page: () => ComunityScreen()),
            GetPage(name: '/message-screen', page: () => MessageScreen()),
            GetPage(
                name: '/edit-description-screen',
                page: () => EditDescriptionScreen()),
            GetPage(name: '/create-post', page: () => CreatePost()),
          ],
        );
      }
    );
  }
}
