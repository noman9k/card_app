// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:card_app/controllers/profile_controller.dart';
import 'package:card_app/controllers/question_controller.dart';
import 'package:card_app/controllers/role_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  RoleController roleController = Get.put(RoleController());

  ProfileController profileController = Get.put(ProfileController());
  QuestionController questionController = Get.put(QuestionController());
  var personData = Get.arguments;
  var userItself = true;

  @override
  Widget build(BuildContext context) {
    userItself = personData == null ? true : false;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: userItself
              ? Container()
              : IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.back();
                  },
                ),
          actions: [
            !userItself
                ? Container()
                : IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Get.offAllNamed('/');
                    }),
          ],
          centerTitle: true,
          title: const Text('Profile'),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue,
                      Color.fromARGB(255, 16, 201, 130),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Text(
                          profileController.flag.value,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 5,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                profileController.setLikes(personData['uId']);
                              },
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: SvgPicture.asset(
                                  'assets/images/like.svg',
                                  color: profileController.likes.value > 0
                                      ? Color.fromARGB(255, 2, 63, 124)
                                      : Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              profileController.likes.value.toString(),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 10,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            if (userItself) {
                              roleController.updateReturnRoute('/home-screen');
                              Get.toNamed('/select-role-screen');
                            }
                          },
                          child: SvgPicture.asset(
                              'assets/icons/${profileController.role.value}.svg'),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                              child: profileController.picture.value == ''
                                  ? Image.asset(
                                      'assets/images/logo.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      profileController.picture.value,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            profileController.name.value,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                color: Colors.grey[500],
                              ),
                              width: Get.width - 20,
                              height: 50,
                              padding: const EdgeInsets.all(7),
                              child: Text(
                                profileController.description.value,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: Get.width,
                margin: EdgeInsets.only(top: 25, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'About ${profileController.name.value}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 10),
                        !userItself
                            ? Container()
                            : IconButton(
                                onPressed: () {
                                  questionController.setControllerValues(
                                    profileController.answer1.value,
                                    profileController.answer2.value,
                                    profileController.answer3.value,
                                  );

                                  questionController
                                      .updateReturnRoute('/home-screen');
                                  Get.toNamed('/question-screen');
                                },
                                icon: Icon(Icons.edit),
                              ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey[700],
                      height: 5,
                      thickness: 2,
                      endIndent: 20,
                    ),
                    SizedBox(height: 10),
                    FittedBox(
                      child: Text(questionController.questionList[0],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 10),
                    Text(profileController.answer1.value,
                        style: TextStyle(height: 1.5)),
                    SizedBox(height: 10),
                    Text(questionController.questionList[1],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      profileController.answer2.value,
                      style: TextStyle(height: 1.5),
                    ),
                    SizedBox(height: 10),
                    Text(questionController.questionList[2],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      profileController.answer3.value,
                      style: TextStyle(height: 1.5),
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                            width: Get.width,
                            height: Get.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Color.fromARGB(255, 8, 145, 38),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _rowItem(
                                    'Plays In ', profileController.game.value),
                                _rowItem(
                                    'Level ', profileController.level.value),
                                _rowItem('Cash',
                                    '\$${profileController.cash.value}'),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButton: userItself
            ? Container()
            : FloatingActionButton(
                onPressed: () {
                  Get.toNamed(
                    '/message-screen',
                    arguments: personData,
                  );
                },
                child: Icon(Icons.message),
              ),
      ),
    );
  }

  Widget _rowItem(String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.grey[200],
          ),
          child: Center(
            child: FittedBox(
              child: Text(data,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
