// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:card_app/controllers/role_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constant/colors.dart';
import '../modals/role_model.dart';

class SelectRoleScreen extends StatelessWidget {
  SelectRoleScreen({Key? key}) : super(key: key);

  RoleController roleController = Get.put(RoleController());
  var arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //title
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SizedBox(
                  width: Get.width,
                  child: Center(
                    child: Text(
                      arguments[0]
                          ? 'Vous pouvez changer de signe seulement une fois, Êtes-vous sûr de vouloir le faire maintenant ?'
                          : 'Choisissez votre team !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: MyColors.backgroundColor),
                    ),
                  ),
                ),
              )),
          // selec role
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.all(15),
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
                              roleController.selectedRoleIndex.value == index,
                          userSelectedRole:
                              roleController.userSelectedRole.value,
                        ),
                      ));
                },
              ),
            ),
          ),
          // desctiption
          Expanded(
            flex: 4,
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
                          .rolesList[roleController.selectedRoleIndex.value]
                          .name
                          .split('*')
                          .first,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      roleController
                          .rolesList[roleController.selectedRoleIndex.value]
                          .name
                          .split('*')
                          .last,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 23,
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
                            .rolesList[roleController.selectedRoleIndex.value]
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
                        Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: MyColors.backgroundColor,
                              onSurface: Color.fromARGB(0, 219, 49, 49),
                              shadowColor: Color.fromARGB(0, 92, 5, 5),
                              fixedSize: Size(150, 50),
                            ),
                            onPressed: () => roleController.saveToDB(),
                            child: roleController.isLoading.isTrue
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Suivant',
                                    style:
                                        TextStyle(color: MyColors.newTextColor),
                                  ),
                          ),
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

Widget _gridItem(
    {required Role role,
    required bool isSelected,
    required bool userSelectedRole}) {
  return Padding(
    padding: const EdgeInsets.all(28.0),
    child: Container(
      decoration: userSelectedRole && isSelected
          ? BoxDecoration(
              border: Border.all(width: 3, color: MyColors.backgroundColor),
              borderRadius: BorderRadius.circular(100),
            )
          : null,
      child: Center(
        child: SvgPicture.asset(
          role.image,
          color: role.color,
          height: 80,
          width: 80,
        ),
      ),
    ),
  );
}
