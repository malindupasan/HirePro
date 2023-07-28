import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SearchingPros extends StatefulWidget {
  const SearchingPros({super.key});

  @override
  State<SearchingPros> createState() => _SearchingProsState();
}

class _SearchingProsState extends State<SearchingPros> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Searching for Service providers...",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          LoadingAnimationWidget.prograssiveDots(
            color: kMainYellow,
            size: 100,
          ),
          Image.asset(
            'images/handyman.jpg',
            height: 450,
          )
        ],
      ),
    );
  }
}
