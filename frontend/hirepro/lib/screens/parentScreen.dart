import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/screens/allBiddingsScreen.dart';
import 'package:hirepro/screens/homeScreen.dart';
import 'package:hirepro/screens/myTasks.dart';
import 'package:hirepro/screens/userProfile.dart';
import 'package:hirepro/widgets/MyNavigationWidget.dart';
import 'package:provider/provider.dart';

class ParentScreen extends StatefulWidget {
  final token;
  ParentScreen({required this.token});

  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
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
      bottomNavigationBar: MyNavigationWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          if (index == 2) {
            Provider.of<TaskProvider>(context, listen: false).getPendingTasks();
          }
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
