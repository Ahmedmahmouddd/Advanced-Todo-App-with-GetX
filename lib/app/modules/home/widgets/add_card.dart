import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_x/app/core/utils/extention.dart';
import 'package:get_x/app/core/values/colors.dart';
import 'package:get_x/app/data/models/task.dart';
import 'package:get_x/app/modules/home/controller.dart';
import 'package:get_x/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () async {
          Get.defaultDialog(
              backgroundColor: Colors.grey[100],
              titlePadding: EdgeInsets.only(top: 16.0, bottom: 4),
              radius: 12,
              title: "Add Task",
              titleStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[700]),
              content: Form(
                  key: homeController.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          autofocus: true,
                          style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
                          controller: homeController.editingController,
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
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 6.0,
                        runSpacing: 6,
                        children: icons
                            .map((e) => Obx(() {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(
                                    label: e,
                                    selectedColor: Colors.grey[300],
                                    showCheckmark: false,
                                    pressElevation: 0,
                                    backgroundColor: Colors.white,
                                    selected: homeController.chipIndex.value == index,
                                    onSelected: (bool selected) {
                                      homeController.chipIndex.value = selected ? index : 0;
                                    },
                                  );
                                }))
                            .toList(),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            minimumSize: const Size(150, 40),
                          ),
                          onPressed: () {
                            if (homeController.formKey.currentState!.validate()) {
                              int icon = icons[homeController.chipIndex.value].icon!.codePoint;
                              String color = icons[homeController.chipIndex.value].color!.toHex();
                              var task = Task(
                                  title: homeController.editingController.text, icon: icon, color: color);
                              Get.back();
                              homeController.addTask(task)
                                  ? EasyLoading.showSuccess("Create Success")
                                  : EasyLoading.showError("Duplicated Task");
                              homeController.editingController.clear();
                            }
                          },
                          child: Text('Confirm', style: TextStyle(color: Colors.white)))
                    ],
                  )));
          homeController.editingController.clear();
          homeController.changeChipIndex(0);
        },
        child: DottedBorder(
            color: Colors.grey[400]!,
            dashPattern: const [12, 6],
            child: Center(child: Icon(Icons.add, size: 26.0, color: Colors.grey))),
      ),
    );
  }
}
