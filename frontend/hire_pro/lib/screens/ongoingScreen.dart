import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/HireProAppBar.dart';
import 'package:hire_pro/widgets/TaskCardOngoing.dart';

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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/rate');
                },
                child: TaskCardOngoing(
                    'John Doe', 'Plumbing', 5000, 'images/plumber.png', 1),
              ),
              TaskCardOngoing(
                  'Sam Wilson', 'Gardening', 3200, 'images/gardener.png', 0.7),
              TaskCardOngoing(
                  'Emily Clerk', 'Cleaning', 5000, 'images/cleaning.png', 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
