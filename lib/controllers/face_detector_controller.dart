import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorColtroller extends GetxController{

  FirebaseStorage _storage = FirebaseStorage.instance;
  CollectionReference usersReference = FirebaseFirestore.instance.collection('users');

  File? image;
  File? compressedFile;
  String? paths;
  ImagePicker imagePicker = ImagePicker();
  var selectedImagePath = ''.obs;
  RxList faces = [].obs;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    ),
  );
  var isLoading = false.obs;

  @override
  void dispose(){
    super.dispose();
    _faceDetector.close();
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      _processPickedFile(pickedFile);
    }
  }

  Future _processPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }

    selectedImagePath.value = path;
    compressedFile = await FlutterNativeImage.compressImage(path, quality: 50);
    image = File(compressedFile!.path);
    paths = path;
    final inputImage = InputImage.fromFilePath(path);
    faces.value = await _faceDetector.processImage(inputImage);
  }


  Future<String?> uploadFile(filePath) async {
    File file = File(compressedFile!.path);
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    try {
      await _storage.ref('uploads/user/${randomStr}').putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
     // error = e.code;
    }
    String downloadURL = await _storage.ref('uploads/user/${randomStr}').getDownloadURL();

    return downloadURL;
  }

  Future<void> loadPic() async{
    isLoading.value = true;
    uploadFile(selectedImagePath.value).then((url){
        if(url != null){
          usersReference.doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            "image" : url
          });
          Get.offAllNamed('/home-screen');
           isLoading = false.obs;
        }else{
           isLoading = false.obs;
          Get.snackbar("Alert", "Image not uploaded , Try again later",
              margin: EdgeInsets.all(16),snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,colorText: Colors.black);
        }
    });
  }
}