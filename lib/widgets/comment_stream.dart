import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CommentStream extends StatelessWidget {
  CommentStream({Key? key,required this.id}) : super(key: key);
  final String id;

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
          return const Center(child: Text('Something went wrong',style: TextStyle(fontSize: 16),),);
        }
        if(snapshot.hasData){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              return Comment(
                  name: snapshot.data!.docs[index]['name'],
                  country: snapshot.data!.docs[index]['country'],
                  role: snapshot.data!.docs[index]['role'],
                  comment: snapshot.data!.docs[index]['comment'],
                  userImage: snapshot.data!.docs[index]['image'],
                  time: snapshot.data!.docs[index]['time'],
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
  }) : super(key: key);


  final String name;
  final String country;
  final String role;
  final String comment;
  final String userImage;
  final int time;

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
          ListTile(
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
          const SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(comment,style: const TextStyle(fontSize: 16),),
          ),
          const Divider(thickness: 2,),
        ],
      ),
    );
  }
}
