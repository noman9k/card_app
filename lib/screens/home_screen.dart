// ignore_for_file: prefer_const_constructors

import 'package:card_app/controllers/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/role_controller.dart';
import 'chat_screen.dart';
import 'comunity_screen.dart';
import 'profile_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());
  RoleController roleController = Get.put(RoleController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        profileController.getProfileData();
        print('rebuild Happened');
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex,
            onTap: controller.changeTabIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.verified_user_sharp),
                label: 'Comunity',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.messenger),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
          body: IndexedStack(
            index: controller.tabIndex,
            children: [
              ComunityScreen(),
              ChatScreen(),
              ProfileScreen(),
            ],
          ),
        );
      },
    );
  }
}
