import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hire_pro/env.dart';
import 'package:hire_pro/models/address.dart';
import 'package:hire_pro/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:geocoding/geocoding.dart';

class AddressProvider extends ChangeNotifier {
  List<Address> _addressList = [];
  late Address? _selectedAddress;

  void setSelectedAddress() {
    _selectedAddress = _addressList.first;
    notifyListeners();
  }

  void changeSelectedAddress(Address address) {
    _selectedAddress = address;
    notifyListeners();
  }

  Api api = Api();

  double _latitude = 0;
  double _longitude = 0;
  // double _newlatitude = 0;
  // double _longitude = 0;
  void updateCoordinates(latitude, longitude) {
    _latitude = latitude;
    _longitude = _longitude;
    print(_latitude);
    notifyListeners();
  }

  Prediction? p;
  bool isLoading = false;
  Set<Marker> markers = {};
  String addressStr = '';

  Set<Marker> get mapMarkers => markers;
  List<Address> get addresses => _addressList;
  String get pinAddress => addressStr;
  Address get selectedAddress => _selectedAddress!;

  double getLatitude() {
    return _latitude;
  }

  double getLongitude() {
    return _longitude;
  }

  Future<bool> addAddress(title, address, latitude, longitude) async {
    bool response = await api.addAddress(title, address, latitude, longitude);
    notifyListeners();
    print(response);
    return response;
  }

  void setDefaultAddress() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(_latitude, _longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    addressStr =
        "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
    notifyListeners();
  }

  Future<void> searchLocation(context, ScaffoldState? currentState,
      GoogleMapController mapController) async {
    p = await PlacesAutocomplete.show(
        context: context,
        apiKey: mapApi,
        onError: null,
        mode: Mode.overlay, // or Mode.fullscreen
        language: 'en',
        components: [const Component(Component.country, 'lk')],
        textDecoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white))));
    displayPrediction(currentState, mapController);
  }

  displayPrediction(
      ScaffoldState? currentState, GoogleMapController mapController) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: mapApi,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse details =
        await places.getDetailsByPlaceId(p!.placeId!);
    _latitude = details.result.geometry!.location.lat;
    _longitude = details.result.geometry!.location.lng;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(_latitude, _longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    addressStr =
        "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
    notifyListeners();
    markers.clear();
    markers.add(
      Marker(
          onDrag: (value) {
            _latitude = value.latitude;
            _longitude = value.longitude;
            notifyListeners();
          },
          onDragEnd: (value) async {
            List<Placemark> placemarks =
                await placemarkFromCoordinates(value.latitude, value.longitude);
            Placemark address =
                placemarks[0]; // get only first and closest address
            addressStr =
                "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
            notifyListeners();
          },
          draggable: true,
          markerId: const MarkerId('search_location'),
          position: LatLng(_latitude, _longitude),
          infoWindow: InfoWindow(title: details.result.name)),
    );

    notifyListeners();
    mapController.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(_latitude, _longitude), 15));
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    print(permission);
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      _latitude = position.latitude;
      _longitude = position.longitude;
      setDefaultAddress();
      markers.clear();
      markers.add(Marker(
          infoWindow: const InfoWindow(title: "You're here"),
          draggable: true,
          onDrag: (position) {
            _latitude = position.latitude;
            _longitude = position.longitude;
            notifyListeners();
          },
          onDragEnd: (position) async {
            List<Placemark> placemarks = await placemarkFromCoordinates(
                position.latitude, position.longitude);
            Placemark address =
                placemarks[0]; // get only first and closest address
            addressStr =
                "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
            notifyListeners();
          },
          markerId: const MarkerId('current_location'),
          position: LatLng(_latitude, _longitude), //move to new location
          icon: BitmapDescriptor.defaultMarker));

      print(_latitude);
      print(_longitude);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllAddresses() async {
    isLoading = true;
    notifyListeners();
    final response = await api.fetchAddresses(http.Client());
    _addressList = response;
    isLoading = false;
    notifyListeners();
  }
}
