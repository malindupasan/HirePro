import 'package:hire_pro/constants.dart';
import 'package:hire_pro/models/address.dart';
import 'package:hire_pro/providers/address_provider.dart';
import 'package:hire_pro/widgets/HireProAppBar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hire_pro/widgets/MediumButton.dart';
import 'package:provider/provider.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

// AIzaSyDNOO9bzzNn34HNXZY1xT5IVvOlV37zFuE

class _SetLocationScreenState extends State<SetLocationScreen> {
  late GoogleMapController mapController;

  CameraPosition? cameraPosition;

  // final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final addAddressKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: addAddressKey,
        appBar: HireProAppBar(context, 'Set location'),
        body: Consumer<AddressProvider>(
            builder: (context, addressData, child) => Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Card(
                        child: Stack(
                          children: [
                            GoogleMap(
                              markers: {
                                addressData.mapMarkers.first,
                              },
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(addressData.getLatitude(),
                                    addressData.getLongitude()),
                                zoom: 17.5,
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  addressData.searchLocation(
                                      context,
                                      addAddressKey.currentState,
                                      mapController);
                                },
                                child: const Icon(Icons.search)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 249, 238, 201),
                                    child: Icon(
                                      Icons.location_on,
                                      color: kMainYellow,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 300,
                                    color: Colors.white,
                                    child: Text(
                                      addressData.pinAddress,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          MediumButton('Set location', () async {
                            Address address = Address(
                                address: addressData.pinAddress,
                                title: 'temp',
                                latitude: addressData.getLatitude().toString(),
                                longitude:
                                    addressData.getLongitude().toString());
                            addressData.changeSelectedAddress(address);
                            print(addressData.addressStr);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(255, 42, 201, 74),
                                  content: Text('Location set successfully!')),
                            );
                            Navigator.pop(context);
                          }, kMainYellow, Colors.white),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    )
                  ],
                )));
  }
}
