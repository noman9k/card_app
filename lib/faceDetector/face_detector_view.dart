import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'dart:io';
import 'dart:ui';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'camera-view.dart';


class FaceDetectorView extends StatefulWidget {
  @override
  _FaceDetectorViewState createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Face Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: (inputImage) {
        processImage(inputImage);
      },
      initialDirection: CameraLensDirection.front,
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });

    final faces = await _faceDetector.processImage(inputImage);

    print("oooooooooooooooooooooooooooo");
    print(faces);

    // for (Face face in faces) {
    //   if (face != null) {
    //     final Rect boundingBox = face.boundingBox;
    //     print(boundingBox.isEmpty);
    //
    //     final double rotY = face
    //         .headEulerAngleY!; // Head is rotated to the right rotY degrees
    //     final double rotZ = face
    //         .headEulerAngleZ!; // Head is tilted sideways rotZ degrees
    //
    //     // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
    //     // eyes, cheeks, and nose available):
    //     final FaceLandmark leftEar = face.landmarks[FaceLandmarkType.leftEar]!;
    //     final Point<int> leftEarPos = leftEar.position;
    //
    //     // If classification was enabled with FaceDetectorOptions:
    //     if (face.smilingProbability != null) {
    //       final double smileProb = face.smilingProbability!;
    //     }
    //
    //     // If face tracking was enabled with FaceDetectorOptions:
    //     if (face.trackingId != null) {
    //       final int id = face.trackingId!;
    //     }
    //   }
    // }


    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = FaceDetectorPainter(
          faces,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';
      for (final face in faces) {
        text += 'face: ${face.boundingBox}\n\n';
      }
      _text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}





class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.faces, this.absoluteImageSize, this.rotation);

  final List<Face> faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final options = FaceDetectorOptions();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.red;

    final faceDetector = FaceDetector(options: options);

    for (final Face face in faces) {
      final Rect boundingBox = face.boundingBox;

      final double? rotY = face.headEulerAngleY; // Head is rotated to the right rotY degrees
      final double? rotZ = face.headEulerAngleZ; // Head is tilted sideways rotZ degrees

      // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
      // eyes, cheeks, and nose available):
      final FaceLandmark leftEar = face.landmarks[FaceLandmarkType.leftEar]!;
      if (leftEar != null) {
        final Point<double> leftEarPos = leftEar.position as Point<double>;
      }

      // If classification was enabled with FaceDetectorOptions:
      if (face.smilingProbability != null) {
        final double? smileProb = face.smilingProbability;
      }

      // If face tracking was enabled with FaceDetectorOptions:
      if (face.trackingId != null) {
        final int? id = face.trackingId;
      }

      canvas.drawRect(
        Rect.fromLTRB(
          translateX(face.boundingBox.left, rotation, size, absoluteImageSize),
          translateY(face.boundingBox.top, rotation, size, absoluteImageSize),
          translateX(face.boundingBox.right, rotation, size, absoluteImageSize),
          translateY(
              face.boundingBox.bottom, rotation, size, absoluteImageSize),
        ),
        paint,
      );

      void paintContour(FaceContourType type) {
        final faceContour = face.contours[type];
        if (faceContour?.points != null) {
          for (final Point point in faceContour!.points) {
            canvas.drawCircle(
                Offset(
                  translateX(
                      point.x.toDouble(), rotation, size, absoluteImageSize),
                  translateY(
                      point.y.toDouble(), rotation, size, absoluteImageSize),
                ),
                1,
                paint);
          }
        }
      }

      paintContour(FaceContourType.face);
      paintContour(FaceContourType.leftEyebrowTop);
      paintContour(FaceContourType.leftEyebrowBottom);
      paintContour(FaceContourType.rightEyebrowTop);
      paintContour(FaceContourType.rightEyebrowBottom);
      paintContour(FaceContourType.leftEye);
      paintContour(FaceContourType.rightEye);
      paintContour(FaceContourType.upperLipTop);
      paintContour(FaceContourType.upperLipBottom);
      paintContour(FaceContourType.lowerLipTop);
      paintContour(FaceContourType.lowerLipBottom);
      paintContour(FaceContourType.noseBridge);
      paintContour(FaceContourType.noseBottom);
      paintContour(FaceContourType.leftCheek);
      paintContour(FaceContourType.rightCheek);
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}


double translateX(
    double x, InputImageRotation rotation, Size size, Size absoluteImageSize) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
      return x *
          size.width /
          (Platform.isIOS ? absoluteImageSize.width : absoluteImageSize.height);
    case InputImageRotation.rotation270deg:
      return size.width -
          x *
              size.width /
              (Platform.isIOS
                  ? absoluteImageSize.width
                  : absoluteImageSize.height);
    default:
      return x * size.width / absoluteImageSize.width;
  }
}

double translateY(
    double y, InputImageRotation rotation, Size size, Size absoluteImageSize) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
    case InputImageRotation.rotation270deg:
      return y *
          size.height /
          (Platform.isIOS ? absoluteImageSize.height : absoluteImageSize.width);
    default:
      return y * size.height / absoluteImageSize.height;
  }
}