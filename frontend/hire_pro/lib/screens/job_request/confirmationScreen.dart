import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/providers/task_provider.dart';
import 'package:hire_pro/screens/job_request/TaskAddScreen.dart';
import 'package:hire_pro/screens/job_request/jobRequest.dart';
import 'package:hire_pro/widgets/MainCard.dart';
import 'package:hire_pro/widgets/smallButton.dart';
import 'package:hire_pro/widgets/stepper_bar.dart';
import 'package:provider/provider.dart';

class ConfirmationScreen extends StatelessWidget {
  List<String> images = ['images/lawn1.jpg', 'images/lawn2.jpg'];
  JobRequest jobStatus = JobRequest();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, task, child) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  NewStepper(Colors.grey, kMainYellow, Colors.grey),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Confirmation',
                          style: kHeading1,
                        ),
                        MainCard(
                            630,
                            double.infinity,
                            kMainGrey,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ContentSection('Task', task.taskCategory),
                                if (task.taskCategory == "Lawn Mowing")
                                  Column(
                                    children: [
                                      ContentSection(
                                          'Land Area', task.taskData.area!),
                                    ],
                                  ),
                                ContentSection('Where', task.taskData.location),
                                if (task.taskData.date! !=
                                    DateTime.now().toString())
                                  Column(
                                    children: [
                                      ContentSection(
                                          'Scheduled Time',
                                          task.taskData.postedtime!
                                              .split('(')[1]
                                              .split(')')[0]),
                                      ContentSection('Scheduled Date',
                                          task.taskData.date!.split(' ')[0]),
                                    ],
                                  ),
                                Column(
                                  children: [
                                    ContentSection('Description', ''),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 65, 65, 65),
                                          width: 1.0,
                                        ),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 20),
                                      child: Text(
                                          textAlign: TextAlign.justify,
                                          task.taskData.description,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                                ContentSection('Goods Provided',
                                    formbool.toString().split('.')[1]),
                                ContentSection('Estimate (Rs.)',
                                    '${task.taskData.estmin} - ${task.taskData.estmax}'),
                                ContentSection('Photos', ''),
                                Expanded(
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    children: task.files.map((image) {
                                      return Card(
                                        color: kMainGrey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Image.file(
                                            image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallButton('Continue', () {
                                final task = Provider.of<TaskProvider>(context,
                                    listen: false);
                                if (task.taskCategory == "Lawn Mowing") {
                                  task.addLawnMowingTask();
                                }
                              }, kMainYellow, Colors.white),
                              SmallButton('Cancel', () {
                                Navigator.pop(context);
                              }, Colors.grey, Colors.white)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContentSection extends StatelessWidget {
  String label;
  String data;
  ContentSection(this.label, this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                label,
                style: Knormal1.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    data,
                    style: Knormal1,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
