import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadProvider extends ChangeNotifier {
  List<File> _selectedFiles = [];
  bool isLoading = false;

  List<File> get files => _selectedFiles;

  void uploadFiles(List<File> fileList) {
    _selectedFiles = fileList;
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
}
