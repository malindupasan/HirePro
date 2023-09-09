import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/models/task.dart';
import 'package:hire_pro/services/api.dart';

class TaskProvider extends ChangeNotifier {
  late Task _task;
  List<File> _selectedFiles = [];
  List<File> get files => _selectedFiles;
  Api api = Api();
  void initialize() {
    _task = Task(
        description: '',
        estmax: '',
        estmin: '',
        location: '',
        latitude: '',
        longitude: '');
  }

  Task get taskData => _task;
  String taskCategory = '';
  void updateCategory(String category) {
    taskCategory = category;
    notifyListeners();
  }

  void createLawnMowingTask(
      String area,
      String description,
      String location,
      String min,
      String max,
      String latitude,
      String longitude,
      String date,
      String postedtime,
      bool isSchedule) {
    _task.area = area;
    _task.description = description;
    _task.location = location;
    _task.estmin = min;
    _task.estmax = max;
    _task.latitude = latitude;
    _task.longitude = longitude;
    if (isSchedule) {
      _task.date = date;
      _task.postedtime = postedtime;
    } else {
      _task.date = null;
      _task.postedtime = null;
    }

    notifyListeners();
  }

  void addLawnMowingTask() {
    api.addLawnMowingTask(
        _task.area,
        _task.description,
        _task.postedtime,
        _task.estmin,
        _task.estmax,
        _task.location,
        _task.date,
        _task.latitude,
        _task.longitude);
    notifyListeners();
  }

  void openFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      _selectedFiles = result.paths.map((path) => File(path!)).toList();
      notifyListeners();
    } else {}
  }

  void resetFiles() {
    _selectedFiles = [];
  }
}
