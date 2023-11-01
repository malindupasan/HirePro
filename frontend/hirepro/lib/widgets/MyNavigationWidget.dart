import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/screens/allBiddingsScreen.dart';
import 'package:hirepro/screens/homeScreen.dart';
import 'package:hirepro/screens/myTasks.dart';
import 'package:hirepro/screens/userProfile.dart';
import 'package:provider/provider.dart';

class MyNavigationWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  const MyNavigationWidget({
    required this.selectedIndex,
    required this.onItemTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey,
      selectedItemColor: kMainYellow,
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
          icon: Icon(FontAwesomeIcons.sackDollar),
          label: 'Bids',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }
}
