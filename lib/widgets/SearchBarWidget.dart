import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 30,
            color: Colors.black,
          ),
        
          hintText: 'What\'s in your to-do list?',
          
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            
          ),
          
        ),
      ),
    );
  }
}
