import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  late double _latitude;
  late double _longitude;
  String location = '';
  String get currentLocation => location;
  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    print(permission);
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      _latitude = position.latitude;
      _longitude = position.longitude;

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark address = placemarks[0]; // get only first and closest address
      location =
          "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
