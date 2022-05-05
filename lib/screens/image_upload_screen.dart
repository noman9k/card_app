import 'dart:io';

import 'package:card_app/controllers/face_detector_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  ImageUploadScreen({Key? key}) : super(key: key);

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  FaceDetectorColtroller controller = Get.put(FaceDetectorColtroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // body: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisSize: MainAxisSize.max,
          //
          //   // ignore: prefer_const_literals_to_create_immutables
          //   children: [
          //     Row(
          //       mainAxisSize: MainAxisSize.max,
          //     ),
          //     Text('Image Upload Screen'),
          //     ElevatedButton(
          //       onPressed: () {
          //         //Get.toNamed('/home-screen');
          //       },
          //       child: Text('Go to Home'),
          //     ),
          //   ],
          // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return controller.selectedImagePath.value != ''
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.file(File(controller.selectedImagePath.value)),
                          //if (widget.customPaint != null) widget.customPaint!,
                        ],
                      ),
                    )
                  : Icon(
                      Icons.image,
                      size: 200,
                    );
            }),
            SizedBox(height: 10,),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                child: Text(
                  'From Gallery',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  controller.getImage(ImageSource.gallery);
                },
              ),
            ),
            SizedBox(height: 10,),
            Obx(() {
              return controller.faces.length > 0
                  ? Container(
                      height: 40,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        child: controller.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Upload Image',
                                style: TextStyle(fontSize: 20),
                              ),
                        onPressed: () {
                          controller.loadPic();
                        },
                      ),
                    )
                  : Container();
            }),
          ],
        ),
      ),
    );
  }
}
