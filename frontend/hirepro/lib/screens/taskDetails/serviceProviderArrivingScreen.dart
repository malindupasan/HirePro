import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hirepro/providers/chat_provider.dart';
import 'package:hirepro/providers/customer_provider.dart';
import 'package:hirepro/providers/location_provider.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/services/googleMaps.dart';
import 'package:hirepro/widgets/HireProAppBar.dart';
import 'package:hirepro/widgets/loading.dart';
import 'package:provider/provider.dart';

class ServiceProviderArrivalScreen extends StatelessWidget {
  const ServiceProviderArrivalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic id = ModalRoute.of(context)!.settings.arguments;
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
                            height: 100,
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
                                    onPressed: () async {
                                      // Navigator.pushNamed(
                                      //     context, '/work_in_progress');
                                      await FlutterPhoneDirectCaller.callNumber(
                                          '0769140040');
                                    },
                                    icon: Icon(Icons.call),
                                    label: Text("Contact")),
                                FilledButton.icon(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/chat_screen',
                                      );
                                    },
                                    icon: Icon(Icons.message),
                                    label: Text("Message")),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Consumer<TaskProvider>(
                              builder: (context, value, child) => Column(
                                    children: [
                                      if (value.taskData.status! == 'arrived')
                                        Container(
                                          width: double.infinity,
                                          color: const Color.fromARGB(
                                              255, 253, 241, 197),
                                          child: Column(
                                            children: [
                                              const Text(
                                                  "Service Provider has arrived! Click continue"),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        '/work_in_progress',arguments: id);
                                                  },
                                                  child: Text("Continue")),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ))
                        ],
                      )),
            ),
          );
        }
      },
    );
  }
}
