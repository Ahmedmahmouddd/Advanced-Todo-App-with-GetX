import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/app/core/utils/extention.dart';
import 'package:get_x/app/data/models/task.dart';
import 'package:get_x/app/modules/details/details_page.dart';
import 'package:get_x/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  TaskCard({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    var squareWidth = Get.width - 12.0;
    return GestureDetector(
      onTap: () {
        homeController.chooseTask(task);
        homeController.changeTodos(task.todos ?? []);
        Get.to(() => DetailsPage());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 7, offset: const Offset(0, 7))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: homeController.isTodoEmpty(task) ? 1 : task.todos!.length,
              currentStep: homeController.isTodoEmpty(task) ? 0 : homeController.getDoneTodo(task),
              size: 6,
              roundedEdges: Radius.circular(180),
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withAlpha(70), color],
              ),
              unselectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey[300]!, Colors.grey[300]!],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(IconData(task.icon, fontFamily: 'MaterialIcons'), size: 26, color: color),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    task.todos?.length == 1
                        ? "${task.todos?.length} task"
                        : "${task.todos?.length ?? 0} tasks",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
