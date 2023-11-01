import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();
  late Marker sourceMarker;
  late Marker destinationMarker;
  late Position _currentPosition;
  late StreamSubscription<Position> _positionStream;
  late String duration = "";
  late double distance = 0;

  static LatLng sourceLocation = LatLng(0.0, 0.0);
  static const LatLng destinationLocation = LatLng(6.8940, 79.8547);

  List<LatLng> polylineCoordinates = [];

  PolylinePoints polylinePoints = PolylinePoints();

  Future<void> getCurrentPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      sourceLocation =
          LatLng(_currentPosition.latitude, _currentPosition.longitude);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> _initializeMap() async {
    await getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _initializeMap();

    const locationUpdateInterval = Duration(seconds: 10);
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      setState(() {
        _currentPosition = position;
        sourceLocation = LatLng(position.latitude, position.longitude);
      });
      drawPolyline();
      fetchStats();
    });
  }

  @override
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }

  void drawPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDNOO9bzzNn34HNXZY1xT5IVvOlV37zFuE',
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );

    polylineCoordinates.clear();
    if (result.status == "OK") {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  LatLngBounds calculateLatLngBounds(List<LatLng> coordinates) {
    double minLat = double.infinity;
    double minLng = double.infinity;
    double maxLat = -double.infinity;
    double maxLng = -double.infinity;

    for (LatLng coordinate in coordinates) {
      if (coordinate.latitude < minLat) minLat = coordinate.latitude;
      if (coordinate.latitude > maxLat) maxLat = coordinate.latitude;
      if (coordinate.longitude < minLng) minLng = coordinate.longitude;
      if (coordinate.longitude > maxLng) maxLng = coordinate.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  Future<void> fetchStats() async {
    final slat = sourceLocation.latitude;
    final slon = sourceLocation.longitude;
    final dlat = destinationLocation.latitude;
    final dlon = destinationLocation.longitude;
    final apiKey = "AIzaSyDNOO9bzzNn34HNXZY1xT5IVvOlV37zFuE";

    final url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?origins=$slat,$slon&destinations=$dlat,$dlon&units=imperial&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final durationText = data["rows"][0]["elements"][0]["duration"]["text"];
      final distanceText = data["rows"][0]["elements"][0]["distance"]["text"];
      setState(() {
        duration = durationText;
        final double distanceMiles =
            double.parse(distanceText.replaceAll(" mi", ""));
        distance = distanceMiles * 1.60934;
      });
    } else {
      setState(() {
        duration = "Error: ${response.statusCode}";
      });
    }
  }

  void _fitBoundsToPolyline(GoogleMapController controller) {
    if (polylineCoordinates.isNotEmpty) {
      LatLngBounds bounds = calculateLatLngBounds(polylineCoordinates);
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 50), // Adjust padding as needed
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 550,
        child: Column(children: [
          Column(
            children: <Widget>[
              // Google Map
              Container(
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 202, 202, 202),
                      offset: Offset(0, 1),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: sourceLocation,
                      zoom: 15.5,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      _fitBoundsToPolyline(controller);
                    },
                    markers: <Marker>[
                      Marker(
                        markerId: MarkerId('sourcePin'),
                        position: sourceLocation,
                        icon: BitmapDescriptor.defaultMarkerWithHue(120),
                      ),
                      Marker(
                        markerId: MarkerId('destinationPin'),
                        position: destinationLocation,
                        icon: BitmapDescriptor.defaultMarker,
                      ),
                    ].toSet(),
                    polylines: <Polyline>[
                      Polyline(
                        polylineId: PolylineId('polyline'),
                        color: Colors.blue,
                        points: polylineCoordinates,
                        width: 5,
                      ),
                    ].toSet(),
                  ),
                ),
              ),
              // Information below the map
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Arriving in: " + duration,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Distance: " + distance.toStringAsFixed(3) + " KM",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          )
        ]));
  }
}
