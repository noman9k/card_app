import 'dart:io';

import 'package:card_app/controllers/face_detector_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/colors.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sélectionner une photo de profil avec votre visage dessus',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: MyColors.textColor,
                ),
              ),
              Obx(() {
                return controller.selectedImagePath.value != ''
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.file(
                                File(controller.selectedImagePath.value)),
                            //if (widget.customPaint != null) widget.customPaint!,
                          ],
                        ),
                      )
                    : const Icon(
                        Icons.image,
                        size: 200,
                      );
              }),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  child: const Text(
                    'IMPORTER',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    controller.getImage(ImageSource.gallery);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                return controller.faces.length > 0
                    ? Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 16),
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
      ),
    );
  }
}
