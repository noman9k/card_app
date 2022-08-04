import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('Announce',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                const Divider(thickness: 1,color: Colors.black,),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.hasError){
                        return const Center(child: Text('Somethig went wrong',style: TextStyle(fontSize: 16),),);
                      }
                      return SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(snapshot.data!['image'],width: 80,height: 60,),
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
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("users").snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.hasError){
                        return Center(child: Text('somethig went wrong',style: TextStyle(fontSize: 16),),);
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Image.asset("assets/icons/announce.png"),
                                  title: Text('Shehzad'),
                                  subtitle: Row(
                                    children: [
                                      Text('8h'),
                                      Image.asset("assets/icons/announce.png"),
                                      Image.asset("assets/icons/announce.png"),
                                    ],
                                  ),
                                  trailing: Icon(Icons.menu),
                                ),
                                Text('jdfhdgjhdshdskh'),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
