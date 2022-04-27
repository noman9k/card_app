// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/question_controller.dart';

// ignore: must_be_immutable
class QuestionScreen extends StatelessWidget {
  QuestionScreen({Key? key}) : super(key: key);

  QuestionController questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Form(
              key: questionController.questionFormKey,
              child: Column(
                children: [
                  _buildQuestion(0),
                  myTextFormFiled(
                    text: questionController.questionList[0],
                    controller: questionController.q0Controller,
                    validator: questionController.q0validate,
                  ),
                  _buildQuestion(1),
                  myTextFormFiled(
                    text: questionController.questionList[1],
                    controller: questionController.q1Controller,
                    validator: questionController.q1validate,
                  ),
                  _buildQuestion(2),
                  myTextFormFiled(
                    text: questionController.questionList[2],
                    controller: questionController.q2Controller,
                    validator: questionController.q2validate,
                  ),
                ],
              ),
            ),
            // SizedBox(height: 16),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () => questionController.submitAnswers(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget myTextFormFiled({
  required String text,
  TextEditingController? controller,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelText: text,
      border: OutlineInputBorder(),
    ),
  );
}

Widget _buildQuestion(int index) {
  QuestionController questionController = Get.find();
  return Column(
    children: [
      SizedBox(height: 16),
      Row(
        children: [
          Text(
            'Q${index + 1} : ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            width: Get.width * 0.8,
            child: FittedBox(
              child: Text(questionController.questionList[index],
                  style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
    ],
  );
}
