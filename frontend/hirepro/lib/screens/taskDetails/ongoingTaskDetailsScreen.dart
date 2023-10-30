import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/widgets/HireProAppBar.dart';
import 'package:hirepro/widgets/MainButton.dart';
import 'package:provider/provider.dart';

class OngoingTaskDetailsScreen extends StatelessWidget {
  const OngoingTaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          appBar: HireProAppBar(context, "Plumbing"),
          body: Consumer<TaskProvider>(
              builder: (context, data, child) => SingleChildScrollView(
                    child: Container(
                      height: 600,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Service provider has accepted your task!",
                              style: kHeading1,
                            ),
                            Image.asset(
                              'images/task_ongoing.gif',
                              width: 600,
                            ),
                            Text(
                              "Waiting the task to be started...",
                              style: kHeading1,
                            ),
                            MainButton('Continue', () {
                              Navigator.pushNamed(context, '/arrival_screen');
                            })
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
