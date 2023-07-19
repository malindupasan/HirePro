import 'package:flutter/material.dart';

class JobRequestScreen extends StatelessWidget {
  const JobRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Icon(Icons.arrow_back)),
          Text(
            'Enter Task Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              initialValue: 'Default Address',
              decoration: InputDecoration(
                labelText: 'Location',
                // errorText: 'Error message',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusColor: Colors.grey,
                suffixIcon: Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
