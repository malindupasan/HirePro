import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hirepro/providers/location_provider.dart';
import 'package:hirepro/services/googleMaps.dart';
import 'package:hirepro/widgets/HireProAppBar.dart';
import 'package:hirepro/widgets/loading.dart';
import 'package:provider/provider.dart';

class ServiceProviderArrivalScreen extends StatelessWidget {
  const ServiceProviderArrivalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Provider.of<LocationProvider>(context, listen: false)
          .getCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
            appBar: HireProAppBar(context, "Arrival in progress"),
            body: SingleChildScrollView(
              child: Consumer<LocationProvider>(
                  builder: (context, location, child) =>
                      (Container(height: 500, child: GoogleMaps()))),
            ),
          );
        }
      },
    );
  }
}
