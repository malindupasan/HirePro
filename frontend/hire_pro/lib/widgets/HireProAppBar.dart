 import 'package:flutter/material.dart';
 import 'package:font_awesome_flutter/font_awesome_flutter.dart';
 
 AppBar HireProAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 1,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          FontAwesomeIcons.arrowLeft,
          color: Colors.black,
          size: 20,
        ),
      ),
      title: Text(
        'Change Password',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );
  }