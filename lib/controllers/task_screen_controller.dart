import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tasks_app_getx/model/task.dart';


class TasksController extends GetxController {
  final TextEditingController taskInputController = TextEditingController();
  
   Box<Task> tasksBox = Hive.box('tasks');
  RxList<Task> tasks = <Task>[].obs;


  @override
  void onInit() {
    super.onInit();
    tasks.addAll(tasksBox.values);
       tasks.sort((a, b) {
      if (a.isCompleted == b.isCompleted) return 0;
      return a.isCompleted ? 1 : -1;
    });

  }

  void addTask(String title) {
    final newTask = Task(title: title);
    tasksBox.add(newTask);
    tasks.insert(0, newTask); 
    tasks.refresh(); 
  }

  void toggleTaskStatus(int index) {
    final task = tasks[index];
    task.isCompleted = !task.isCompleted;
    task.save();
        tasks.refresh();

     Future.delayed(Duration(milliseconds:task.isCompleted?1000: 0),(){
   tasks.sort((a, b) {
      if (a.isCompleted == b.isCompleted) return 0;
      return a.isCompleted ? 1 : -1;
    });
     });

 
  }

  void deleteTask(int index) {
    tasks[index].delete();
    tasks.removeAt(index);
    tasks.refresh();
  }

  @override
  void dispose() {
    taskInputController.dispose(); 
    super.dispose();
  }
}
