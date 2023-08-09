import 'dart:convert';
import 'dart:io';
import 'package:hire_pro/models/customer.dart';
import 'package:hire_pro/services/routes.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<Customer> getData() async {
    final response = await http.get(
      Uri.parse('$url.getdata'),
      headers: {
        'Content-Type': 'application/json',
         'Authorization': 'Bearer $sesstionToken',
      },
    );

    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load customer');
    }
  }
}
