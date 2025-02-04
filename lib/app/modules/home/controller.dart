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
  final deleting = false.obs;
  final editingController = TextEditingController();
  final task = Rx<Task?>(null);
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    editingController.dispose();
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

  void changeDeleting(bool value) => deleting.value = value;

  void deletingTask(Task task) {
    tasks.remove(task);
  }

  void chooseTask(Task? selected) {
    task.value = selected;
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containeTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, "done": false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIndex = tasks.indexOf(task);
    tasks[oldIndex] = newTask;
    tasks.refresh();
    return true;
  }

  bool containeTodo(List todos, String title) {
    return todos.any((todo) => todo['title'] == title);
  }
}
