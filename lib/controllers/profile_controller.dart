import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var uId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');
  var descriptionEdited = true.obs;
  var roleEdited = true.obs;
  var questionEdited = true.obs;
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
  var likersList = [].obs;
  var blueLike = false.obs;

  var likes = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getProfileData();
    getnumberofEdits();
    getLikes(null);
  }

  Future<void> getnumberofEdits() async {
    await usersReference.doc(uId).get().then((value) {
      descriptionEdited.value =
          value['number_of_edits.description'] == '1' ? true : false;
      roleEdited.value = value['number_of_edits.role'] == '1' ? true : false;
      questionEdited.value =
          value['number_of_edits.question'] == '1' ? true : false;
    });
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
      likes.value = documentSnapshot['likes'].length;
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
    likes.value = doc['likes'].length;
  }

  Future<int> getLikes(uId) async {
    try {
      await usersReference.doc(uId).get().then((value) => {
            likes.value = value['likes'].length,
            if (value['likes'] != null)
              {
                likersList.value = value['likes']
                    .map<String>((value) => value.toString())
                    .toList(),
                likersList.contains(uId)
                    ? blueLike.value = true
                    : blueLike.value = false
              }
          });

      return likes.value;
    } catch (e) {
      setLikes(null);
      return 0;
    }
  }

  Future<void> setLikes(String? uId) async {
    try {
      await usersReference
          .doc(uId)
          .get()
          .then((DocumentSnapshot<Object?> documentSnapshot) async {
        if (documentSnapshot['likes'] != null) {
          likersList.value = documentSnapshot['likes']
              .map<String>((value) => value.toString())
              .toList();

          if (likersList.contains(this.uId)) {
            usersReference.doc(uId).update({
              'likes': FieldValue.arrayRemove([this.uId])
            });
          } else {
            // blueColor.value = true;

            usersReference.doc(uId).update({
              'likes': FieldValue.arrayUnion([this.uId])
            });
          }

          getLikes(uId);
        }
      });
    } catch (e) {
      getLikes(uId);

      await usersReference.doc(uId).update({
        'likes': [this.uId],
      });
    }
  }

  void setDescription() async {
    var pastDescription = '';
    var pastLikes = [];

    try {
      await usersReference.doc(uId).get().then((value) {
        pastDescription = value['p_description'];
        pastLikes =
            value['p_likes'].map<String>((value) => value.toString()).toList();
      });
    } catch (e) {
      pastDescription = description.value;
      await usersReference.doc(uId).get().then((value) {
        pastLikes =
            value['likes'].map<String>((value) => value.toString()).toList();
      });
    } finally {
      Get.toNamed('/edit-description-screen',
          arguments: [pastDescription, pastLikes]);
    }
  }

  Future<List?> likedList(String? uId) async {
    var list = [];
    await usersReference.doc(uId ?? this.uId).get().then((value) {
      list = value['likes'].map<String>((value) => value.toString()).toList();
    });

    return list;
  }
}
