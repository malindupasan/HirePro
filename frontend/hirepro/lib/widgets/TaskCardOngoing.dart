import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants.dart';

class TaskCardOngoing extends StatefulWidget {
  late String serviceProvider;
  late String jobType;
  late double price;
  late String image;
  late double progress;
  TaskCardOngoing(this.serviceProvider, this.jobType, this.price, this.image,
      this.progress);

  @override
  State<TaskCardOngoing> createState() => _TaskCardOngoingState();
}

class _TaskCardOngoingState extends State<TaskCardOngoing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kMainGrey,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3.0,
              spreadRadius: 1.0,
              offset: Offset(2.0, 2.0),
            ),
          ]),
      child: Row(children: [
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.jobType,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.buildingUser,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.serviceProvider,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Service provider',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'Rs.' + widget.price.toString().split('.')[0],
                      style: TextStyle(
                          fontSize: 25,
                          color: kMainYellow,
                          fontWeight: FontWeight.bold),
                    ),
                    LinearPercentIndicator(
                      barRadius: Radius.circular(10),
                      width: 140.0,
                      lineHeight: 14.0,
                      percent: widget.progress,
                      backgroundColor: Colors.grey[300],
                      progressColor: Colors.amberAccent,
                    ),
                    const Row(
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
        Expanded(flex: 2, child: Image.asset(widget.image))
      ]),
    );
  }
}
