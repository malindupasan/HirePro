import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';

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
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: Colors
                          .grey, // Change the color of the header and selected time
                      highlightColor: kMainYellow,
                      secondaryHeaderColor: kMainYellow,
                      indicatorColor: kMainYellow,
                      hoverColor: kSecondaryYellow,
                      primaryColorDark: Colors.grey[600],
                      focusColor:
                          kMainYellow, // Change the color of the dial and hand
                      buttonTheme:
                          ButtonThemeData(textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
              );
              if (time != null) {
                setState(() {
                  selectedTime = time;
                });
              }
            },
            child: Text('Set the time'),
          ),
          if (selectedTime != null)
            Text('Selected time: ${selectedTime!.format(context)}'),
        ],
      ),
    );
  }
}
