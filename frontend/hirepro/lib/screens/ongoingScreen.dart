import 'package:flutter/material.dart';
import 'package:hirepro/models/task.dart';
import 'package:hirepro/providers/chat_provider.dart';
import 'package:hirepro/providers/customer_provider.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/widgets/HireProAppBar.dart';
import 'package:hirepro/widgets/TaskCardOngoing.dart';
import 'package:provider/provider.dart';

class OngoingScreen extends StatefulWidget {
  @override
  State<OngoingScreen> createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<TaskProvider>(context, listen: false).getOngoingTasks();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HireProAppBar(context, "Ongoing Tasks"),
        body: Consumer<TaskProvider>(
            builder: (context, data, child) => SingleChildScrollView(
                  child: Column(
                    children: [
                      for (Task task in data.ongoingTasks)
                        GestureDetector(
                          onTap: () {
                            String userid = Provider.of<CustomerProvider>(
                                    context,
                                    listen: false)
                                .customerData!
                                .id;
                            Provider.of<ChatProvider>(context, listen: false)
                                .initializeData(task.id, task.spid, userid);
                            Provider.of<ChatProvider>(context, listen: false)
                                .setServiceProviderName(task.serviceProvider);
                          

                            if (task.status == "accepted") {
                              Navigator.pushNamed(
                                context,
                                '/ongoing_task_details',
                              );
                            }
                            if (task.status == "started") {
                              Navigator.pushNamed(
                                context,
                                '/arrival_screen',
                              );
                            }
                          },
                          child: TaskCardOngoing(
                              task.serviceProvider!,
                              task.category!,
                              double.parse(task.amount!),
                              'images/${task.category}.png',
                              double.parse(task.percentage!),
                              task.status!.toUpperCase(),
                              task.id!),
                        ),
                    ],
                  ),
                )),
      ),
    );
  }
}
