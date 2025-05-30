import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title = "";
  @HiveField(1)
  String desc = "";
  @HiveField(2)
  String category = "";
  @HiveField(3)
  String time = "${TimeOfDay.now().hour} : ${TimeOfDay.now().minute}";
  @HiveField(4)
  String date = DateTime.now().toString().split(" ")[0];
  @HiveField(5)
  bool isDone = false;
  @HiveField(6)
  String id = '';


  Task() {
    title = "";
    desc = "";
    category = "";
    time = "${TimeOfDay.now().hour} : ${TimeOfDay.now().minute}";
    date = DateTime.now().toString().split(" ")[0];
    isDone = false;
    id = '';
  }
}
