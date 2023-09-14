import 'package:flutter/material.dart';
import 'package:hirepro/providers/category_provider.dart';
import 'package:hirepro/widgets/HireProAppBar.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<CategoryProvider>(builder: (context, category, child) {
      return Scaffold(
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
                          onChanged: (value) => category.filterItems(value)),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: GridView.count(
                crossAxisCount: 2,
                children: category.categories.map((category) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(category.values.elementAt(0)))),
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromARGB(209, 0, 0, 0),
                              ),
                              width: double.infinity,
                              height: 35,
                              child: Center(
                                child: Text(category.keys.first,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                        onTap: () {
                          String selectedCategory = category.keys.first;
                          Navigator.pushNamed(context, '/job_request',
                              arguments: selectedCategory);
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }));
  }
}
