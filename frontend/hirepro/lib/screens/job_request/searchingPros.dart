import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/widgets/smallButton.dart';
import 'package:hirepro/widgets/stepper_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SearchingPros extends StatefulWidget {
  const SearchingPros({super.key});

  @override
  State<SearchingPros> createState() => _SearchingProsState();
}

class _SearchingProsState extends State<SearchingPros> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NewStepper(Colors.grey, Colors.grey, kMainYellow),
          const Text(
            "Searching for Service providers...",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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
            margin:const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallButton('Cancel', () {
                  Navigator.pop(context);
                }, Colors.grey, Colors.white),
                SmallButton('Continue', () {
                  Navigator.pushNamed(context, '/biddings');
                }, kMainYellow, Colors.white)
              ],
            ),
          )
        ],
      ),
    )));
  }
}
