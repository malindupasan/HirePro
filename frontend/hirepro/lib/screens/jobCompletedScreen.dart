import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/widgets/check_icon_large.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hirepro/widgets/SmallArrowButton.dart';

class JobCompletedScreen extends StatefulWidget {
  const JobCompletedScreen({super.key});

  @override
  State<JobCompletedScreen> createState() => _JobCompletedScreenState();
}

class _JobCompletedScreenState extends State<JobCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Particles.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CheckIconLarge(),
            SizedBox(
              height: 25,
            ),
            Text(
              'Job Complete',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text("Task has completed by Malindu De Silva.",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 50,
            ),
            Text('Rate Your Service Provider',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            RatingBar.builder(
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ],
        ),
      ),
    )));
  }
}