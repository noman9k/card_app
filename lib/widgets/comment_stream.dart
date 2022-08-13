import 'package:card_app/widgets/comment_delete_alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'comments_like.dart';

class CommentStream extends StatelessWidget {
  CommentStream({Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.country,
    required this.role
  }) : super(key: key);
  final String id;
  final String image;
  final String name;
  final String country;
  final String role;


  TextEditingController _textFieldController = TextEditingController();
  String? codeDialog;
  String? valueText;
  
  Future<void> _displayTextInputDialog(BuildContext context,String commentId,String postId) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Mettre à jour votre commentaire'),
            content: TextField(
              controller: _textFieldController,
              maxLines: 3,
              minLines: 3,
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text('ANNULER',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text('D\'ACCORD',style: TextStyle(color: Colors.white,),),
                onPressed: () {

                  FirebaseFirestore.instance.collection("post").doc(postId).collection("comments")
                  .doc(commentId).update({
                    "comment": _textFieldController.text
                  });
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("post")
          .doc(id)
          .collection("comments")
          .orderBy('time',descending: false)
          .snapshots(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        if(snapshot.hasError){
          return const Center(child: Text('Quelque chose s\'est mal passé',style: TextStyle(fontSize: 16),),);
        }
        if(snapshot.hasData){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onLongPress: (){
                  if(FirebaseAuth.instance.currentUser!.uid == snapshot.data!.docs[index]['userId']){
                    showModalBottomSheet<void>(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 16,),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CommentDeleteDialog(postId: snapshot.data!.docs[index]['postId'],
                                          commentId: snapshot.data!.docs[index]['commentId']);
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  elevation: MaterialStateProperty.all(0),
                                ),
                                icon: const Icon(
                                  Icons.delete,
                                  size: 24.0,
                                  color: Colors.black,
                                ),
                                label: const Text('Éliminer',style: TextStyle(color: Colors.black),), // <-- Text
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _textFieldController.text = snapshot.data!.docs[index]['comment'];
                                  _displayTextInputDialog(context,snapshot.data!.docs[index]['commentId']
                                  ,snapshot.data!.docs[index]['postId']);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  elevation: MaterialStateProperty.all(0),
                                ),
                                icon: const Icon(
                                  Icons.create,
                                  size: 24.0,
                                  color: Colors.black,
                                ),
                                label: const Text(' Modifier la publication',style: TextStyle(color: Colors.black),),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
                child: Comment(
                    name: snapshot.data!.docs[index]['name'],
                    country: snapshot.data!.docs[index]['country'],
                    role: snapshot.data!.docs[index]['role'],
                    comment: snapshot.data!.docs[index]['comment'],
                    userImage: snapshot.data!.docs[index]['image'],
                    time: snapshot.data!.docs[index]['time'],
                    postId: snapshot.data!.docs[index]['postId'],
                    commentId: snapshot.data!.docs[index]['commentId'],
                    onRespond: (){
                      Get.toNamed('/comments-responses',
                          arguments: [id,snapshot.data!.docs[index]['commentId'],image,name,country,role]);
                    },
                    profileTap: (){
                      FirebaseFirestore.instance.collection("users").doc(snapshot.data!.docs[index]['userId'])
                      .get().then((DocumentSnapshot documentSnapshot){
                        Get.toNamed('/profile-screen', arguments: documentSnapshot);
                      });
                    },
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class Comment extends StatelessWidget {
  const Comment({
    Key? key,
    required this.name,
    required this.country,
    required this.role,
    required this.comment,
    required this.userImage,
    required this.time,
    required this.postId,
    required this.commentId,
    required this.onRespond,
    required this.profileTap
  }) : super(key: key);


  final String name;
  final String country;
  final String role;
  final String comment;
  final String userImage;
  final int time;
  final String postId;
  final String commentId;
  final VoidCallback onRespond;
  final VoidCallback profileTap;

  @override
  Widget build(BuildContext context) {

    var minutes = ((DateTime.now().millisecondsSinceEpoch - time.toInt()) / 1000) / 60;
    var hours = (((DateTime.now().millisecondsSinceEpoch - time.toInt()) / 1000) / 60)/60;

    DateTime date =  DateTime.fromMillisecondsSinceEpoch(time.toInt());
    var format =  DateFormat("yMd");
    var dateString = format.format(date);

    var showTime;
    if(minutes.toInt() < 59){
      showTime = minutes.toInt().toString()+"m";
    }else if(hours.toInt() < 23){
      showTime = hours.toInt().toString()+"h";
    }else{
      showTime = dateString;
    }

    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: profileTap,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image.network(userImage, width: 60, height: 40,),
              horizontalTitleGap: 0,
              title: Text(name,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
              subtitle: Row(
                children: [
                  Text(showTime),
                  Text(
                    '${country}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/$role.svg',width: 30,height: 30,)
                ],
              ),
            ),
          ),
          const SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(comment,style: const TextStyle(fontSize: 16),),
          ),
          Row(
            children: [
              TextButton(
                onPressed: onRespond,
                child: Text('Répondre'),
              ),
              Spacer(),
              Text('J\'aime'),
              CommentsLike(postId: postId, commentId: commentId,),
            ],
          ),
          const Divider(thickness: 2,),
        ],
      ),
    );
  }
}


