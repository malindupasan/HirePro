import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/screens/allBiddingsScreen.dart';
import 'package:hirepro/screens/homeScreen.dart';
import 'package:hirepro/screens/myTasks.dart';
import 'package:hirepro/screens/userProfile.dart';
import 'package:provider/provider.dart';

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
          AllBiddingsScreen(),
          const UserProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: kMainYellow,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'My Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.sackDollar),
            label: 'Bids',
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
      if (index == 2) {
        Provider.of<TaskProvider>(context, listen: false).getPendingTasks();
      }
      _selectedIndex = index;
    });
  }
}
