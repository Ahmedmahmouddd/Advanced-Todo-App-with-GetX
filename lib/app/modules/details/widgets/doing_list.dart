import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.doingTodos.isEmpty && homeController.doneTodos.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                "You have no tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[600]),
              ),
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeController.doingTodos
                  .map((element) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                  fillColor: MaterialStateProperty.resolveWith((states) => Colors.grey[100]),
                                  value: element['done'],
                                  onChanged: (value) {
                                    homeController.doneTodo(element['title']);
                                  }),
                            ),
                            SizedBox(width: 6),
                            Text(element['title'],
                                style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis)
                          ],
                        ),
                      ))
                  .toList(),
              if (homeController.doingTodos.isNotEmpty)
                Divider(color: Colors.grey[300], thickness: 2, indent: 20, endIndent: 20),
            ],
          ));
  }
}
