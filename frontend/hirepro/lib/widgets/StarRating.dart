import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRating extends StatelessWidget {
  double rating;
  double size;
  StarRating(this.rating, this.size);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      unratedColor: Colors.grey,
      itemCount: 5,
      itemSize: size,
      direction: Axis.horizontal,
    );
  }
}
