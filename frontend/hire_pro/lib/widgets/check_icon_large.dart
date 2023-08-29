import 'package:flutter/material.dart';

class CheckIconLarge extends StatelessWidget {
  const CheckIconLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.check_circle,
        size: 72,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.grey[200],
      ),
      height: 72,
      width: 72,
    );
  }
}
