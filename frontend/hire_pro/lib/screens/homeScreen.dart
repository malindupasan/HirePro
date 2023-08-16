import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/MyNavigationWidget.dart';
import 'package:hire_pro/widgets/MainCard.dart';
import 'package:hire_pro/widgets/NavButton.dart';
import 'package:hire_pro/widgets/NavTop.dart';
import 'package:hire_pro/widgets/SearchBarWidget.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeScreen extends StatefulWidget {
  final token;
  const HomeScreen({required this.token, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: NavTop(kMainYellow, Colors.white, Colors.white, () {},
                      () {
                    Navigator.pushNamed(context, '/ongoing');
                  }, () {
                    Navigator.pushNamed(context, '/category');
                  })),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/category');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(FontAwesomeIcons.magnifyingGlass),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "What's in your to-do list? ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 45),
                  height: 50,
                ),
              ),
              MainCard(110, 325, Color(0XFFF5F5F5),
                  Image.asset('images/townPNG.png')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainCard(
                      110,
                      155,
                      kMainYellow,
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Upcoming',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text('Tasks',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      )),
                  MainCard(
                      110,
                      155,
                      Color(0XFFD9D9D9),
                      Column(
                        children: [
                          Text('15',
                              style: TextStyle(
                                  color: Color(0xFF625C5C),
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500)),
                          Text('Filters for',
                              style: TextStyle(
                                  color: Color(0xFF625C5C),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                          Text('accurate search',
                              style: TextStyle(
                                  color: Color(0xFF625C5C),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500))
                        ],
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  "Recommended for you...",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF625C5C),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/job_request',
                      arguments: 'Lawn Moving');
                },
                child: MainCard(
                    100,
                    325,
                    Color(0XFFF5F5F5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 0),
                              child: Text(
                                "Lawn Mowing",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.5),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRect(
                              child: Image.asset(
                                'images/lawnhome.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ])),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/job_request',
                      arguments: 'House Cleaning');
                },
                child: MainCard(
                    100,
                    325,
                    Color(0XFFF5F5F5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: ClipRRect(
                                  child: Image.asset(
                            'images/househome.jpg',
                            fit: BoxFit.cover,
                          ))),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 0),
                              child: Text(
                                "House Cleaning",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.5),
                              ),
                            ),
                          )
                        ])),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
