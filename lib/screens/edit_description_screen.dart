import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constant/colors.dart';
import '../controllers/edit_description_controller.dart';
import '../widgets/my_widgets.dart';

class EditDescriptionScreen extends StatelessWidget {
  EditDescriptionScreen({Key? key}) : super(key: key);

  final EditDescriptionController controller =
      Get.put(EditDescriptionController());

  @override
  Widget build(BuildContext context) {
    var description = Get.arguments[0];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Description'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Choose Previous Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 80,
                width: Get.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: controller.previousDescription.isTrue
                          ? BoxDecoration(
                              border: Border.all(
                                  width: 2, color: MyColors.backgroundColor),
                              borderRadius: BorderRadius.circular(10),
                            )
                          : null,
                      width: Get.width * 0.8,
                      child: InkWell(
                        onTap: () {
                          description = controller.previousDescription.value
                              ? ''
                              : Get.arguments[0];
                          controller.descriptionController.text = description;
                          controller.togglePreviousDescription();
                        },
                        child: Text(
                          ' $description',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: Get.width * 0.1,
                        height: 50,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: SvgPicture.asset('assets/images/like.svg',
                                  color: const Color.fromARGB(255, 2, 63, 124)),
                            ),
                            // ignore: prefer_const_constructors
                            Text(
                              Get.arguments[1].length == 0
                                  ? '0'
                                  : (Get.arguments[1].length - 1).toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: controller.descriptionController,
                decoration: InputDecoration(
                  labelText: 'Enter New Description',
                  labelStyle: TextStyle(
                    color: MyColors.textColor.withOpacity(0.7),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MyColors.textColor,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.textColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.textColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyElevatedButton(
                child: const Text('Suivant',
                    style: TextStyle(
                      fontSize: 20,
                      color: MyColors.newTextColor,
                    )),
                onButtonPressed: () async {
                  await controller.updateDescription(
                      controller.descriptionController.text,
                      Get.arguments[0] as String,
                      Get.arguments[1] as List);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
