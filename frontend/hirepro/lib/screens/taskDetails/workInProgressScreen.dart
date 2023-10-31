import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/widgets/HireProAppBar.dart';
import 'package:hirepro/widgets/MainButton.dart';
import 'package:provider/provider.dart';

class WorkInProgressScreen extends StatelessWidget {
  const WorkInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HireProAppBar(context, "Work in progress"),
      body: Consumer<TaskProvider>(
        builder: (context, data, child) => SingleChildScrollView(
          // Wrapping with a SingleChildScrollView to make it scrollable
          child: Container(
            height: 700,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.grey[200]!,
                    offset: Offset(2, 3))
              ],
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Great news! Your handyman has begun the task.",
                  style: kHeading1.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                    height:
                        30), // Reduce some spacings to minimize content height
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'images/work_in_progress.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Reduce some spacings
                // Text(
                //   "Your job is now in motion! ensuring everything gets done right",
                //   style: kHeading1.copyWith(
                //     fontSize: 20,
                //     color: Colors.black87,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                const SizedBox(height: 30), // Reduce some spacings
                MainButton('Continue', () {
                  Navigator.pushNamed(context, '/job_completed');
                }),
                Text(
                  "Any problem?",
                  style: kHeading1.copyWith(color: kMainYellow),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/complaint');
                        },
                        icon: Icon(Icons.report),
                        label: Text('Report')),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: Icon(Icons.sos_rounded))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
