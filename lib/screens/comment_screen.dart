import 'package:card_app/controllers/comments_controller.dart';
import 'package:card_app/widgets/comment_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CommentScreen extends StatefulWidget {
  CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  var arguments = Get.arguments;

  final _controller = CommentsController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20,),
              const Text('Comments:',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              Expanded(child: CommentStream(id: arguments[2],)),
              SizedBox(
                height: 70,
                child: Expanded(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Image.network(arguments[0],width: 80,height: 120,),
                    horizontalTitleGap: 0,
                    title:  TextField(
                      controller: _controller.commentController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: 'Write an answer',
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: (){
                        _controller.sendComment(arguments[2],arguments[0],arguments[1],arguments[3],arguments[4]);
                      },
                      icon: const Icon(Icons.send,size: 25,),
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}