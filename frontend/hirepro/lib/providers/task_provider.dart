import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:hirepro/models/pending_task.dart';
import 'package:hirepro/models/task.dart';
import 'package:hirepro/services/api.dart';
import 'package:http/http.dart';

class TaskProvider extends ChangeNotifier {
  bool isLoading = false;
  List<PendingTask> _pendingTasks = [];
  static final TaskProvider _instance = TaskProvider._internal();

  // Private constructor
  TaskProvider._internal();

  // Factory constructor to access the singleton instance
  factory TaskProvider() => _instance;
  late Task _task;
  late String _addedTaskId;

  List<File> _selectedFiles = [];
  List<File> get files => _selectedFiles;
  String get addedTaskId => _addedTaskId;
   List<Task> _ongoingTasks = [];
  List<PendingTask> get pendingTasks => _pendingTasks;
 List<Task> get ongoingTasks => _ongoingTasks;
  void setAddedTaskId(id) {
    _addedTaskId = id;
  }

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
      _task.date = DateTime.now().toString();
      _task.postedtime = TimeOfDay.now().toString();
    }

    notifyListeners();
  }

  Future<void> addLawnMowingTask() async {
    Response response = await api.addLawnMowingTask(
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
    Map<String, dynamic> responseObject = jsonDecode(response.body);
    _addedTaskId = responseObject['serviceid'];
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

  Future<void> uploadFile() async {
    if (_selectedFiles.isEmpty) {
      print('no file selected');
      return;
    }

    try {
      for (var file in _selectedFiles) {
        final storageRef = firebase_storage.FirebaseStorage.instance.ref().child(
            'task_images/${taskCategory}_${addedTaskId}_${file.hashCode}.png');
        await storageRef.putFile(file);
      }
    } catch (error) {
      print('Error uploading file: $error');
    }
  }

  Future<void> getPendingTasks() async {
    isLoading = true;
    notifyListeners();
    final response = await api.getPendingTasks(Client());
    _pendingTasks = response;
    print(_pendingTasks.length);
    isLoading = false;
    notifyListeners();
  }

  Future<void> getOngoingTasks() async {
    isLoading = true;
    notifyListeners();
    final response = await api.fetchTasks(Client());
    _ongoingTasks = response;
    print(_pendingTasks.length);
    isLoading = false;
    notifyListeners();
  }
}
