import 'package:flutter/cupertino.dart';

class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static const String registration = '$_baseUrl/Registration';
  static const String signIn = '$_baseUrl/Login';
  static const String addNewTask = '$_baseUrl/createTask';
  static const String newTaskList = '$_baseUrl/listTaskByStatus/New';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static const String progressTask = '$_baseUrl/listTaskByStatus/Progress';
  static const String cancelTask = '$_baseUrl/listTaskByStatus/Cancel';
  static const String doneTask = '$_baseUrl/listTaskByStatus/Completed';
}