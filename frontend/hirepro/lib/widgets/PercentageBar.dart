import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentageBar extends StatelessWidget {
  double percentage;
  double width;
  double height;
  PercentageBar(this.percentage, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return new LinearPercentIndicator(
      barRadius: Radius.circular(7),
      width: width,
      lineHeight: height,
      percent: percentage,
      backgroundColor: Colors.grey[300],
      progressColor: Colors.amber,
    );
  }
}