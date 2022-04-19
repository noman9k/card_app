// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComunityController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  List<Map<String, String>> mytabs = [
    {'title': 'Club', 'icon': 'assets/icons/club.png'},
    {'title': 'Heart', 'icon': 'assets/icons/heart.png'},
    {'title': 'Diamond', 'icon': 'assets/icons/diamond.png'},
    {'title': 'Spades', 'icon': 'assets/icons/spades.png'},
  ];

  List myTabColor = [
    const Color.fromARGB(255, 233, 30, 99),
    const Color.fromARGB(255, 228, 35, 21),
    const Color.fromARGB(255, 51, 204, 56),
    const Color.fromARGB(255, 255, 255, 255),
  ];
  var tabColor = const Color.fromARGB(255, 233, 26, 95).obs;

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
