import 'package:flutter/material.dart';
import 'package:hire_pro/models/customer.dart';
import 'package:hire_pro/services/api.dart';

class CustomerProvider extends ChangeNotifier {
   Customer? _customer;
  bool isLoading = false;
  Api api = Api();

  Customer? get customerData => _customer!;
  Future<void> getCustomerData() async {
    isLoading = true;
    notifyListeners();
    final response = await api.getData(); 
    _customer = response;
    isLoading = false;
    notifyListeners();
  }

  void changeName(String name) async {
    isLoading = true;
    notifyListeners();
    _customer?.name = name;
    await api.changeName(name);
    isLoading = false;
    notifyListeners();
  }

}
