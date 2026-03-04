import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class AddTaskScreen extends StatelessWidget {

  AddTaskScreen({super.key});

  final _formKey = GlobalKey<FormBuilderState>();
  final controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'title',
                decoration: const InputDecoration(labelText: "Task title"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final title = _formKey.currentState!.value['title'];
                    controller.addTask(title);
                    Get.back();
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}