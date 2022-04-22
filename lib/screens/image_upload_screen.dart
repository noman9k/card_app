// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageUploadScreen extends StatelessWidget {
  const ImageUploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,

        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
          ),
          Text('Image Upload Screen'),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/home-screen');
            },
            child: Text('Go to Home'),
          ),
        ],
      ),
    );
  }
}
