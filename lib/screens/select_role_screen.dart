// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    'Select Role',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.all(10),
                color: Colors.white,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: Center(
                        child: Text(
                          'Admin',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          'User',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          'User',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          'User',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.green,
              )),
        ],
      ),
    );
  }
}
