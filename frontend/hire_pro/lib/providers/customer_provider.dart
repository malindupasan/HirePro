import 'package:flutter/material.dart';
import 'package:hire_pro/models/customer.dart';
import 'package:hire_pro/services/api.dart';

class CustomerProvider extends ChangeNotifier {
  Customer? _customer;
  bool isLoading = false;
  Api api = Api();
  int _code = 0;

  Customer? get customerData => _customer!;
  int get verificationCode => _code;

  Future<bool> register(name, email, phone, password) async {
    bool response = await api.signup(name, phone, email, password);
    print(response);
    return response;
  }

  Future<bool> sendVerifyCode(code) async {
    bool response = await api.sendCode(code);
    return response;
  }

  void updateCode(int code) {
    _code = code;
  }

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
