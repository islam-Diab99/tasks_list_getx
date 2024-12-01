import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tasks_app_getx/controllers/task_screen_controller.dart';
import 'package:tasks_app_getx/model/task.dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required TasksController controller, required this.index,
  }) : _controller = controller;

  final Task task;
  final TasksController _controller;
    final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: task.isCompleted
            ? Colors.grey[300]
            : Colors.white,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
              vertical: 16.0, horizontal: 20.0),
          title: Text(
            task.title,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              decoration: task.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: task.isCompleted
                  ? Colors.grey
                  : Colors.black,
            ),
          ),
          trailing: Checkbox(
            value: task.isCompleted,
            onChanged: (_) =>
                _controller.toggleTaskStatus(index),
            activeColor: Colors.blueAccent,
          ),
          onLongPress: () =>
              _controller.deleteTask(index),
        ),
      ),
    );
  }
}
