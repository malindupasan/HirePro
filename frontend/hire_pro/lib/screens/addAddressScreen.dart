import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/HireProAppBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HireProAppBar(context, 'Add new address'),
      body: Column(children: [
        Expanded(child: SingleChildScrollView()),
        Expanded(
          child: Column(children: []),
        )
      ]),
    );
  }
}
