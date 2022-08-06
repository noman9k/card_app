import 'package:card_app/controllers/create_post_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CreatePost extends StatefulWidget {
    CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
   final controller = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Announce',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green),),
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
                      return Row(
                       // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: ListTile(
                                leading: Image.network(snapshot.data!['image'],width: 80,height: 80,),
                                title: Text(snapshot.data!['userName'],style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      '${snapshot.data!['country']}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                        'assets/icons/${snapshot.data!['role']}.svg',width: 30,height: 30,)
                                  ],
                                ),
                                trailing: ElevatedButton(
                                  onPressed: ()async{
                                   await controller.createPost().then((value){
                                     Get.back();
                                   });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey,
                                  ),
                                  child: const Text('PUBLIER'),
                                ),
                                contentPadding: const EdgeInsets.all(0),
                                horizontalTitleGap: 0,
                                minLeadingWidth: 20,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Obx((){
                      return PopupMenuButton<String>(
                        icon: Row(
                          children: [
                            Text(controller.initialValue.value == '' ? 'CHOISIR UN TITRE' : controller.initialValue.value
                              ,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                            const SizedBox(width: 4,),
                            const Icon(Icons.keyboard_arrow_down_outlined),
                          ],
                        ),
                        initialValue: controller.initialValue.value,
                        position: PopupMenuPosition.under,
                        onSelected: controller.choiceAction,
                        itemBuilder: (BuildContext context) {
                          return controller.choices.map((String choice) {
                            return PopupMenuItem<String>(
                              enabled: choice == "Recherche joueur pour" ? false : true,
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      );
                    }),
                  ),
                ),
                const Divider(thickness: 1,color: Colors.black,),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Obx((){
                        return controller.initialValue.value == "Autres" ? TextFormField(
                          maxLength: 15,
                          controller: controller.titleController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                            hintText: 'Title',
                          ),
                        ) : SizedBox.shrink();
                      }),
                      const SizedBox(height: 8,),
                      Obx((){
                        return controller.initialValue.value == '' ? const SizedBox.shrink() : TextFormField(
                          controller: controller.postController,
                          maxLines: 3,
                          maxLength: 100,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Create Public Post...',
                            hintText: 'Create Public Post...',
                          ),
                          onSaved: (value) {
                            controller.postController.text = value!;
                          },
                        );
                      }),
                    ],
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

