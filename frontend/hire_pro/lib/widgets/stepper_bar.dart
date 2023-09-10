import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';

class NewStepper extends StatelessWidget {
  final Color color1;
  final Color color2;
  final Color color3;
  NewStepper(this.color1, this.color2, this.color3);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleStep('1', color1, 'Task'),
          Container(
            height: 2,
            width: 40,
            color: Colors.grey,
          ),
          SingleStep('2', color2, 'Confirm'),
          Container(
            height: 2,
            width: 40,
            color: Colors.grey,
          ),
          SingleStep('3', color3, 'Bidding'),
        ],
      ),
    );
  }
}

class SingleStep extends StatelessWidget {
  String stepNumber;
  Color color;
  String title;
  SingleStep(this.stepNumber, this.color, this.title);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: color,
          child: Text(
            stepNumber,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
