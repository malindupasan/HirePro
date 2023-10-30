import 'package:flutter/material.dart';
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
                  builder: (context, location, child) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (Container(child: GoogleMaps())),
                          Container(
                            height: 130,
                            decoration: BoxDecoration(
                                color:
                                    const Color.fromARGB(255, 253, 241, 197)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                FilledButton.icon(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/work_in_progress');
                                    },
                                    icon: Icon(Icons.call),
                                    label: Text("Contact")),
                                FilledButton.icon(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/chat_screen');
                                    },
                                    icon: Icon(Icons.message),
                                    label: Text("Message")),
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          )
                        ],
                      )),
            ),
          );
        }
      },
    );
  }
}
