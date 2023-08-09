import 'dart:convert';

import 'package:hire_pro/models/customer.dart';
import 'package:hire_pro/services/routes.dart';
import 'package:http/http.dart' as http;

class Api {
  late Customer customer;
  static const baseUrl = 'http://192.168.164.1:3000/';
  dynamic getUser() async {
    var url = Uri.parse('${baseUrl}getdata');

    try {
      final res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'authorization': '$sesstionToken'
        },
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        customer.name = data['name'];
         customer.email=data['email'];
        customer.contact=data['contact'] ;
        customer.loyaltyPoints=data['loyalty_points'] ;
        print('success');
        return customer;
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }
}
