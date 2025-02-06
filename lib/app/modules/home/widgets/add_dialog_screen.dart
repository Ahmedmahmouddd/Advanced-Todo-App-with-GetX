// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_x/app/core/utils/extention.dart';
import 'package:get_x/app/core/values/colors.dart';
import 'package:get_x/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homecontroller = Get.find<HomeController>();
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homecontroller.chooseTask(null);
                      homecontroller.editingController.clear();
                    },
                    splashColor: const Color(0xA0FFFFFF),
                    icon: Icon(Icons.close_rounded, color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () {
                        if (homecontroller.formKey.currentState!.validate()) {
                          if (homecontroller.task.value == null) {
                            EasyLoading.showError("Please Choose Task Type");
                          } else {
                            var success = homecontroller.updateTask(
                              homecontroller.task.value!,
                              homecontroller.editingController.text,
                            );
                            if (success) {
                              EasyLoading.showSuccess("Todo Item added to task");
                              Get.back();
                              homecontroller.editingController.clear();
                              homecontroller.chooseTask(null);
                            } else {
                              EasyLoading.showError("Todo Item already exist");
                            }
                          }
                        }
                      },
                      style: ButtonStyle(overlayColor: MaterialStateProperty.all(const Color(0xA0FFFFFF))),
                      child: Text("Done",
                          style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600)))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("New Task", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
              ),
              Form(
                key: homecontroller.formKey,
                child: TextFormField(
                  style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
                  controller: homecontroller.editingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    labelStyle: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
                    fillColor: Colors.grey[300],
                    labelText: "Note Title",
                  ),
                  cursorColor: Colors.grey[600],
                  cursorWidth: 2,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter title";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Text(
                    "Add to",
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                  )),
              ...homecontroller.tasks.map((task) => Obx(() {
                    return InkWell(
                      onTap: () => homecontroller.chooseTask(task),
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Row(
                            children: [
                              Icon(IconData(task.icon, fontFamily: 'MaterialIcons'),
                                  color: HexColor.fromHex(task.color)),
                              SizedBox(width: 12),
                              Text(task.title, style: TextStyle(fontWeight: FontWeight.w600)),
                              Spacer(),
                              if (homecontroller.task.value == task) Icon(Icons.check, color: Colors.green),
                            ],
                          )),
                    );
                  }))
            ],
          ),
        ));
  }
}
