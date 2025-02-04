import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_x/app/core/values/colors.dart';
import 'package:get_x/app/data/models/task.dart';
import 'package:get_x/app/modules/home/controller.dart';
import 'package:get_x/app/modules/home/widgets/add_card.dart';
import 'package:get_x/app/modules/home/widgets/add_dialog_screen.dart';
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
          padding: EdgeInsets.only(right: 24.0, left: 24.0, bottom: 16, top: 8),
          child: Text("My Tasks", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        ),
        Obx(
          () => GridView.count(
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            padding: const EdgeInsets.all(12.0),
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...controller.tasks.map((task) {
                return LongPressDraggable(
                    data: task,
                    onDragStarted: () => controller.changeDeleting(true),
                    onDragEnd: (_) => controller.changeDeleting(false),
                    onDraggableCanceled: (_, __) => controller.changeDeleting(false),
                    feedback: SizedBox(
                      height: MediaQuery.of(context).size.width / 2 - 12,
                      width: MediaQuery.of(context).size.width / 2 - 12,
                      child: Opacity(
                        opacity: 0.8,
                        child: TaskCard(task: task),
                      ),
                    ),
                    child: TaskCard(task: task));
              }),
              AddCard(),
            ],
          ),
        )
      ])),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(() => FloatingActionButton(
              backgroundColor: controller.deleting.value == true ? Colors.red : blue,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(180))),
              onPressed: () {
                if(controller.tasks.isNotEmpty){
                  Get.to(() => AddDialog(), transition: Transition.downToUp);
                }else{
                  EasyLoading.showInfo("Create a task first by clicking the + button");
                }
              },
              child: controller.deleting.value == true
                  ? Icon(Icons.delete, color: Colors.white)
                  : Icon(Icons.add, color: Colors.white)));
        },
        onAccept: (Task task) {
          controller.deletingTask(task);
          EasyLoading.showSuccess("Task Deleted");
          controller.deleting.value = false;
        },
      ),
    );
  }
}
