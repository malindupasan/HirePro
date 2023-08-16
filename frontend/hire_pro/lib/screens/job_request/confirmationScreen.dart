import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/screens/job_request/TaskAddScreen.dart';
import 'package:hire_pro/services/api.dart';
import 'package:hire_pro/widgets/MainCard.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  List<String> images = ['images/lawn1.jpg', 'images/lawn2.jpg'];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
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
                    ContentSection('Task', globalCategory),
                    if (globalCategory == "Lawn Mowing")
                      Column(
                        children: [
                          ContentSection('Land Area', formArea.toString()),
                        ],
                      ),
                    ContentSection('Where', formLocation!),
                    if (formselectedTime != null && calanderDate != null)
                      Column(
                        children: [
                          ContentSection(
                              'Scheduled Time',
                              formselectedTime
                                  .toString()
                                  .split('(')[1]
                                  .split(')')[0]),
                          ContentSection('Scheduled Date',
                              calanderDate.toString().split(' ')[0]),
                        ],
                      ),
                    Column(
                      children: [
                        ContentSection('Description', ''),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 65, 65, 65),
                              width: 1.0,
                            ),
                          ),
                          margin:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: Text(
                              textAlign: TextAlign.justify,
                              formDescription!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    ContentSection(
                        'Goods Provided', formbool.toString().split('.')[1]),
                    ContentSection('Estimate (Rs.)', formMin! + '-' + formMax!),
                    ContentSection('Photos', ''),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: images.map((image) {
                          return Card(
                            color: kMainGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(image))),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ))
          ],
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
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
              child: Text(
                data,
                style: Knormal1,
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
