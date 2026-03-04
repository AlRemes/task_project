import 'package:get/get.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import 'package:uuid/uuid.dart';

class TaskController extends GetxController {
  final service = Get.find<TaskService>();
  final tasks = <Task>[].obs;

  @override
  void onInit() {
    tasks.value = service.loadTasks();
    super.onInit();
  }

  void addTask(String title) {
    final task = Task(id: const Uuid().v4(), title: title);
    tasks.add(task);
    service.saveTasks(tasks);
  }

  void deleteTask(String id) {
    tasks.removeWhere((t) => t.id == id);

    if (selectedTaskId.value == id) {
      selectedTaskId.value = null; // clear selection for continuation
    }

    service.saveTasks(tasks);
  }

  final selectedTaskId = RxnString();

  void selectTask(String id) {
    selectedTaskId.value = id;
  }

  void toggleTask(String id) {
    final index = tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      tasks[index].completed = !tasks[index].completed;
      tasks.refresh();
      service.saveTasks(tasks);
    }
  }

  Task? getTask(String id) {
    return tasks.firstWhereOrNull((t) => t.id == id);
  }
}
