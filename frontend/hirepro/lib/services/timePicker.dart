import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/screens/job_request/TaskAddScreen.dart';

class TimePicker extends StatefulWidget {
  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            onPressed: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
                initialEntryMode: TimePickerEntryMode.input,
              );
              if (time != null) {
                setState(() {
                  selectedTime = time;
                  formselectedTime = time;
                });
              }
            },
            child: Text('Set the time'),
          ),
          if (selectedTime != null)
            Text('Scheduled time: ${selectedTime!.format(context)}'),
        ],
      ),
    );
  }
}
