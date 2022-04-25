import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modals/chat_model.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  var chats = dummyData;
  ChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Get.to(MyChatScreen());
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(chats[index].avatarUrl),
            ),
            title: Text(chats[index].name),
            subtitle: Text(chats[index].message),
            trailing: Text(chats[index].time),
          );
        },
      ),
    );
  }
}
