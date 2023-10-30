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
  late String status;
  late String jobid;
  TaskCardOngoing(this.serviceProvider, this.jobType, this.price, this.image,
      this.progress, this.status, this.jobid);

  @override
  State<TaskCardOngoing> createState() => _TaskCardOngoingState();
}

class _TaskCardOngoingState extends State<TaskCardOngoing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white, // Use a white background
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Slight shadow
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.jobType,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Serivce ID: ${widget.jobid}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10), // Add some spacing
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.buildingUser,
                        size: 15,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.serviceProvider,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10), // Add some spacing
                  Text(
                    widget.status,
                    style: const TextStyle(
                      color: Colors.green, // Use green for status
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10), // Add some spacing
                  Text(
                    'Rs.${widget.price.toStringAsFixed(0)}', // Format price
                    style: TextStyle(
                      fontSize: 25,
                      color: kMainYellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10), // Add some spacing
                  LinearPercentIndicator(
                    barRadius: const Radius.circular(10),
                    width: 140.0,
                    lineHeight: 14.0,
                    percent: widget.progress,
                    backgroundColor: Colors.grey[200], // Lighter background
                    progressColor: Colors.amberAccent,
                  ),
                  const SizedBox(height: 10), // Add some spacing
                  // Row(
                  //   children: [
                  //     const Text('View More'),
                  //     const SizedBox(width: 10),
                  //     const Icon(FontAwesomeIcons.arrowRight, size: 12),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
