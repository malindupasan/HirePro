import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_pro/widgets/StarRating.dart';
import 'package:hire_pro/widgets/smallButton.dart';

class BiddingPage extends StatefulWidget {
  const BiddingPage({super.key});

  @override
  State<BiddingPage> createState() => _BiddingPageState();
}

class Bid {
  String name;
  double rating;
  double amount;
  String image;

  Bid(
      {required this.name,
      required this.rating,
      required this.amount,
      required this.image});
}

List<Bid> bidList = [
  Bid(name: "John Doe", rating: 4.5, amount: 1900, image: 'images/male1.jpg'),
  Bid(name: "Jane Smith", rating: 3.8, amount: 1750, image: 'images/male2.jpg'),
  Bid(
      name: "Michael Johnson",
      rating: 4.2,
      amount: 1450,
      image: 'images/male3.jpg'),
  Bid(
      name: "Emily Williams",
      rating: 4.0,
      amount: 1200,
      image: 'images/female1.jpg'),
  Bid(
      name: "Danella Lee",
      rating: 4.7,
      amount: 2500,
      image: 'images/female2.jpg'),
  // Add more items here as needed
];

class _BiddingPageState extends State<BiddingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Find the Perfect Pro for Your Task!',
                  style: kHeading1,
                ),
              ),
              Container(
                height: 600,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: bidList.map((bid) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/pro_profile');
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: kMainYellow,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: AssetImage(bid.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(169, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(5)),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      bid.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                StarRating(bid.rating, 20),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  width: double.infinity,
                                  color: Color.fromARGB(195, 0, 0, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Rs.' + bid.amount.toString(),
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
                    );
                  }).toList(),
                ),
              ),
              Container(
                  alignment: Alignment.bottomRight,
                  child: SmallButton('Cancel', () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  'Cancel Task',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 245, 110, 69)),
                                ),
                                content: const Text(
                                  'You\'ll loose all your bidding requests.\nAre you sure you want to cancel the task?',
                                  textAlign: TextAlign.justify,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.popUntil(context,
                                        ModalRoute.withName('/category')),
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text(
                                      'No',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ]));
                  }, Colors.grey, Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
