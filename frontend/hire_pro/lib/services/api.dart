import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hire_pro/models/address.dart';
import 'package:hire_pro/models/customer.dart';
import 'package:hire_pro/env.dart';
import 'package:hire_pro/screens/job_request/TaskAddScreen.dart';
import 'package:hire_pro/widgets/MyNavigationWidget.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';

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
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
      body: jsonEncode(<String, String>{'name': name, 'id': id}),
    );

    if (response.statusCode == 201) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to change name');
    }
  }

  Future<Customer> changePassword(
      String password, String newPassword, String newPasswordDup) async {
    final response = await http.post(
      Uri.parse(url + 'changepassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
      body: jsonEncode(<String, String>{
        // 'id': id,
        'oldPw': password,
        'password': newPassword,
        'confirmPw': newPasswordDup
      }),
    );

    if (response.statusCode == 201) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to change password');
    }
  }

  Future<List<Address>> fetchAddresses(http.Client client) async {
    final response = await client.get(
      Uri.parse(url + 'getaddress'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
    );

    // Use the compute function to run parseAddresses in a separate isolate.
    return compute(parseAddresses, response.body);
  }

// A function that converts a response body into a List<Address>.
  List<Address> parseAddresses(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Address>((json) => Address.fromJson(json)).toList();
  }

  Future<http.Response> addLawnMowingTask() async {
    final response = await http.post(
      Uri.parse(url + 'addlawnmovingtask'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
      body: jsonEncode(<String, String>{
        'area': formArea!,
        'description': formDescription!,
        'postedtime': calanderDate!.toString().split(' ')[0] +
            ' ' +
            formselectedTime.toString().split('(')[1].split(')')[0] +
            ":00",
        'estmin': formMin!,
        'estmax': formMax!,
        'location': formLocation!,
        'date': calanderDate.toString().split(' ')[0],
        'latitude': ' ',
        'longitude': ' '
      }),
    );

    if (response.statusCode == 201) {
      // return Customer.fromJson(jsonDecode(response.body));
      print("data sent");
      return response;
    } else {
      throw Exception('Failed to request task');
    }
  }

  void loginUser(emailController, passwordController, preferences,context) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      var response = await http.post(Uri.parse(login),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        print(jsonResponse['status']);
        var myToken = jsonResponse['token'];
        sesstionToken = myToken;
        Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(myToken);
        id = jwtDecodedToken['id'];
        preferences.setString('token', myToken);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyNavigationWidget(token: myToken)));
        // Navigator.pushNamed(context, '/category');
      } else {
        print('ggggg');
      }
    }
  }
}
