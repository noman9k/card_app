// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComunityController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  static String heartTitle = 'Pour l\'amour\ndu jeu ';
  static String spadesTitle = 'Pour une\ncoloc poker';
  static String diamondTitle = 'Pour le\nbusiness';
  static String clubTitle = 'Pour faire\ndes soirées poker';

  List<Map<String, String>> mytabs = [
    {'title': heartTitle, 'icon': 'assets/icons/heart.svg'},
    {'title': spadesTitle, 'icon': 'assets/icons/spades.svg'},
    {'title': diamondTitle, 'icon': 'assets/icons/diamond.svg'},
    {'title': clubTitle, 'icon': 'assets/icons/club.svg'},
  ];

  List<Map<String, Color>> myIconColor = [
    {heartTitle: Colors.red},
    {clubTitle: Colors.black},
    {diamondTitle: Colors.red},
    {spadesTitle: Colors.black},
  ];

  List myTabColor = const [
    Color.fromARGB(255, 21, 135, 228),
    Color.fromARGB(255, 24, 38, 236),
    Color.fromARGB(255, 21, 135, 228),
    Color.fromARGB(255, 24, 38, 236),
  ];
  var tabColor = const Color.fromARGB(255, 21, 135, 228).obs;

  @override
  void onInit() {
    tabController = TabController(
        animationDuration: const Duration(milliseconds: 0),
        initialIndex: 0,
        length: mytabs.length,
        vsync: this);

    tabController.addListener(() {
      tabColor.value = myTabColor[tabController.index];
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
