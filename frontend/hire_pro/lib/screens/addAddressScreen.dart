import 'package:hire_pro/constants.dart';
import 'package:hire_pro/controllers/address_controller.dart';
import 'package:hire_pro/providers/address_provider.dart';
import 'package:hire_pro/widgets/HireProAppBar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hire_pro/widgets/MediumButton.dart';
import 'package:hire_pro/widgets/form_field_new.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

// AIzaSyDNOO9bzzNn34HNXZY1xT5IVvOlV37zFuE

class _AddAddressScreenState extends State<AddAddressScreen> {
  late GoogleMapController mapController;
  TextEditingController title = TextEditingController();
  TextEditingController houseNo = TextEditingController();
  TextEditingController streetName = TextEditingController();
  AddressController addressController = AddressController();
  CameraPosition? cameraPosition;
  final _addressFormKey = GlobalKey<FormState>();
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
        appBar: HireProAppBar(context, 'Add new address'),
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
                      flex: 4,
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
                                      style:const TextStyle(
                                          fontWeight: FontWeight.w400),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Form(
                                key: _addressFormKey,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FormFieldNew(
                                          10, null, 1, "Address Title", title,
                                          (value) {
                                        if (addressController
                                                .addressFieldValidator(value) !=
                                            null) {
                                          return addressController
                                              .addressFieldValidator(value);
                                        }

                                        return null;
                                      }),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: FormFieldNew(
                                                10,
                                                null,
                                                1,
                                                "House Number",
                                                houseNo, (value) {
                                              if (addressController
                                                      .addressFieldValidator(
                                                          value) !=
                                                  null) {
                                                return addressController
                                                    .addressFieldValidator(
                                                        value);
                                              }

                                              return null;
                                            }),
                                          ),
                                          Expanded(
                                            child: FormFieldNew(
                                                10,
                                                null,
                                                1,
                                                "Street Name",
                                                streetName, (value) {
                                              if (addressController
                                                      .addressFieldValidator(
                                                          value) !=
                                                  null) {
                                                return addressController
                                                    .addressFieldValidator(
                                                        value);
                                              }

                                              return null;
                                            }),
                                          ),
                                        ],
                                      ),
                                      MediumButton('Add', () async {
                                        if (_addressFormKey.currentState!
                                            .validate()) {
                                          final address =
                                              Provider.of<AddressProvider>(
                                                  context,
                                                  listen: false);
                                          bool status =
                                              await address.addAddress(
                                                  title.text,
                                                  houseNo.text +
                                                      streetName.text,
                                                  addressData
                                                      .getLatitude()
                                                      .toString(),
                                                  addressData
                                                      .getLongitude()
                                                      .toString());
                                          if (status) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 42, 201, 74),
                                                  content:
                                                      Text('Address added!')),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 255, 161, 161),
                                                  content: Text(
                                                      'Coundn\'t send data!')),
                                            );
                                          }
                                        }
                                      }, kMainYellow, Colors.white)
                                    ])),
                          )
                        ],
                      ),
                    )
                  ],
                )));
  }

// class AddAddressScreen extends StatefulWidget {
//   const AddAddressScreen({super.key});
//
//   @override
//   State<AddAddressScreen> createState() => _AddAddressScreenState();
// }
// AIzaSyDNOO9bzzNn34HNXZY1xT5IVvOlV37zFuE
// class _AddAddressScreenState extends State<AddAddressScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: HireProAppBar(context, 'Add new address'),
//       body: Column(children: [
//         Expanded(child: SingleChildScrollView()),
//         Expanded(
//           child: Column(children: []),
//         )
//       ]),
//     );
//   }
// }
}
