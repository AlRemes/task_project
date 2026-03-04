import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class StatisticsScreen extends StatelessWidget {
  StatisticsScreen({super.key});

  final controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Statistics")),
      body: Obx(() {
        final total = controller.tasks.length;
        final completed = controller.tasks.where((t) => t.completed).length;
        final pending = total - completed;
        final percent = total == 0 ? 0 : ((completed / total) * 100).round();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total tasks: $total", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Text("Completed tasks: $completed", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Text("Pending tasks: $pending", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Text("Completion: $percent%", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 24),
              LinearProgressIndicator(
                value: total == 0 ? 0 : completed / total,
                minHeight: 10,
              ),
            ],
          ),
        );
      }),
    );
  }
}