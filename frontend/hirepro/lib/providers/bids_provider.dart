import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hirepro/models/bids.dart';
import 'package:hirepro/services/notifications.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:hirepro/services/api.dart';

class BidsProvider extends ChangeNotifier {
  Notifications notification = Notifications();
  static final BidsProvider _instance = BidsProvider._internal();
  bool isChanged = false;
  Timer? _timer;
  // Private constructor
  BidsProvider._internal();

  // Factory constructor to access the singleton instance
  factory BidsProvider() => _instance;

  List<Bids> _bids = [];
  List<Bids> filteredBids = [];
  Set<int> bidId = Set();
  Api api = Api();

  List get bids => _bids;
  bool checkBids() {
    Notifications.initializeNotification();
    if (_bids.isEmpty) {
      return false;
    }
    if (isChanged) {
      notification.showNotification(
        title: 'HirePro',
        body: "Your task has new bids!",
      );
    }

    return true;
  }

  // List<Bids> getFilteredBids(id) {
  //   for (Bids bid in _bids) {
  //     if (bid.serviceId == id) {
  //       filteredBids.add(bid);
  //     }
  //   }
  //   notifyListeners();
  //   return filteredBids;
  // }

  Future<bool> getBids(id) async {
    final response = await api.fetchBids(http.Client(), id);
    if (_bids.length != response.length) {
      isChanged = true;
      print(isChanged);
      notifyListeners();
    } else {
      isChanged = false;
      notifyListeners();
    }
    //  for (Bids bid in response) {
    //   bidIds.add(int.parse(bid.serviceProId));
    // }

    // if (bidIds.length != bidTracker) {
    //   isChanged = true;
    //   print(isChanged);
    //   notifyListeners();
    // } else {
    //   isChanged = false;
    //   notifyListeners();
    // }
    _bids = response;
    notifyListeners();
    // print("ddd");
    if (response.isNotEmpty) {
      return true;
    }
    return false;
  }

  void startTimer(id) {
    const duration = Duration(seconds: 4);
    _timer = Timer.periodic(duration, (timer) async {
      await getBids(id);
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }
}
