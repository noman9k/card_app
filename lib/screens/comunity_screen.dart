// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:card_app/constant/colors.dart';
import 'package:card_app/controllers/profile_controller.dart';
import 'package:card_app/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


import '../controllers/comunity_controller.dart';

class ComunityScreen extends StatefulWidget {
  ComunityScreen({Key? key}) : super(key: key);

  @override
  State<ComunityScreen> createState() => _ComunityScreenState();
}

class _ComunityScreenState extends State<ComunityScreen> {
  ComunityController homeController = Get.put(ComunityController());

  ProfileController profileController = Get.put(ProfileController());

  String? userId = FirebaseAuth.instance.currentUser!.uid;
  //var liked;
  var id;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            Obx(
              () => SliverAppBar(
                toolbarHeight: 50,
                backgroundColor: Color.fromARGB(255, 139, 135, 135),
                floating: true,
                pinned: true,
                title: Text(
                  'Dreeam',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  indicatorPadding: EdgeInsets.all(0),
                  onTap: (index) => homeController.tabColor.value =
                      homeController.myTabColor[index],
                  indicatorColor: homeController.tabColor.value,
                  indicatorWeight: 5,
                  automaticIndicatorColorAdjustment: true,
                  labelColor: MyColors.textColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: Colors.white,
                  labelStyle: TextStyle(
                    fontSize: 10,
                  ),
                  isScrollable: true,
                  dragStartBehavior: DragStartBehavior.down,
                  controller: homeController.tabController,
                  enableFeedback: false,
                  tabs: homeController.mytabs
                      .map((Map<String, String> tab) => Tab(
                            height: 70,
                            text: tab['title'],
                            icon: SvgPicture.asset(
                              tab['icon']!,
                              width: 35.0,
                              height: 35.0,
                              color: homeController.myIconColor[
                                      homeController.mytabs.indexOf(tab)]
                                  [tab['title']!],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: homeController.tabController,
          children: [
            _comunityList('heart'),
            _comunityList('spades'),
            _comunityList('diamond'),
            _comunityList('club'),
          ],
        ),
      ),
    );
  }

  Widget _comunityList(String comunity) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: comunity)
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          var data = snapshot.data;
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (data == null) {
            return Center(
              child: Text('No Data Found'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return _myListTile(data.docs[index]);
            },
          );
        });
  }

  Widget _myListTile(QueryDocumentSnapshot<Object?> doc) {
    if (doc['uId'] == FirebaseAuth.instance.currentUser!.uid) {
      return SizedBox.shrink();
    }
    return InkWell(
      onTap: () {
        profileController.setProfileData(doc);
        Get.toNamed('/profile-screen', arguments: doc);
      },
      child: Card(
        child: Container(
          //color: Colors.red,
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.brown.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    doc['image']!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc["userName"],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 65,
                    width: Get.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc['description'],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${doc['locationDetails'].split('_')[0]},${doc['locationDetails'].split('_')[1]} ${doc['country']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: (){
                  profileController.setLikes(doc['uId']);
                  profileController.getLikes(userId);
                },
                child: Row(
                  children: [
                    SvgPicture.asset("assets/images/like.svg",width: 30,height: 30,
                    color: doc['likes'].contains(userId) ? Color.fromARGB(255, 2, 63, 124) : Colors.grey,),
                    SizedBox(width: 4,),
                    Text('${doc['likes'].length - 1}',style: TextStyle(
                      fontSize: 18,
                      color: doc['likes'].contains(userId) ? Color.fromARGB(255, 2, 63, 124) : Colors.grey,
                    ),),
                  ],
                ),
              ),
              // Container(
              //    width: 50,
              //    height: 50,
              //   child: LikeButton(
              //     onTap: onLikeButtonTapped,
              //     size: 20,
              //     circleColor:
              //     CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
              //     bubblesColor: BubblesColor(
              //       dotPrimaryColor: Color(0xff33b5e5),
              //       dotSecondaryColor: Color(0xff0099cc),
              //     ),
              //     likeBuilder: (bool isLiked) {
              //       //liked = isLiked;
              //       isLiked = doc['likes'].contains(FirebaseAuth.instance.currentUser!.uid);
              //       return Icon(
              //         Icons.home,
              //         color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
              //         size: 20,
              //       );
              //     },
              //     likeCount: doc['likes'].length - 1,
              //     countBuilder: (int? count, bool isLiked, String text) {
              //       //liked = isLiked;
              //       var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
              //       Widget result;
              //       if (count == 0) {
              //         result = Text(
              //           "0",
              //           style: TextStyle(color: color),
              //         );
              //       } else
              //         result = Text(
              //           text,
              //           style: TextStyle(color: color),
              //         );
              //       return result;
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

}
