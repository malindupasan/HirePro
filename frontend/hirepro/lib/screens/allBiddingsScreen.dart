import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/controllers/date_controller.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/widgets/HireProAppBar.dart';
import 'package:provider/provider.dart';

class AllBiddingsScreen extends StatelessWidget {
  DateController date = DateController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Scaffold(
                appBar: HireProAppBar(context, "Ongoing Bids"),
                body: SingleChildScrollView(
                    child: Consumer<TaskProvider>(
                  builder: (context, pendingtasks, child) => Container(
                    height: 600,
                    child: ListView.builder(
                        itemCount: pendingtasks.pendingTasks.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(left: 5),
                            height: 170,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
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
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Lawn Mowing',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "#${pendingtasks.pendingTasks[index].id}",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      ),
                                      Text(
                                        "Rs.${pendingtasks.pendingTasks[index].estmin}-Rs.${pendingtasks.pendingTasks[index].estmax}",
                                        style: TextStyle(
                                            color: Colors.amber[600],
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.clock,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            (pendingtasks
                                                .pendingTasks[index].date!
                                                .split('T')
                                                .last
                                                .split('.')
                                                .first
                                                .substring(0, 5)),
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.calendar,
                                            size: 15,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            date.formatDate(pendingtasks
                                                .pendingTasks[index].date!
                                                .split('T')
                                                .first),
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: Text("View")),
                                          OutlinedButton(
                                            
                                              onPressed: () {},
                                              child: Text("Details")),
                                        ],
                                      ),
                                    ]),
                              )),
                              Container(
                                width: 150,
                                padding: const EdgeInsets.all(0),
                                child: Image.asset(
                                  'images/gardening.jpeg',
                                  fit: BoxFit.cover,
                                ),
                              )
                            ]),
                          );
                        }),
                  ),
                )))));
  }
}
