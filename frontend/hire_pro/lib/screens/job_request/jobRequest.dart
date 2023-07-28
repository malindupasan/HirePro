import 'package:flutter/material.dart';

class JobRequest {
  List<Widget> _type = <Widget>[
    Text('Just Now'),
    Text('Schedule'),
  ];
  final List<bool> _selectedType = <bool>[false, false];
  bool vertical = false;
  bool isSchedule() {
    if (_selectedType[1]) {
      return true;
    }
    return false;
  }

  void selectJobType(int index) {
    for (int i = 0; i < _selectedType.length; i++) {
      _selectedType[i] = i == index;
    }
  }

  List<bool> selected() {
    return _selectedType;
  }

  List<Widget> type() {
    return _type;
  }
}
