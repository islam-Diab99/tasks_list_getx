import 'package:flutter/material.dart';

class AddTaskInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onAddTask;

  AddTaskInput({
    required this.controller,
    required this.onAddTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Add a new task...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.blueAccent, size: 30),
            onPressed: () {
              final title = controller.text.trim();
              if (title.isNotEmpty) {
                onAddTask(title);
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
