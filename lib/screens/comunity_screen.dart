// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/comunity_controller.dart';

class ComunityScreen extends StatelessWidget {
  ComunityScreen({Key? key}) : super(key: key);

  ComunityController homeController = Get.put(ComunityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            Obx(
              () => SliverAppBar(
                floating: true,
                pinned: true,
                title: Text('Cards App'),
                actions: [Container()],
                bottom: TabBar(
                  onTap: (index) => homeController.tabColor.value =
                      homeController.myTabColor[index],
                  indicatorColor: homeController.tabColor.value,
                  indicatorWeight: 5,
                  automaticIndicatorColorAdjustment: true,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 10),

                  isScrollable: false,
                  dragStartBehavior: DragStartBehavior.start,
                  // indicator: BoxDecoration(
                  //   borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(20),
                  //       topRight: Radius.circular(20)),
                  //   color: homeController.tabColor.value,
                  // ),
                  controller: homeController.tabController,
                  enableFeedback: false,

                  tabs: homeController.mytabs
                      .map((Map<String, String> tab) => Tab(
                            text: tab['title'],
                            icon: SvgPicture.asset(
                              tab['icon']!,
                              width: 40.0,
                              height: 40.0,
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
          children:
              // [
              //   ClubScreen(),
              //   HeartScreen(),
              //   DiamondScreen(),
              //   SpadesScreen(),
              //   ],

              homeController.mytabs
                  .map((Map<String, String> tab) => Center(
                        child: ListView.builder(
                          itemCount: 50,
                          itemBuilder: (BuildContext context, int index) {
                            return _myListTile(tab['title']!);
                          },
                        ),
                      ))
                  .toList(),
        ),
      ),
    );
  }

  Widget _myListTile(String title) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
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
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 37,
                  width: Get.width * 0.6,
                  child: Text(
                    'lorem ipsum dolor sit amet  lorem ipsum dolor sit amet lorem ipsum dolor sit amet',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(Icons.circle, color: Colors.blue, size: 20),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '1.2k',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
