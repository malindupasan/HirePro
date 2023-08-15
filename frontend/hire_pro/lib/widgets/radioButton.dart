import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';

enum SingingCharacter { Yes, No }

class RadioExample extends StatefulWidget {
  const RadioExample({Key? key}) : super(key: key);

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  SingingCharacter? _character = SingingCharacter.No;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: const Text('No'),
            leading: Radio<SingingCharacter>(
              activeColor: kMainYellow,
              value: SingingCharacter.No,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('Yes'),
            leading: Radio<SingingCharacter>(
              activeColor: kMainYellow,
              value: SingingCharacter.Yes,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
