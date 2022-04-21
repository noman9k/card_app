// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:card_app/controllers/role_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../modals/role_model.dart';

class SelectRoleScreen extends StatelessWidget {
  SelectRoleScreen({Key? key}) : super(key: key);

  RoleController roleController = Get.put(RoleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //title
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
          // selec role
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: roleController.rolesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  return Obx(() => GestureDetector(
                        onTap: () => roleController.selectRole(index),
                        child: _gridItem(
                          role: roleController.rolesList[index],
                          isSelected:
                              roleController.selectedRole.value == index,
                        ),
                      ));
                },
              ),
            ),
          ),
          // desctiption
          Expanded(
            flex: 3,
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      roleController
                          .rolesList[roleController.selectedRole.value].name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        roleController
                            .rolesList[roleController.selectedRole.value]
                            .description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => roleController.saveToDB(),
                          child: Text('Continue With The Selection'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _gridItem({required Role role, required bool isSelected}) {
  return Container(
    decoration: isSelected
        ? BoxDecoration(
            border: Border.all(width: 3, color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(80),
          )
        : null,
    child: Center(
      child: SvgPicture.asset(
        role.image,
        color: role.color,
        height: 100,
        width: 100,
      ),
    ),
  );
}
