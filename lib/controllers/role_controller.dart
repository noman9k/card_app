// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modals/role_model.dart';

class RoleController extends GetxController {
  var selectedRole = 0.obs;

  final List<Role> rolesList = [
    Role(
      name: 'Heart',
      description:
          'Heart DescriptionHeart DescriptionHeart DescriptionHeart DescriptionHeart DescriptionHeart DescriptionHeart Description',
      image: 'assets/icons/heart.svg',
      color: Colors.red,
    ),
    Role(
      name: 'Club',
      description: 'Club Description',
      image: 'assets/icons/club.svg',
      color: Colors.black,
    ),
    Role(
      name: 'Spades',
      description: 'Spades Description',
      image: 'assets/icons/spades.svg',
      color: Colors.black,
    ),
    Role(
      name: 'Diamond',
      description: 'Diamond Description',
      image: 'assets/icons/diamond.svg',
      color: Colors.red,
    ),
  ];

  void selectRole(int index) {
    selectedRole.value = index;
  }

  void saveToDB() {
    print('save to db');
    print(rolesList[selectedRole.value].name);
  }
}
