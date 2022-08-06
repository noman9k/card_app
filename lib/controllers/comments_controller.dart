import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentsController{

  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection("post");
  var commentController = TextEditingController();

  Future<void> sendComment(String postId,String image, String name,String country,String role)async{

    if(commentController.text.isNotEmpty){
      _collectionReference.doc(postId).collection("comments").add({
        "comment" : commentController.text,
        "name" : name,
        "image" : image,
        "time" : DateTime.now().millisecondsSinceEpoch,
        "country" : country,
        "role" : role
      });
      commentController.text = '';
    }
  }
}