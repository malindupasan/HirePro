import 'package:flutter/material.dart';
import 'package:hire_pro/models/address.dart';
import 'package:hire_pro/services/api.dart';
import 'package:http/http.dart' as http;

class AddressProvider extends ChangeNotifier {
  List<Address> _addressList = [];
  bool isLoading = false;
  Api api = Api();

  List<Address> get addresses => _addressList;

  Future<void> getAllAddresses() async {
    isLoading = true;
    notifyListeners();
    final response = await api.fetchAddresses(http.Client());
    _addressList = response;
    isLoading = false;
    notifyListeners();
  }
}
