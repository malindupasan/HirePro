import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/screens/categories/categories.dart';
import 'package:hire_pro/widgets/HireProAppBar.dart';
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
  Categories category = Categories();

  List<Map<String, String>> _filteredItems = [];
  late List<Map<String, String>> categories = category.getCategories();

  @override
  void initState() {
    _filteredItems = categories;
    super.initState();
  }

  void _filterItems(String searchText) {
    List<Map<String, String>> results = [];
    if (searchText.isEmpty) {
      results = categories;
    } else {
      results = categories
          .where((item) =>
              item.keys.first.toLowerCase().contains(searchText.toLowerCase()))
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
      appBar: HireProAppBar(context, 'Categories'),
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: BottomNavBar(),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
            flex: 6,
            child: GridView.count(
              crossAxisCount: 2,
              children: _filteredItems.map((category) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(category.values.elementAt(0)))),
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(209, 0, 0, 0),
                              ),
                              width: double.infinity,
                              height: 25,
                              child: Text(category.keys.first,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        onTap: () {
                          String selectedCategory = category.keys.first;
                          Navigator.pushNamed(context, '/job_request',arguments:selectedCategory);
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ));
  }
}
