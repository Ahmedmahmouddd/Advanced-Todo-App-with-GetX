import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_x/app/core/utils/extention.dart';
import 'package:get_x/app/modules/details/widgets/doing_list.dart';
import 'package:get_x/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailsPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeController.task.value!;
    var color = HexColor.fromHex(task.color);
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
                    homeController.updateTodo();
                    homeController.chooseTask(null);
                    homeController.editingController.clear();
                  },
                  splashColor: const Color(0xA0FFFFFF),
                  icon: Icon(Icons.close_rounded, color: Colors.black),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 4.0, left: 12.0, right: 12.0),
              child: Row(
                children: [
                  Icon(IconData(task.icon, fontFamily: "MaterialIcons"), color: color),
                  SizedBox(width: 6),
                  Text(task.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
            Obx(() {
              var totalTodos = homeController.doingTodos.length + homeController.doneTodos.length;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Text(totalTodos == 1 ? "$totalTodos Task" : "$totalTodos Tasks",
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14)),
                    SizedBox(width: 48),
                    Expanded(
                        child: StepProgressIndicator(
                      totalSteps: totalTodos == 0 ? 1 : totalTodos,
                      currentStep: homeController.doneTodos.length,
                      padding: 0,
                      selectedGradientColor: LinearGradient(
                          colors: [Colors.white.withAlpha(30), color],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      unselectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.grey[300]!, Colors.grey[300]!],
                      ),
                    ))
                  ],
                ),
              );
            }),
            SizedBox(height: 8),
            Form(
              key: homeController.formKey,
              child: TextFormField(
                style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
                controller: homeController.editingController,
                autofocus: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  hintText: " Note Title",
                  hintStyle: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.check_box_outline_blank_rounded, color: Colors.grey[600])),
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (homeController.formKey.currentState!.validate()) {
                          var success = homeController.addTodo(homeController.editingController.text);
                          if (success) {
                            EasyLoading.showSuccess("Task Added");
                          } else {
                            EasyLoading.showError("Task Not Added");
                          }
                          homeController.editingController.clear();
                        }
                      },
                      icon: Icon(Icons.check_rounded, color: Colors.grey[600])),
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
            DoingList()
          ],
        ),
      ),
    );
  }
}
