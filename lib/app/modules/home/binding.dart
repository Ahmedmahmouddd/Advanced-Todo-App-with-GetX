import 'package:get/get.dart';
import 'package:get_x/app/data/providers/task/provider.dart';
import 'package:get_x/app/data/services/storage/repository.dart';
import 'package:get_x/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(taskRepository: TaskRepository(taskProvider: TaskProvider())));
  }
}
