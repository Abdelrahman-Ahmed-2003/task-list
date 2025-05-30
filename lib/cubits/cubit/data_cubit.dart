import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_list/core/buildTask/task.dart';
import 'package:task_list/core/notification/localNorification.dart';
import 'package:task_list/core/utils/utils.dart';
part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());
  final Box<Task> box = Hive.box<Task>("task_box");
  List<Task> data = [];
  List<Task> filteredList = [];
  String category = "";
  int editIndex = -1;
  Task? editingTask;

  getTasks() {
    data = box.values.toList();
  }

  void fetchFilteredTasks(String filterName, String filter) {
    filteredList = [];
    if (filterName != "") {
      if (filterName == "category") {
        category = filter;
        filteredList =
            data.where((element) => element.category == filter).toList();
      } else if (filterName == "date") {
        filteredList = data.where((element) => element.date == filter).toList();
      }
    }
    filteredList.sort((a, b) {
      // Convert strings to DateTime objects
      DateTime timeA = convertToDateTime(a.time);
      DateTime timeB = convertToDateTime(b.time);

      // Sort in descending order
      return timeA.compareTo(timeB);
    });
  }

  Future<void> addTask(Task task) async {
    debugPrint("add task");
    data.add(task);
    await box.add(task);
    await LocalNotification.scheduleNotificationForTask(task);
    debugPrint("task added: ${task.title}");
    emit(DataAdded());
  }

  void setEditingTask(Task? task) {
    editingTask = task;
    // emit(DataUpdated());
  }

  void clearEditingTask() {
    editingTask = null;
    editIndex = -1;
    // emit(DataUpdated());
  }

  void editTask(Task task) {
    if (editIndex != -1) {
      data[editIndex] = task;
      box.putAt(editIndex, task);
      LocalNotification.cancelNotification(task.id.hashCode);
      LocalNotification.scheduleNotificationForTask(task);    // emit(DataUpdated());
    }
    emit(DataUpdated());
  }

  void deleteTask(int index) {
    debugPrint("delete task" + index.toString());
    debugPrint("delete task filteredList length: ${filteredList.length}");
    for (var task in filteredList) {
      debugPrint("delete task: ${task.title}");
    }
    debugPrint("delete task main data length: ${data.length}");
    for (var task in data) {
      debugPrint("delete task main data: ${task.title}");
    }
    Task taskToDelete = filteredList[index];
    int mainIndex = data.indexWhere((task) =>
        task.id == taskToDelete.id);
    debugPrint("delete task mainIndex: $mainIndex");

    if (mainIndex != -1) {
      // Cancel notification before deleting
      LocalNotification.cancelNotification(taskToDelete.hashCode);

      data.removeAt(mainIndex);
      // filteredList.removeAt(index);
      box.deleteAt(mainIndex);
      emit(DataUpdated());
    }
  }

  void removeByCategory(String category) {
    data.removeWhere((element) => element.category == category);
    box.values.toList().removeWhere((element) => element.category == category);
    emit(DataRemove());
  }

  bool isTaskByCategory(String category) {
    return data.any((element) => element.category == category);
  }

  void updateStateOfTask(int index, bool? value) {
    debugPrint("updateStateOfTask: $index");
    Task taskToUpdate = filteredList[index];
    int mainIndex = data.indexWhere((task) =>
        task.id == taskToUpdate.id);

    if (mainIndex != -1) {
      data[mainIndex].isDone = value ?? false;
      box.putAt(mainIndex, data[mainIndex]);
      emit(DataUpdated());
    }
  }

  bool tasksinSameTime(String date, String time) {
    data.where((element) {
      if (element.date == date && element.time == time) {
        return true;
      }
      return false;
    });
    return false;
  }

  Future<void> transferPendingTasks() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Check tasks
    for(int i =0; i < data.length; i++) {
      DateTime taskDate = DateTime.parse(data[i].date);
      if (taskDate.isBefore(today) && !data[i].isDone) {
        data[i].date = today.toString().split(" ")[0];
        LocalNotification.cancelNotification(data[i].id.hashCode);
        LocalNotification.scheduleNotificationForTask(data[i]);
        box.putAt(i, data[i]);
      }
    }
    // emit(DataTransfer());
  }
}
