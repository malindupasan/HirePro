import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/providers/bids_provider.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/widgets/HireProAppBar.dart';
import 'package:hirepro/widgets/StarRating.dart';
import 'package:hirepro/widgets/smallButton.dart';
import 'package:hirepro/widgets/stepper_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class AllBiddingsScreen extends StatefulWidget {
  const AllBiddingsScreen({super.key});

  @override
  State<AllBiddingsScreen> createState() => _SearchingProsState();
}

class _SearchingProsState extends State<AllBiddingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Scaffold(
                appBar: HireProAppBar(context, "Ongoing Bids"),
                body: SingleChildScrollView(
                    child: Container(
                  height: 600,
                  child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(left: 5),
                          height: 150,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Lawn Mowing',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Service Number',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {}, child: Text("View")),
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
                )))));
  }
}
