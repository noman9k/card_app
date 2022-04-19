// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
                  indicatorWeight: 1,
                  automaticIndicatorColorAdjustment: true,
                  isScrollable: false,
                  dragStartBehavior: DragStartBehavior.start,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: homeController.tabColor.value,
                  ),
                  controller: homeController.tabController,
                  tabs: homeController.mytabs
                      .map((Map<String, String> tab) => Tab(
                            icon: Image.asset(
                              tab['icon']!,
                              width: 40.0,
                              height: 40.0,
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
                            return Card(
                              child: ListTile(
                                title: Text(tab['title']!),
                              ),
                            );
                          },
                        ),
                      ))
                  .toList(),
        ),
      ),
    );
  }
}
