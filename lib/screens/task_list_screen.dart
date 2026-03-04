import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../widgets/responsive_layout.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({super.key});

  final controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Get.toNamed('/stats'),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add'),
        child: const Icon(Icons.add),
      ),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Obx(() {
      if (controller.tasks.isEmpty) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "No tasks yet",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        );
      }

      return ListView.builder(
        itemCount: controller.tasks.length,
        itemBuilder: (context, index) {
          final task = controller.tasks[index];
          return ListTile(
            title: Text(task.title),
            leading: Checkbox(
              value: task.completed,
              onChanged: (_) => controller.toggleTask(task.id),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => controller.deleteTask(task.id),
            ),
            onTap: () {
              if (MediaQuery.of(context).size.width < 600) {
                Get.toNamed('/task/${task.id}');
              } else {
                controller.selectTask(task.id);
              }
            },
          );
        },
      );
    });
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: _buildMobileLayout(context)),
        Expanded(
          flex: 3,
          child: Obx(() {
            final id = controller.selectedTaskId.value;

            if (id == null) {
              return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    "Select a task to view details",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              );
            }

            final task = controller.getTask(id);
            if (task == null) {
              return const Center(child: Text("Task not found"));
            }

            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Text("Completed: ${task.completed}"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.toggleTask(task.id),
                    child: const Text("Toggle completion"),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: _buildTabletLayout(context),
      ),
    );
  }
}
