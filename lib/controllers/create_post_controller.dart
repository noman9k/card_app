import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreatePostController extends GetxController {

  String firstItem = 'Recherche joueur pour';
  String secondItem = 'Travailler son jeu';
  String thirdItem = 'Faire une coloc poker';
  String fourthItem = 'Faire un event poker';
  String fifthItem = 'Trouver une partie privée';
  String sixthItem = 'Autres';

  var initialValue = ''.obs;

  List<String> choices = <String>[
    'Recherche joueur pour',
    'Travailler son jeu',
    'Faire une coloc poker',
    'Faire un event poker',
    'Trouver une partie privée',
    'Autres',
  ];

  void choiceAction(String choice) {
    initialValue.value = choice;
  }
}