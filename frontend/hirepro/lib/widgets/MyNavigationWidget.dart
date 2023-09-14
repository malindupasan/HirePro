import 'package:flutter/material.dart';
import 'package:hirepro/screens/homeScreen.dart';
import 'package:hirepro/screens/myTasks.dart';
import 'package:hirepro/screens/userProfile.dart';

class MyNavigationWidget extends StatefulWidget {
  final token;
  const MyNavigationWidget({required this.token, super.key});
  @override
  _MyNavigationWidgetState createState() => _MyNavigationWidgetState();
}

class _MyNavigationWidgetState extends State<MyNavigationWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          HomeScreen(
            token: widget.token,
          ),
          MyTasks(),
          UserProfile()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'My Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}