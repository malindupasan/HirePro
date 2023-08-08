import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'http://192.168.164.1:3000/';
  static getUser() async {
    try {
      final res = await http.get(Uri.parse(baseUrl + 'changename'));
      if (res.statusCode == 200) {
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }
}
