import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chat_functionality/widgets/message_stream.dart';

// ignore: must_be_immutable
class MessageScreen extends StatefulWidget {
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  var userData = Get.arguments;
  final TextEditingController _messageBodyController = TextEditingController();
  final FocusNode _messageFocus = FocusNode();
  String? message;

  CollectionReference _messageReferences =
      FirebaseFirestore.instance.collection("message");
  CollectionReference _contactReferences = FirebaseFirestore.instance.collection("contact");

  //var arguments = Get.arguments;
  String messageSenderId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> uploadMessage() async {
    String messageReceiverId = userData[0];
    Map<String, dynamic> map = {
      'text': message,
      'senderId': messageSenderId,
      'receiverId': messageReceiverId,
      'sendAt': DateTime.now().millisecondsSinceEpoch,
      'isMessageRead': false,
      'type': 'text'
    };

    // _messageReferences.doc(messageSenderId).collection("messages").doc(messageReceiverId).set(map);
    // _messageReferences.doc(messageReceiverId).collection("messages").doc(messageSenderId).set(map);
    const _chars ='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    _messageReferences
        .doc(messageSenderId)
        .collection(messageReceiverId)
        .doc(randomStr)
        .set(map);
    _messageReferences
        .doc(messageReceiverId)
        .collection(messageSenderId)
        .doc(randomStr)
        .set(map);


    _contactReferences
        .doc(messageSenderId)
        .collection("contacts")
        .doc(messageReceiverId)
        .set({
      'name': userData[1],
      'lastMsg': message,
      'image': userData[2],
      'lastMsgTime': DateTime.now().millisecondsSinceEpoch,
      'uid': messageReceiverId,
     // 'unread' : 0,
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) async {

      int unRead = 0;
      var docc = await _contactReferences
          .doc(messageReceiverId)
          .collection("contacts")
          .doc(messageSenderId)
          .get();

      if(docc.exists){
        Map<String,dynamic> map = docc.data()!;
         if(map.containsKey("unread")){
           unRead = docc['unread'] + 1;
           await _contactReferences
               .doc(messageReceiverId)
               .collection("contacts")
               .doc(messageSenderId)
               .set({
             'name': docc['name'],
             'lastMsg': message,
             'image': userData[2],
             'lastMsgTime': DateTime.now().millisecondsSinceEpoch,
             'uid': messageSenderId,
             'unread' : unRead,
               });
        }else{
           await _contactReferences
               .doc(messageReceiverId)
               .collection("contacts")
               .doc(messageSenderId)
               .set({
             'name': docc['name'],
             'lastMsg': message,
             'image': userData[2],
             'lastMsgTime': DateTime.now().millisecondsSinceEpoch,
             'uid': messageSenderId,
             'unread' : 1,
           });
         }
      }else{
        _contactReferences
            .doc(messageReceiverId)
            .collection("contacts")
            .doc(messageSenderId)
            .set({
          'name': snapshot['userName'],
          'lastMsg': message,
          'image': userData[2],
          'lastMsgTime': DateTime.now().millisecondsSinceEpoch,
          'uid': messageSenderId,
          // 'unread' : 0,
        });
      }

    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            userData[2] == ''
                ? Container(
                    //  padding: EdgeInsets.all(8),
                    //  decoration: BoxDecoration(
                    //    color: Colors.white,
                    //    shape: BoxShape.circle,
                    //  ),
                    // child: Text(name.substring(0,1).toUpperCase(),style: TextStyle(color: Colors.black),),
                    )
                : CircleAvatar(
                    backgroundImage: NetworkImage(userData[2]),
                  ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${userData[1]}',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: MessageStream(userData[0])),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white38,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.grey[350],
                    ),
                    child: TextField(
                      scrollPadding: EdgeInsets.only(bottom: 40),
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      focusNode: _messageFocus,
                      onChanged: (value) {
                        message = value;
                      },
                      controller: _messageBodyController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Send Message...',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // FocusScope.of(context).unfocus();
                    // FocusScope.of(context).requestFocus(FocusNode());
                    message = _messageBodyController.text.toString().trim();
                    if (_messageBodyController.text
                        .toString()
                        .trim()
                        .isNotEmpty) {
                      uploadMessage();
                      _messageBodyController.clear();
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.black38,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
