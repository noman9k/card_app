// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:card_app/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modals/role_model.dart';

class RoleController extends GetxController {
  var selectedRoleIndex = 0.obs;
  var selectedRole;
  var userSelectedRole = false.obs;
  var uId = FirebaseAuth.instance.currentUser!.uid;
  ProfileController profileController = Get.put(ProfileController());

  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');

  final List<Role> rolesList = [
    Role(
      name: 'Coeur Pour\nl\'amour du jeu ',
      description: 'Parler poker et faire des parties en ligne entre passionné',
      image: 'assets/icons/heart.svg',
      color: Colors.red,
    ),
    Role(
      name: 'Pique\nPourune coloc Poker ',
      description:
          'M\'entourer de joueurs de poker pour avancer ensemble dans la même direction',
      image: 'assets/icons/club.svg',
      color: Colors.black,
    ),
    Role(
      name: 'Trèfle\nPour des soirées Poker',
      description:
          'Rencontrer des joueurs près de chez moi pour faire des soirées poker entre potes',
      image: 'assets/icons/spades.svg',
      color: Colors.black,
    ),
    Role(
      name: 'Carreau\nPour le business',
      description:
          'Discuter projets et travailler son jeu avec des joueurs ambitieux qui souhaitent vivre du Poker',
      image: 'assets/icons/diamond.svg',
      color: Colors.red,
    ),
  ];

  void selectRole(int index) {
    selectedRoleIndex.value = index;
    selectedRole = rolesList[index];
    userSelectedRole.value = true;
  }

  Future<void> saveToDB() async {
    if (userSelectedRole.value) {
      print('save to db');

      String roleImage = rolesList[selectedRoleIndex.value].image;
      String role = roleImage.split('/').last.split('.').first;
      print(role);

      await usersReference.doc(uId).update({
        'role': role,
      }).then(
        (value) {
          profileController.getProfileData();
          Get.toNamed('/question-screen');
        },
      );

      return;
    }
    Get.snackbar('Role not Selected', 'Please Select The Role First');
  }
}
