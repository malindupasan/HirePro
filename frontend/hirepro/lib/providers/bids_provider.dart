import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hirepro/models/bids.dart';
import 'package:hirepro/services/notifications.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:hirepro/services/api.dart';

class BidsProvider extends ChangeNotifier {
  Notifications notification = Notifications();

  Timer? _timer;
  // Private constructor

  // Factory constructor to access the singleton instance

  List<Bids> _bids = [];
  List<Bids> filteredBids = [];
  Set<String> bidId = Set();
  Set<String> bidIdAll = Set();
  Api api = Api();

  List get bids => _bids;
  bool checkBids() {
    if (_bids.isEmpty) {
      return false;
    }

    return true;
  }

  void reset() {
    filteredBids = [];
    bidId = {};
    notifyListeners();
  }

  List<Bids> getFilteredBids(id) {
    for (Bids bid in _bids) {
      int size = bidId.length;
      if (bid.serviceId == id) {
        bidId.add(bid.bidId);
        if (size < bidId.length) {
          filteredBids.add(bid);
        }
      }
    }
    Future.microtask(() {
      notifyListeners();
    });

    return filteredBids;
  }

  Future<bool> getBids(id) async {
    //initialize notification
    Notifications.initializeNotification();
    //get notifications api call
    final response = await api.fetchBids(http.Client(), id);
    int allbids = bidIdAll.length;
    //check for new bids
    for (Bids bid in response) {
      bidIdAll.add(bid.bidId);
    }
    //if new bids exist
    if (allbids < bidIdAll.length) {
      print('new bids');
      await notification.showNotification(
        title: 'HirePro',
        body: "Your task has new bids!",
      );
    }
    _bids = response;
    notifyListeners();
    //if bids exist
    if (response.isNotEmpty) {
      print('done');
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
