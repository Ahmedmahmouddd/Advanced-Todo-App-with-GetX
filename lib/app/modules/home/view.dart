import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/app/data/models/task.dart';
import 'package:get_x/app/modules/home/controller.dart';
import 'package:get_x/app/core/utils/extention.dart';
import 'package:get_x/app/modules/home/widgets/add_card.dart';
import 'package:get_x/app/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: ListView(children: [
        Padding(
          padding: EdgeInsets.all(4.0.wp),
          child: Text("My List", style: TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold)),
        ),
        Obx(
          () => GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              // TaskCard(task: Task(title: "title", icon: 0xe071, color: "#CF6081")),
              ...controller.tasks.map((task) => TaskCard(task: task)).toList(),
              AddCard(),
            ],
          ),
        )
      ])),
    );
  }
}
