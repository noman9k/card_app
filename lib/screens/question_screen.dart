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
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: questionController.q1Controller,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: questionController.questionList[0],
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _buildQuestion(1),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: questionController.q2Controller,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(),
                      labelText: questionController.questionList[1],
                    ),
                  ),
                  _buildQuestion(2),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: questionController.q3Controller,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(),
                      labelText: questionController.questionList[2],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
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

Widget _buildQuestion(int index) {
  QuestionController questionController = Get.find();
  return Column(
    children: [
      SizedBox(height: 16),
      Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            'Q${index + 1} : ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(questionController.questionList[index],
              style: TextStyle(fontSize: 20)),
        ],
      ),
      SizedBox(height: 10),
    ],
  );
}
