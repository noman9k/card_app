import 'package:card_app/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditDescriptionController extends GetxController {
  ProfileController profileController = Get.find();
  var uId = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference usersReference = FirebaseFirestore.instance.collection('users');
  TextEditingController descriptionController = TextEditingController();
  var previousDescription = false.obs;

  void togglePreviousDescription() {
    if (previousDescription.value) {
      descriptionController.text = '';
    }
    previousDescription.value = !previousDescription.value;
  }

  Future<void> updateDescription(
      String text, String pDescription, int likes) async {
    FocusScope.of(Get.context!).unfocus();

    FirebaseFirestore.instance.collection("users").doc(uId).collection("newLikes");
    await usersReference.doc(uId).update({
      'status':'newLikes',
      'p_description': pDescription,
      'p_likes': likes,
      'description': text,
      'likes': pDescription == text ? likes : [null],
      'number_of_edits.description': pDescription == text ? '1' : '0',
    }).then((value) {
      profileController.getnumberofEdits();
      profileController.getProfileData();

      Get.back();
    });
  }
}
