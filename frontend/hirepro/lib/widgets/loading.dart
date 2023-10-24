import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 100,
          child: LoadingIndicator(
            colors: [kMainYellow, kSecondaryYellow],
            indicatorType: Indicator.ballBeat,
          ),
        ),
      ),
    );
  }
}