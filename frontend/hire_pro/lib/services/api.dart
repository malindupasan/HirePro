import 'dart:convert';
import 'dart:io';
import 'package:hire_pro/models/customer.dart';
import 'package:hire_pro/services/routes.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<Customer> getData() async {
    final response = await http.get(
      Uri.parse(url + 'getdata'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
    );
    try {
      if (response.statusCode == 200) {
        return await Customer.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load customer');
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<Customer> changeName(String name) async {
    final response = await http.post(
      Uri.parse(url + 'changename'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'name': name, 'id': id}),
    );

    if (response.statusCode == 201) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to change name');
    }
  }
}
