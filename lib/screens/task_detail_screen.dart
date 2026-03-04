import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class TaskDetailScreen extends StatelessWidget {
  final controller = Get.find<TaskController>();

  TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = Get.parameters['id']!;
    final task = controller.getTask(id);

    if (task == null) {
      return Scaffold(
        body: Center(child: Text("Task not found")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Completed: ${task.completed}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.toggleTask(task.id);
              },
              child: const Text("Toggle completion"),
            ),
          ],
        ),
      ),
    );
  }
}