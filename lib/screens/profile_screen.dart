// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:card_app/controllers/profile_controller.dart';
import 'package:card_app/controllers/role_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  RoleController roleController = Get.find();

  ProfileController profileController = Get.put(ProfileController());
  var personData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: personData == null
              ? Container()
              : IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.back();
                  },
                ),
          actions: [
            personData != null
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
                      bottom: 30,
                      right: 10,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            if (personData == null) {
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
                                      'assets/images/profile.png',
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
                        child: Container(
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
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              overflow: TextOverflow.visible,
                            ),
                          ),
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
                    Text(
                      'About ${profileController.name.value}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Divider(
                      color: Colors.grey[700],
                      height: 5,
                      thickness: 2,
                      endIndent: 20,
                      // indent: 20,
                    ),
                    SizedBox(height: 10),
                    Text('What are your Ambisions in Poker ?',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(profileController.answer1.value,
                        style: TextStyle(height: 1.5)),
                    SizedBox(height: 10),
                    Text('What Kind Of Player you want ?',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      profileController.answer2.value,
                      style: TextStyle(height: 1.5),
                    ),
                    SizedBox(height: 10),
                    Text('What Kind Of Player you want ?',
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
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _rowItem('Level ', '4'),
                                _rowItem('Plays In', 'Cash Game'),
                                _rowItem('Cash', '\$100'),
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
        floatingActionButton: personData == null
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
