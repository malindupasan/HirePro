import 'package:hirepro/models/bids.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:hirepro/services/api.dart';

class BidsProvider extends ChangeNotifier {
  static final BidsProvider _instance = BidsProvider._internal();

  // Private constructor
  BidsProvider._internal();

  // Factory constructor to access the singleton instance
  factory BidsProvider() => _instance;

  List<Bids> _bids = [];
  Api api = Api();

  List get bids => _bids;
  bool checkBids() {
    if (_bids.isEmpty) {
      return false;
    }
    return true;
  }

  Future<bool> getBids(id) async {
    final response = await api.fetchBids(http.Client(), id);
    _bids = response;
    notifyListeners();
    print("ddd");
    if (response.isNotEmpty) {
      return true;
    }
    return false;
  }
}
