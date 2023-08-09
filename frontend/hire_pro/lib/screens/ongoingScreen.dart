import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/HireProAppBar.dart';
import 'package:hire_pro/widgets/TaskCardOngoing.dart';
import 'package:hire_pro/widgets/smallButton.dart';
import 'package:percent_indicator/percent_indicator.dart';

class OngoingScreen extends StatefulWidget {
  const OngoingScreen({super.key});

  @override
  State<OngoingScreen> createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HireProAppBar(context, "Ongoing Tasks"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TaskCardOngoing(
                  'John Doe', 'Plumbing', 5000, 'images/plumber.png'),
              TaskCardOngoing(
                  'Sam Wilson', 'Gardening', 3200, 'images/gardener.png'),
              TaskCardOngoing(
                  'Emily Clerk', 'Cleaning', 5000, 'images/cleaning.png'),
            ],
          ),
        ),
      ),
    );
  }
}
