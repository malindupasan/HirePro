import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/models/bids.dart';
import 'package:hirepro/providers/bids_provider.dart';
import 'package:hirepro/providers/service_provider_provider.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/widgets/StarRating.dart';
import 'package:hirepro/widgets/smallButton.dart';
import 'package:hirepro/widgets/stepper_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class WaitingForBidsScreen extends StatefulWidget {
  @override
  State<WaitingForBidsScreen> createState() => _WaitingForBidsScreenState();
}

class _WaitingForBidsScreenState extends State<WaitingForBidsScreen> {
  late String image;
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)!.settings.arguments;
    // List<Bids>bids=  Provider.of<BidsProvider>(context, listen: false).getFilteredBids(id);
    return Scaffold(
        body: SafeArea(
            child: Consumer<BidsProvider>(
      builder: (context, bidData, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            NewStepper(Colors.grey, Colors.grey, kMainYellow),
            if (bidData.getFilteredBids(id).isNotEmpty)
              Text(
                'Find the Perfect Pro for Your Task!',
                style: kHeading1,
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (bidData.filteredBids.isEmpty)
                  Column(
                    children: [
                      const Text(
                        "Searching for Service providers...",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      LoadingAnimationWidget.prograssiveDots(
                        color: kMainYellow,
                        size: 100,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Image.asset(
                          'images/handyman.jpg',
                          height: 400,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                      )
                    ],
                  ),
                if (bidData.filteredBids.isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 550,
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: bidData.getFilteredBids(id).map((bid) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/pro_profile');
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/pro_profile',
                                      arguments: [
                                        bid.serviceId,
                                        bid.serviceProId
                                      ]);
                                },
                                child: Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 5),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: kMainYellow,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: const DecorationImage(
                                        image: AssetImage('images/male1.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    192, 255, 255, 255),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                bid.name.toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          StarRating(4.4, 20),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            width: double.infinity,
                                            color: Color.fromARGB(195, 0, 0, 0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'Rs. ${bid.amount.toString()}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w900,
                                                    color: kMainYellow),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallButton('Back', () {
                                Navigator.pop(context);
                              }, kMainYellow, Colors.white),
                              SmallButton('Cancel', () {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                            title: const Text(
                                              'Cancel Task',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 245, 110, 69)),
                                            ),
                                            content: const Text(
                                              'You\'ll loose all your bidding requests.\nAre you sure you want to cancel the task?',
                                              textAlign: TextAlign.justify,
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.popUntil(
                                                        context,
                                                        ModalRoute.withName(
                                                            '/category')),
                                                child: const Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: const Text(
                                                  'No',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              )
                                            ]));
                              }, Colors.grey, Colors.white),
                            ],
                          ))
                    ],
                  )
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
