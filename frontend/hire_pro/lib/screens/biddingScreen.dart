import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                  'Find the Perfect Pro for Your Task',
                  style: kHeading1,
                ),
              ),
              Container(
                height: 600,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: bidList.map((bid) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                      shape: RoundedRectangleBorder(
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
                              RatingBarIndicator(
                                rating: bid.rating,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                unratedColor: Colors.white,
                                itemCount: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                              ),
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
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
