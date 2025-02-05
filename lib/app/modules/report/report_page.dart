import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/app/core/values/colors.dart';
import 'package:get_x/app/modules/home/controller.dart';
import 'package:get_x/app/modules/report/widgets/report_row_widget.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReportPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(child: Obx(() {
          var createdTasks = homeController.getTotalTasks();
          var completedTasks = homeController.getTotalDoneTasks();
          var liveTasks = createdTasks - completedTasks;
          var percent = (completedTasks / createdTasks * 100).toStringAsFixed(0);
          return ListView(
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 24.0, left: 24.0, bottom: 12, top: 8),
                  child: Text("My Report", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
              Padding(
                  padding: EdgeInsets.only(right: 16.0, left: 24.0, bottom: 12),
                  child: Text(DateFormat.yMMMMd().format(DateTime.now()))),
              Divider(indent: 48, endIndent: 48, thickness: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReportWidget(color: blue, number: liveTasks, title: 'Live Tasks'),
                    ReportWidget(color: green, number: completedTasks, title: 'Completed'),
                    ReportWidget(color: deepPink, number: createdTasks, title: 'Created'),
                  ],
                ),
              ),
              SizedBox(height: 32),
              UnconstrainedBox(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width / 1.35,
                  width: MediaQuery.of(context).size.width / 1.35,
                  child: CircularStepProgressIndicator(
                    totalSteps: createdTasks == 0 ? 1 : createdTasks,
                    currentStep: completedTasks,
                    stepSize: 20,
                    selectedColor: green,
                    unselectedColor: Colors.grey[300],
                    padding: 0,
                    width: 150,
                    height: 150,
                    selectedStepSize: 22,
                    roundedCap: (_, __) => true,
                    child: Center(
                      child: Text("$percent %",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.grey[600],
                          )),
                    ),
                  ),
                ),
              )
            ],
          );
        })));
  }
}
