import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_x/app/core/utils/keys.dart';
import 'package:get_x/app/data/models/task.dart';
import 'package:get_x/app/data/services/storage/services.dart';

class TaskProvider {
  StorageService storageService = Get.find<StorageService>();
  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(storageService.read(taskKey).toString()).forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTask(List<Task> tasks) {
    storageService.write(taskKey, jsonEncode(tasks));
  }
}
