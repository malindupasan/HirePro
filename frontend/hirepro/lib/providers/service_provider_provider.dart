import 'package:flutter/material.dart';
import 'package:hirepro/models/service_provider.dart';
import 'package:hirepro/services/api.dart';

class ServiceProviderProvider extends ChangeNotifier {
  late ServiceProvider _serviceProvider;
  Api api = Api();
  ServiceProvider get serviceProviderData => _serviceProvider;
  bool isLoading = false;
  Future<bool> getServiceProviderDetails(serviceProviderId) async {
    final response = await api.getServiceProviderData(serviceProviderId);
    _serviceProvider = response;

    if (response.id.isNotEmpty) {
      print(response.id);
      return true;
    }
    return false;
  }
}
