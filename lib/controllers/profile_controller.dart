import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var uId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');
  var name = ''.obs;
  var flag = ''.obs;
  var description = ''.obs;
  var answer1 = ''.obs;
  var answer2 = ''.obs;
  var answer3 = ''.obs;
  var role = ''.obs;
  var picture = ''.obs;
  var game = ''.obs;
  var level = ''.obs;
  var cash = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }

  Future<void> getProfileData() async {
    await usersReference
        .doc(uId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      name.value = documentSnapshot['userName'];
      role.value = documentSnapshot['role'];
      flag.value = documentSnapshot['country'];
      picture.value = documentSnapshot['image'];
      description.value = documentSnapshot['description'];
      game.value = documentSnapshot['details.game'];
      level.value = documentSnapshot['details.level'];
      cash.value = documentSnapshot['details.cash'];
      answer1.value = documentSnapshot['question.answer1'];
      answer2.value = documentSnapshot['question.answer2'];
      answer3.value = documentSnapshot['question.answer3'];
    });
  }

  void setProfileData(QueryDocumentSnapshot<Object?> doc) {
    name.value = doc['userName'];
    role.value = doc['role'];
    flag.value = doc['country'];
    picture.value = doc['image'];
    description.value = doc['description'];
    game.value = doc['details.game'];
    level.value = doc['details.level'];
    cash.value = doc['details.cash'];
    answer1.value = doc['question.answer1'];
    answer2.value = doc['question.answer2'];
    answer3.value = doc['question.answer3'];
  }
}
