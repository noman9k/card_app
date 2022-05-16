// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:card_app/constant/colors.dart';
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
  var userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    userItself = personData == null ? true : false;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 139, 135, 135),
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
                    //flag
                    Positioned(
                      top: 10,
                      left: 10,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Text(
                          profileController.flag.value,
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                    //msg
                    userItself
                        ? Container()
                        : Positioned(
                            bottom: 30,
                            left: 10,
                            child: Container(
                              margin: EdgeInsetsDirectional.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                  color: Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Get.toNamed(
                                    '/message-screen',
                                    arguments: [
                                      personData['uId'],
                                      personData['userName'],
                                      personData['image'],
                                    ],
                                  );
                                },
                                icon: Icon(Icons.chat_bubble),
                              ),
                            )),
                    //Role
                    Positioned(
                      bottom: 30,
                      right: 10,
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Stack(
                          children: [
                            Positioned(
                                left: 10,
                                bottom: 60,
                                child: Text('Team',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),)),
                            Positioned(
                              bottom: 5,
                              right: 35,
                              child: Container(
                                width: 50,
                                height: 50,
                                  decoration : BoxDecoration(
                                    border: Border.all(width: 3, color: MyColors.backgroundColor),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                child: InkWell(
                                  onTap: () {
                                    if (userItself &&
                                        !profileController.roleEdited.value) {
                                      roleController.updateReturnRoute('/home-screen');
                                      Get.toNamed('/select-role-screen',arguments: [true]);
                                    }
                                  },
                                  child: SvgPicture.asset(
                                      'assets/icons/${profileController.role.value}.svg'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Image
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          Stack(
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(100),
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
                              userItself ?Positioned(
                                bottom: 0,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/image-upload-screen',arguments: [true]);
                                  },
                                  child: ClipOval(
                                    child: Container(
                                      color: Colors.black,
                                      padding: EdgeInsetsDirectional.all(8),
                                      child: Icon(Icons.add_a_photo,
                                          size: 30, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ) : Positioned(child: SizedBox()),
                            ],
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
                    //Description
                    Positioned(
                      bottom: -30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            color: Colors.grey[500],
                          ),
                          width: Get.width - 20,
                          height: 60,
                          padding: const EdgeInsets.all(7),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                profileController.description.value,
                               // maxLines: 6,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Edit Descriprion

                    Positioned(
                      bottom: -15,
                      right: 10,
                      child: userItself &&
                              !profileController.descriptionEdited.value
                          ? IconButton(
                              onPressed: () {
                                profileController.setDescription();
                              },
                              icon: Icon(Icons.edit),
                            )
                          : Container(),
                    ),
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
                          'À propos de ${profileController.name.value}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 10),
                        !profileController.questionEdited.value && userItself
                            ? IconButton(
                                onPressed: () {
                                  questionController.setControllerValues(
                                    profileController.answer1.value,
                                    profileController.answer2.value,
                                    profileController.answer3.value,
                                  );

                                  questionController
                                      .updateReturnRoute('/home-screen');
                                  Get.toNamed('/question-screen',arguments: [true]);
                                },
                                icon: Icon(Icons.edit),
                              )
                            : Container(),
                        Spacer(),
                        // FutureBuilder<List?>(
                        //     future: profileController.likedList(
                        //         userItself ? null : personData['uId']),
                        //     builder: (context, snapshot) {
                        //       var data = snapshot.data;
                        //       var isLiked =
                        //           data?.contains(personData['uId']) ?? false;
                        //       if (snapshot.hasError) {
                        //         return Text('Error: ${snapshot.error}');
                        //       }
                        //       if (snapshot.connectionState ==
                        //           ConnectionState.waiting) {
                        //         return Center(
                        //           child: SizedBox(
                        //               height: 20,
                        //               width: 20,
                        //               child: CircularProgressIndicator(
                        //                 strokeWidth: 1,
                        //                 color: Color.fromARGB(255, 2, 63, 124),
                        //               )),
                        //         );
                        //       }
                        //       if (data == null) {
                        //         return Center(
                        //           child: Text('No Data Found'),
                        //         );
                        //       }

                        //       if (snapshot.hasData) {}
                        //       return Row(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           Text(
                        //             '${data.length - 1}',
                        //             style: TextStyle(
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.bold,
                        //               color: isLiked
                        //                   ? Color.fromARGB(255, 2, 63, 124)
                        //                   : Color.fromARGB(169, 92, 81, 81),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: 5,
                        //           ),
                        //           SizedBox(
                        //             width: 30,
                        //             height: 30,
                        //             child: GestureDetector(
                        //               onTap: () {
                        //                 profileController
                        //                     .setLikes(personData['uId']);
                        //               },
                        //               child: SvgPicture.asset(
                        //                 'assets/images/like.svg',
                        //                 color: isLiked
                        //                     ? Color.fromARGB(255, 2, 63, 124)
                        //                     : Color.fromARGB(169, 92, 81, 81),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       );
                        //     }),

                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                (profileController.likes.value - 1).toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: profileController.blueLike.value
                                      ? Color.fromARGB(255, 2, 63, 124)
                                      : Color.fromARGB(169, 92, 81, 81),
                                ),
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  profileController.setLikes(personData['uId']);
                                },
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                    'assets/images/like.svg',
                                    color: profileController.blueLike.value
                                        ? Color.fromARGB(255, 2, 63, 124)
                                        : Color.fromARGB(169, 92, 81, 81),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 3),
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
                                  BorderRadius.all(Radius.circular(10)),
                              color: MyColors.backgroundColor.withOpacity(0.7),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _rowItem(
                                    'Niveau', profileController.level.value),
                                _rowItem('Mode ', profileController.game.value),
                                _rowItem('Joueur',
                                    ' ${profileController.cash.value}'),
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
      ),
    );
  }

  Widget _rowItem(String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 70,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            // color: Colors.grey[200],
            color: MyColors.backgroundColor.withOpacity(0.7),
          ),
          child: Center(
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: MyColors.newTextColor)),
          ),
        ),
        Container(
          height: 50,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.grey[200],
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(data,
                  maxLines: 2,
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
