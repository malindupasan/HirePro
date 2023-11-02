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
    dynamic id = ModalRoute.of(context)!.settings.arguments;
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
                            const SizedBox(
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
                            if (data.taskData.status == 'started')
                              Column(
                                children: [
                                  Text(
                                      'Service provider has departed! click continue'),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/arrival_screen',arguments: id);
                                      },
                                      child: Text("Continue"))
                                ],
                              )
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
