import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_x/app/data/services/storage/services.dart';
import 'package:get_x/app/modules/home/binding.dart';
import 'package:get_x/app/modules/home/view.dart';


void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: HomeBinding(),
      title: 'Todo List using GetX',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      builder: EasyLoading.init(),
    );
  }
}
