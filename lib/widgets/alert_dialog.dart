import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BeautifulAlertDialog extends StatelessWidget {
  // HomeController controller;
  final String postId;
  BeautifulAlertDialog({required this.postId});


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.only(right: 16.0),
          height: 150,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75),
                  bottomLeft: Radius.circular(75),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 20.0),
              CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(FontAwesomeIcons.exclamationCircle,color: Colors.red,size: 50,)
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Alert!",
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                    const SizedBox(height: 10.0),
                    const Flexible(
                      child: Text(
                          "Do you want to continue to delete this post ?"),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            child: const Text("No",style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                            // colorBrightness: Brightness.dark,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            child: Text("Yes",style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                            //colorBrightness: Brightness.dark,
                            onPressed: () {
                              FirebaseFirestore.instance.collection("post").doc(postId).delete();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}