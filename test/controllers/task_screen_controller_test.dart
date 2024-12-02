import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:tasks_app_getx/controllers/task_screen_controller.dart';
import 'package:tasks_app_getx/model/task.dart';

void main() {
  late TasksController tasksController;
  late Box<Task> tasksBox;

  setUpAll(() async {
    await setUpTestHive();
    Hive.registerAdapter(TaskAdapter()); // Register adapter only once
    tasksBox = await Hive.openBox<Task>('tasks');
  });

  tearDownAll(() async {
    await tearDownTestHive(); // Cleanup after all tests
  });

  setUp(() {
    tasksController = TasksController();
  });

  tearDown(() async {
    await tasksBox.clear(); // Clear tasks after each test
  });

  test('should add a task', () {
    tasksController.addTask('New Task');
    expect(tasksBox.length, 1);
    expect(tasksBox.getAt(0)?.title, 'New Task');
  });

  test('should toggle task completion status', () {
    tasksController.addTask('New Task');
    tasksController.toggleTaskStatus(0);
    expect(tasksBox.getAt(0)?.isCompleted, true);
    tasksController.toggleTaskStatus(0);
    expect(tasksBox.getAt(0)?.isCompleted, false);
  });

  test('should delete a task', () {
    tasksController.addTask('New Task');
    tasksController.deleteTask(0);
    expect(tasksBox.isEmpty, true);
  });

  test('should sort tasks by completion status', () {
    tasksController.addTask('Task 1');
    tasksController.addTask('Task 2');
    tasksController.toggleTaskStatus(0); // Mark Task 1 as completed
    tasksController.toggleTaskStatus(1); // Mark Task 2 as completed

    expect(tasksController.tasks[0].isCompleted, true); // Check if completed tasks are sorted
    expect(tasksController.tasks[1].isCompleted, true);
  });
}
