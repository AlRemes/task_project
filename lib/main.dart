import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'controllers/task_controller.dart';
import 'services/task_service.dart';
import 'screens/task_list_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/task_detail_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("storage");

  Get.lazyPut<TaskService>(() => TaskService());
  Get.lazyPut<TaskController>(() => TaskController());

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => TaskListScreen()),
      GetPage(name: '/stats', page: () => StatisticsScreen()),
      GetPage(name: '/add', page: () => AddTaskScreen()),
      GetPage(name: '/task/:id', page: () => TaskDetailScreen()),
    ],
  ));
}