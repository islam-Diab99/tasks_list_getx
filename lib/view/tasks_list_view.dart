import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_app_getx/controllers/task_screen_controller.dart';
import 'package:tasks_app_getx/view/widgets/add_task_input_widget.dart';
import 'package:tasks_app_getx/view/widgets/task_item_card.dart';

class TaskListView extends StatelessWidget {
  final TasksController _controller = Get.put(TasksController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTasksScreenAppBar(),
      body: _buildTasksScreenBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final title = _controller.taskInputController.text.trim();
          if (title.isNotEmpty) {
            _controller.addTask(title);
            _controller.taskInputController.clear();
          }
        },
        backgroundColor: Colors.blueAccent,
        elevation: 5,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }

  Padding _buildTasksScreenBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              return _controller.tasks.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline,
                              size: 80, color: Colors.grey),
                          Text('No tasks',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    )
                  : AnimatedList(
                      initialItemCount: _controller.tasks.length,
                      itemBuilder: (context, index, animation) {
                        final task = _controller.tasks[index];
                        return SizeTransition(
                          sizeFactor: animation,
                          child: TaskItemCard(
                            task: task,
                            controller: _controller,
                            index: index,
                          ),
                        );
                      },
                    );
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: AddTaskInput(
              controller: _controller.taskInputController,
              onAddTask: (title) {
                _controller.addTask(title);
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildTasksScreenAppBar() {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: const Text(
        'Your tasks',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }
}
