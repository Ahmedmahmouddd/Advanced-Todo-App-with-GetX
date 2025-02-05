// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/app/core/values/colors.dart';
import 'package:get_x/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Obx(() => homeController.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                  child: Text(
                    'Completed(${homeController.doneTodos.length})',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                ...homeController.doneTodos.map(
                  (element) => Dismissible(
                    key: ObjectKey(element),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => homeController.deleteDoneTodoItem(element),
                    background: Container(
                      color: Colors.red.withOpacity(0.8),
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(padding: const EdgeInsets.all(4.0), child: Icon(Icons.done, color: green)),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            element['title'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(decoration: TextDecoration.lineThrough),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          : Container()),
    );
  }
}
