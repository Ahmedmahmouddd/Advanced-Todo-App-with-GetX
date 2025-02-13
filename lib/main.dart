import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_x/app/core/notification_service/notification_service.dart';
import 'package:get_x/app/data/services/storage/services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get_x/app/modules/home/binding.dart';
import 'package:get_x/app/modules/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotifications();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(DevicePreview(
    enabled: false,
    backgroundColor: Colors.white,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'poppins'),
      title: 'Todo List using GetX',
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      home: HomePage(),
      builder: (context, child) {
        return DevicePreview.appBuilder(context, EasyLoading.init()(context, child));
      },
    );
  }
}
