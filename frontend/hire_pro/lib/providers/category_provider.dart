import 'package:flutter/foundation.dart';
import 'package:hire_pro/models/categories.dart';

class CategoryProvider extends ChangeNotifier {
  Categories category = Categories();
  List<Map<String, String>> _filteredItems = [];
  List<Map<String, String>> get categories {
    if (_filteredItems.isEmpty) {
      _filteredItems = category.getCategories();
    }
    return _filteredItems;
  }

  void filterItems(String searchText) {
    List<Map<String, String>> results = [];
    if (searchText.isEmpty) {
      results = category.getCategories();
    } else {
      results = category
          .getCategories()
          .where((item) =>
              item.keys.first.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    _filteredItems = results;
    print(results.firstOrNull);
    notifyListeners();
  }
}
