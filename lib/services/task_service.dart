import 'package:hive_ce_flutter/hive_flutter.dart';
import '../models/task.dart';

class TaskService {
  final box = Hive.box("storage");

  List<Task> loadTasks() {
    if (!box.containsKey('tasks')) return [];
    final raw = box.get('tasks') as List;
    return raw.map((e) => Task.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  void saveTasks(List<Task> tasks) {
    box.put('tasks', tasks.map((t) => t.toJson()).toList());
  }
}