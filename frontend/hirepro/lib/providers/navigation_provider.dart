import 'package:flutter/foundation.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  dynamic changeindex(index) {
    _selectedIndex++;
    notifyListeners();
  }
}
