import 'package:flutter/material.dart';
import 'package:hirepro/widgets/HireProAppBar.dart';

class MyTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HireProAppBar(context, 'My Tasks'),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: TaskTypeCard(
                  'Ongoing Tasks', 'images/rising.png', '/ongoing')),
          Expanded(
              child: TaskTypeCard(
                  'Scheduled Tasks', 'images/schedule.png', '/upcoming')),
          Expanded(
              child: TaskTypeCard(
                  'Completed Tasks', 'images/completed-task.png', '/schedule')),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class TaskTypeCard extends StatelessWidget {
  final String title;
  final String image;
  final String route;
  TaskTypeCard(this.title, this.image, this.route);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 3, // How far the shadow spreads
                blurRadius: 3, // The intensity/density of the shadow
                offset: Offset(0, 1),
              )
            ]),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(flex: 1, child: Image.asset(image)),
          SizedBox(
            width: 50,
          ),
          Expanded(
              flex: 2,
              child: Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ))
        ]),
      ),
    );
  }
}
