// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'chat_screen.dart';
import 'comunity_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex,
            onTap: controller.changeTabIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.verified_user_sharp),
                label: 'Home',
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
