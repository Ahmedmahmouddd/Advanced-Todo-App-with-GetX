import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/app/core/utils/extention.dart';
import 'package:get_x/app/data/models/task.dart';
import 'package:get_x/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  TaskCard({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey[300]!,
          blurRadius: 7,
          offset: const Offset(0, 7),
        )
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO change after finish todo CRUD
          StepProgressIndicator(
            totalSteps: 5,
            currentStep: 4,
            size: 5,
            padding: 0,
            selectedGradientColor: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withAlpha(25), color],
            ),
            unselectedGradientColor: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.white],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(6.0.wp),
            child: Icon(IconData(task.icon, fontFamily: 'MaterialIcons'), color: color),
          ),
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.all(6.0.wp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                      fontSize: 12.0.sp, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                ),
                Text(
                  "${task.todos?.length ?? 0} tasks",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
