import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/app/data/models/task.dart';
import 'package:get_x/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final tasks = <Task>[].obs;
  final chipIndex = 0.obs;
  final editingController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeChipIndex(int value) => chipIndex.value = value;

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    } else {
      tasks.add(task);
      return true;
    }
  }
}
