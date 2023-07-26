import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  SmallButton(this.buttonText, this.navigation, this.color, this.textColor);
  final String buttonText;
  final Color textColor;
  final VoidCallback navigation;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 80,
      
      child: RawMaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.5)),
        elevation: 0,
        highlightElevation: 0,
        highlightColor: Color.fromARGB(255, 253, 171, 77),
        onPressed: navigation,
        fillColor: color,
        child: Text(buttonText,
            style: TextStyle(
                color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
