import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants.dart';

class TaskCardOngoing extends StatelessWidget {
  late String serviceProvider;
  late String jobType;
  late double price;
  late String image;
  TaskCardOngoing(this.serviceProvider, this.jobType, this.price, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobType,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.buildingUser,
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      serviceProvider,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Service provider',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'Rs.' + price.toString().split('.')[0],
                  style: TextStyle(
                      fontSize: 25,
                      color: kMainYellow,
                      fontWeight: FontWeight.bold),
                ),
                new LinearPercentIndicator(
                  barRadius: Radius.circular(10),
                  width: 140.0,
                  lineHeight: 14.0,
                  percent: 0.8,
                  backgroundColor: Colors.grey[300],
                  progressColor: Colors.amberAccent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'View More',
                    ),
                    SizedBox(width: 10),
                    Icon(FontAwesomeIcons.arrowRight, size: 12)
                  ],
                )
              ]),
        )),
        Expanded(child: Image.asset(image))
      ]),
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kMainGrey,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3.0,
              spreadRadius: 1.0,
              offset: Offset(2.0, 2.0),
            ),
          ]),
    );
  }
}
