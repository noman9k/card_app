import 'package:card_app/widgets/post_like.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../widgets/alert_dialog.dart';

class AnnouncementScreen extends StatelessWidget {
  AnnouncementScreen({Key? key}) : super(key: key);

  var userImage;
  var userName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const Padding(
                  padding: EdgeInsets.only(top: 16,left: 16),
                  child: Text('Announce',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                const Divider(thickness: 1,color: Colors.black,),
                SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.hasError){
                        return const Center(child: Text('Somethig went wrong',style: TextStyle(fontSize: 16),),);
                      }
                      userImage = snapshot.data!['image'];
                      userName = snapshot.data!['userName'];
                      return SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(snapshot.data!['image'],width: 60,height: 60,),
                            const SizedBox(width: 8,),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed("/create-post");
                              },
                              child: Container(
                                padding : const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                ),
                                child: const Text('Publier une announce...',style: TextStyle(fontSize: 20),),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Divider(thickness: 1,color: Colors.black,),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("post")
                  .orderBy('time',descending: true)
                      .limit(5)
                      .snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    if(snapshot.hasError){
                      return const Center(child: Text('Somethig went wrong',style: TextStyle(fontSize: 16),),);
                    }
                    if(snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.size,
                          itemBuilder: (context, index) {
                            return Post(
                              image: snapshot.data!.docs[index]['image'],
                              name: snapshot.data!.docs[index]['userName'],
                              country: snapshot.data!.docs[index]['userCountry'],
                              role: snapshot.data!.docs[index]['userRole'],
                              uId: snapshot.data!.docs[index]['uId'],
                              title: snapshot.data!.docs[index]['title'],
                              post: snapshot.data!.docs[index]['post'],
                              postId: snapshot.data!.docs[index]['docId'],
                              userImage: userImage,
                              moreOnPress: (){
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 150,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ElevatedButton.icon(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.update,
                                                size: 24.0,
                                              ),
                                              label: const Text('Update'),
                                            ),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return BeautifulAlertDialog(postId: snapshot.data!.docs[index]['docId']);
                                                  },
                                                );
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(
                                                Icons.delete_forever,
                                                size: 24.0,
                                              ),
                                              label: const Text('Delete'), // <-- Text
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              commentOnTap: (){
                                Get.toNamed('/comments',arguments: [userImage,userName,snapshot.data!.docs[index]['docId'],
                                  snapshot.data!.docs[index]['userCountry'],snapshot.data!.docs[index]['userRole'],]);
                              },
                            );
                          },
                        ),
                      );
                    }
                    return const Text('Data not found',style: TextStyle(fontSize: 16));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Post extends StatelessWidget {
  const Post({
    Key? key,
    required this.image,
    required this.name,
    required this.country,
    required this.role,
    required this.uId,
    required this.title,
    required this.post,
    required this.postId,
    required this.userImage,
    required this.moreOnPress,
    required this.commentOnTap
  }) : super(key: key);

  final String image;
  final String name;
  final String country;
  final String role;
  final String uId;
  final String post;
  final String title;
  final String postId;
  final String userImage;
  final VoidCallback moreOnPress;
  final VoidCallback commentOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:4),
      child: Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image.network(image, width: 80, height: 80,),
              horizontalTitleGap: 0,
              title: Text(name,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
              subtitle: Row(
                children: [
                  Text('8h'),
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
              trailing: uId ==
                  FirebaseAuth.instance.currentUser!.uid
                  ? IconButton(
                      onPressed: moreOnPress,
                      icon: const Icon(Icons.more_horiz)
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(post,style: TextStyle(fontSize: 16),),
            ),
            const SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("post").doc(postId).collection("comments").snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Text('0 Comments',style: TextStyle(fontSize: 16),);
                      }
                      if(snapshot.hasData){
                        return Text('${snapshot.data!.docs.length} Comments',style: const TextStyle(fontSize: 16),);
                      }
                      return const Text('0 Comments',style: TextStyle(fontSize: 16),);
                    },
                  ),
                  const Spacer(),
                  PostLike(postId: postId),
                ],
              ),
            ),
            const SizedBox(height: 4,),
            GestureDetector(
              onTap: commentOnTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Image.network(userImage,width: 40,height: 40,),
                    const SizedBox(width: 4,),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        padding: const EdgeInsets.only(left: 15,top: 15),
                        decoration:  BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.all(Radius.circular(30))
                        ),
                        child: const Text('Write an answer...',textAlign: TextAlign.start,style: TextStyle(fontSize: 16),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4,),
            const Divider(thickness: 2,),
          ],
        ),
      ),
    );
  }
}
