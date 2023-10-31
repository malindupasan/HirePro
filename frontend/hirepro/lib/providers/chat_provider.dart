import 'package:flutter/foundation.dart';

class ChatProvider extends ChangeNotifier {
  String _serviceProviderName = '';
  String _serviceId = '';
  String _serviceProviderId = '';
  String _userId = '';
  String get serviceId => _serviceId;
  String get serviceProviderId => _serviceProviderId;
  String get userId => _userId;
  String get serviceProName=>_serviceProviderName;
  void initializeData(serviceid, serviceProid, userid) {
    _serviceId = serviceid;
    _serviceProviderId = serviceProid;
    _userId = userid;
    notifyListeners();
  }

  void setServiceProviderName(name) {
    _serviceProviderName = name;
    notifyListeners();
  }
}
