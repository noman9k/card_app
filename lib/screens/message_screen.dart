import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MessageScreen extends StatelessWidget {
  MessageScreen({Key? key}) : super(key: key);
  var userData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: Center(
        child: Text(userData['role']),
      ),
    );
  }
}
