import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:hirepro/models/pending_task.dart';
import 'package:hirepro/models/task.dart';
import 'package:hirepro/services/api.dart';
import 'package:hirepro/services/notifications.dart';
import 'package:http/http.dart';

class TaskProvider extends ChangeNotifier {
  Notifications notification = Notifications();
  bool isLoading = false;
  // String _status = 'accepted';
  List<PendingTask> _pendingTasks = [];
  static final TaskProvider _instance = TaskProvider._internal();

  // Private constructor
  TaskProvider._internal();

  // Factory constructor to access the singleton instance
  factory TaskProvider() => _instance;
  late Task _task;
  late String _addedTaskId;
  final Map<dynamic, Timer> _statustimers = {};

  List<File> _selectedFiles = [];
  List<File> get files => _selectedFiles;
  String get addedTaskId => _addedTaskId;
  List<Task> _ongoingTasks = [];
  List<PendingTask> get pendingTasks => _pendingTasks;
  List<Task> get ongoingTasks => _ongoingTasks;
  // String get status => _status;
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
      var index = 0;
      for (var file in _selectedFiles) {
        final storageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('task_images/${addedTaskId}/${index}.png');
        await storageRef.putFile(file);
        index++;
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

  Future<void> getStatus(serviceid) async {
    Notifications.initializeNotification();
    final response = await api.getServiceStatus(serviceid);
    print(response['status']);
    // _status = response['status'];

    if (response['status'] == 'started') {
      notification.showNotification(
          title: 'HirePro',
          body: '[Service provider has started the task #${serviceid}!');
      stopStatusTimer(serviceid);
    }
    notifyListeners();
  }

  void startStatusTimer(id) {
    const duration = Duration(seconds: 5);

    // Cancel the existing timer if it already exists for the same id
    if (_statustimers.containsKey(id) && _statustimers[id] != null) {
      _statustimers[id]!.cancel();
    }

    _statustimers[id] = Timer.periodic(duration, (timer) async {
      print('Status Timer started ${id}');
      await getStatus(id);
    });
  }

  void stopStatusTimer(id) {
    print(id);
    // Check if the timer exists for the given ID before stopping it
    if (_statustimers.containsKey(id) && _statustimers[id] != null) {
      _statustimers[id]!.cancel();
      print('Status Timer stopped ${id}');
      _statustimers.remove(id);
    }
  }
}
