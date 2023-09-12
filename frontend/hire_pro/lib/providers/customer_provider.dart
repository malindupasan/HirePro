import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_pro/models/customer.dart';
import 'package:hire_pro/services/api.dart';
import 'package:http/http.dart';

class CustomerProvider extends ChangeNotifier {
  Customer? _customer;
  bool isLoading = false;
  Api api = Api();
  int _code = 0;
  String? _signupId = null;

  Customer? get customerData => _customer!;
  int get verificationCode => _code;
  String get signupId => _signupId!;

  Future<bool> register(name, email, phone, password) async {
    bool status = false;
    Response response = await api.signup(name, phone, email, password);
    Map<String, dynamic> responseObject = jsonDecode(response.body);
    _signupId = responseObject['id'];
    notifyListeners();
    print(signupId);
    if (response.statusCode == 200) {
      status = true;
    }
    return status;
  }

  Future<bool> sendVerifyCode(code, id) async {
    bool val = false;
    Response response = await api.sendCode(code, id);

    notifyListeners();
    if (response.statusCode == 200) {
      print('code sent');
      val = true;
    }
    return val;
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
