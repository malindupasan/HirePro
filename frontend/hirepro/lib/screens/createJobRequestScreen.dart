import 'package:flutter/material.dart';

class CreateJobRequestScreen extends StatefulWidget {
  @override
  _CreateJobRequestScreenState createState() => _CreateJobRequestScreenState();
}

class _CreateJobRequestScreenState extends State<CreateJobRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  late String location;
  late DateTime planSchedule = DateTime.now();
  late String description;
  late bool goodsProvided = false;
  late double estimateMin;
  late double estimateMax;
  List<String> photos = [];

  // void _submitForm() {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //     // Perform form submission logic here
  //     print('Location: $location');
  //     print('Plan Schedule: $planSchedule');
  //     print('Description: $description');
  //     print('Goods Provided: $goodsProvided');
  //     print('Estimate Min: $estimateMin');
  //     print('Estimate Max: $estimateMax');
  //     print('Photos: $photos');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.location_on),
                ),
                // onSaved: (value) => location = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Plan Schedule',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      planSchedule = selectedDate;
                    });
                  }
                },
                readOnly: true,
                controller: TextEditingController(
                  text: planSchedule != null
                      ? planSchedule.toString().split(' ')[0]
                      : '',
                ),
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return 'Please select a date';
                //   }
                //   return null;
                // },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Description',
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                // onSaved: (value) => description = value,
              ),
              SizedBox(height: 16.0),
              Text('Goods Provided'),
              Row(
                children: <Widget>[
                  Radio(
                    value: true,
                    groupValue: goodsProvided,
                    onChanged: (value) {
                      // setState(() {
                      //   goodsProvided = value;
                      // });
                    },
                  ),
                  Text('Yes'),
                  Radio(
                    value: false,
                    groupValue: goodsProvided,
                    onChanged: (value) {
                      setState(() {
                        // goodsProvided = value;
                      });
                    },
                  ),
                  Text('No'),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter Estimate (Min)',
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      keyboardType: TextInputType.number,
                      // onSaved: (value) => estimateMin = double.parse(value),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter Estimate (Max)',
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      keyboardType: TextInputType.number,
                      // onSaved: (value) => estimateMax = double.parse(value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Icon(Icons.photo_camera),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement photo uploading logic here
                      },
                      child: Text('Upload Photos'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {}, //_submitform
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
