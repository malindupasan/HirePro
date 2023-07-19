import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/MyNavigationWidget.dart';
import 'package:hire_pro/widgets/MainCard.dart';
import 'package:hire_pro/widgets/NavButton.dart';
import 'package:hire_pro/widgets/NavTop.dart';
import 'package:hire_pro/widgets/SearchBarWidget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List _categories = [
    'Gardening',
    'Plumbing',
    'Cleaning',
    'Furniture',
    'Hair Cutting',
    'Lawn Moving',
    'Painting'
  ];
  List _filteredItems = [];

  @override
  void initState() {
    // TODO: implement initState
    _filteredItems = _categories;
    super.initState();
  }

  void _filterItems(String searchText) {
    List results = [];
    if (searchText.isEmpty) {
      results = _categories;
    } else {
      results = _categories
          .where(
              (item) => item.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: BottomNavBar(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: NavTop(Colors.white, Colors.white, kMainYellow, () {
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    }, () {
                      Navigator.popUntil(
                          context, ModalRoute.withName('/ongoing'));
                    }, () {}),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Material(
                      elevation: 1,
                      shadowColor: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: TextField(
                          cursorColor: Colors.grey[600],
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                size: 30,
                                color: Colors.black,
                              ),
                              hintText: 'What\'s in your to-do list?',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 226, 226, 226))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 226, 226, 226)))),
                          onChanged: (value) => _filterItems(value)),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.count(
                crossAxisCount: 2,
                children: _filteredItems.map((category) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: ListTile(
                      title: Text(category),
                      onTap: () {
                        Navigator.pushNamed(context, '/job_request');
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
