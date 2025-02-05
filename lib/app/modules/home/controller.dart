import 'package:flutter/foundation.dart';
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
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

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

  bool addTodo(String title) {
    var todo = {'title': title, "done": false};
    if (doingTodos.any((test) => mapEquals<String, dynamic>(todo, test))) {
      return false;
    }
    var doneTodo = {'title': title, "done": true};

    if (doneTodos.any((test) => mapEquals<String, dynamic>(doneTodo, test))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodo() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([...doingTodos, ...doneTodos]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    var doingTodo = {'title': title, 'done': false};
    int index = doingTodos.indexWhere((element) => mapEquals<String, dynamic>(doingTodo, element));
    doingTodos.removeAt(index);

    var doneTodo = {'title': title, 'done': true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }

  void deleteDoneTodoItem(dynamic doneTodo) {
    int index = doneTodos.indexWhere((element) => mapEquals<String, dynamic>(doneTodo, element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodoEmpty(Task task) {
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDoneTodo(Task task) {
    return task.todos!.where((element) => element['done'] == true).length;
  }
}
