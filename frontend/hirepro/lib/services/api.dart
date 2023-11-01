import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hirepro/models/address.dart';
import 'package:hirepro/models/bids.dart';
import 'package:hirepro/models/customer.dart';
import 'package:hirepro/env.dart';
import 'package:hirepro/models/pending_task.dart';
import 'package:hirepro/models/service_provider.dart';
import 'package:hirepro/models/task.dart';
import 'package:hirepro/widgets/MyNavigationWidget.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';

class Api {
  Future<http.Response> signup(
    name,
    phone,
    email,
    password,
  ) async {
    final response = await http.post(
      Uri.parse(url + 'register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'contact': phone,
        'password': password
      }),
    );

    if (response.statusCode == 200) {
      // return Customer.fromJson(jsonDecode(response.body));
      print("data sent");
      return response;
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<http.Response> sendCode(code, id) async {
    final response = await http.post(
      Uri.parse(url + 'saveotp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'otp': code.toString(),
        'customerid': id.toString()
      }),
    );

    if (response.statusCode == 200) {
      // return Customer.fromJson(jsonDecode(response.body));
      print("code sent");
      return response;
    } else {
      throw Exception('Failed to send code');
    }
  }

  Future<bool> checkCode(code, id) async {
    final response = await http.post(
      Uri.parse(url + 'checkotp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'otp': code.toString(),
        'customerid': id.toString()
      }),
    );

    if (response.statusCode == 200) {
      // return Customer.fromJson(jsonDecode(response.body));
      print("code correct");
      return true;
    } else {
      print(response.statusCode);
      print('Code incorrect');
      return false;
    }
  }

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

  Future<bool> addAddress(
    title,
    address,
    latitude,
    longitude,
  ) async {
    final response = await http.post(
      Uri.parse(url + 'addaddress'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'address': address,
        'latitude': latitude,
        'longitude': longitude
      }),
    );

    if (response.statusCode == 201) {
      // return Customer.fromJson(jsonDecode(response.body));
      print("data sent");
      return true;
    } else {
      throw Exception('Failed to request task');
    }
  }

  Future<http.Response> addLawnMowingTask(area, description, time, min, max,
      location, date, latitude, longitude) async {
    final response = await http.post(
      Uri.parse(url + 'addlawnmovingtask'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
      body: jsonEncode(<String, String>{
        'area': area,
        'description': description,
        'postedtime':
            date.split(' ')[0] + ' ' + time.split('(')[1].split(')')[0] + ":00",
        'estmin': min,
        'estmax': max,
        'location': location,
        'date': date.toString().split(' ')[0],
        'latitude': latitude,
        'longitude': longitude
      }),
    );

    if (response.statusCode == 200) {
      // return Customer.fromJson(jsonDecode(response.body));
      print("data sent");

      return response;
    } else {
      throw Exception('Failed to request task');
    }
  }
//----getting bids data

  Future<List<Bids>> fetchBids(http.Client client, id) async {
    final response = await client.post(
      Uri.parse(url + 'getbids'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
      body: jsonEncode(<String, String>{'serviceid': id}),
    );
    if (response.statusCode == 200) {
      print('Data received');
      // print(response.body);
    }

    return compute(parseBids, response.body);
  }

  List<Bids> parseBids(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Bids>((json) => Bids.fromJson(json)).toList();
  }

//----------------login
  void loginUser(
      emailController, passwordController, preferences, context) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      var response = await http.post(Uri.parse(login),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      try {
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
        }
      } catch (e) {
        print("Wrong credentials");
      }
    }
  }

  //get service provider details
  Future<ServiceProvider> getServiceProviderData(serviceProviderId) async {
    final response = await http.post(
      Uri.parse(url + 'getspdetails'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
      body:
          jsonEncode(<String, String>{'serviceProviderId': serviceProviderId}),
    );
    try {
      if (response.statusCode == 200) {
        return await ServiceProvider.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load service provider');
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<List<PendingTask>> getPendingTasks(http.Client client) async {
    final response = await client.get(
      Uri.parse(url + 'getpendingtasks'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
    );

    return compute(parsePendingTasks, response.body);
  }

  List<PendingTask> parsePendingTasks(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<PendingTask>((json) => PendingTask.fromJson(json))
        .toList();
  }

  //----------accept bid--------------------------------
  Future<http.Response> acceptbid(serviceid) async {
    final response = await http.post(
      Uri.parse(url + 'acceptbid'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
      body: jsonEncode(<String, String>{
        'serviceid': serviceid,
      }),
    );

    if (response.statusCode == 200) {
      // return Customer.fromJson(jsonDecode(response.body));
      print("bid accpeted");
      return response;
    } else {
      throw Exception('Cannot proceed');
    }
  }

  //-------------get ongoing tasks --------------------------------
  Future<List<Task>> fetchTasks(http.Client client) async {
    final response = await client.get(
      Uri.parse(url + 'getOngoingandAcceptedTasks'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
    );
    if (response.statusCode == 200) {
      print('Ongoing tasks received');
      // print(response.body);
    }

    return compute(parseTasks, response.body);
  }

  List<Task> parseTasks(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Task>((json) => Task.fromJson(json)).toList();
  }
  // -----------------get service status ----------------

  Future<Map<String, dynamic>> getServiceStatus(String serviceId) async {
    final response = await http.post(
      Uri.parse(url + 'getservicestatus'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
      body: jsonEncode(<String, String>{'serviceid': serviceId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(
          'Failed to load service provider. Status Code: ${response.statusCode}');
      throw Exception('Failed to load service provider');
    }
  }

  // -------------------get sp location--------------------------------------
  Future<Map<String, dynamic>> getSpLocation(String serviceId) async {
    final response = await http.post(
      Uri.parse(url + 'getsplocation'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sesstionToken',
      },
      body: jsonEncode(<String, String>{'serviceid': serviceId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(
          'Failed to load service provider. Status Code: ${response.statusCode}');
      throw Exception('Failed to load service provider');
    }
  }
}
