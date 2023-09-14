import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  FormInput(this.label);
  late String label;
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        focusColor: Colors.grey,
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w600),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
