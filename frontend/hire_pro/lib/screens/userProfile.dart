import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_pro/models/address.dart';
import 'package:hire_pro/models/customer.dart';
import 'package:hire_pro/screens/editProfile/editProfile.dart';
import 'package:hire_pro/screens/editProfile/editProfileScreen.dart';
import 'package:hire_pro/services/api.dart';
import 'package:hire_pro/widgets/HireProAppBar.dart';
import 'package:hire_pro/widgets/LineDivider.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/smallButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

String getInitials(String name) {
  List<String> names = name.split(' ');
  int size = names.length;
  late String initials;
  if (size > 1) {
    initials = names[0][0] + names[size - 1][0];
  } else {
    initials = names[0][0];
  }
  return initials;
}

class _UserProfileState extends State<UserProfile> {
  Api api = Api();

  late Future<Customer> customer;
  late Future<List<Address>> addresses;
  void initState() {
    super.initState();
    customer = api.getData();
    addresses = api.fetchAddresses(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: HireProAppBar(context, 'Profile'),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                height: 750,
                child: FutureBuilder<Customer>(
                    future: customer,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 40),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 150,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: kMainYellow,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Hero(
                                                tag: 'image',
                                                child: Center(
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: CircleAvatar(
                                                      radius: 72,
                                                      backgroundColor:
                                                          kMainGrey,
                                                      child: Text(
                                                        getInitials(snapshot
                                                            .data!.name),
                                                        style: TextStyle(
                                                            fontSize: 48,
                                                            color: kMainYellow),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!.name,
                                              style: TextStyle(
                                                fontSize: 30,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: kSecondaryYellow,
                                              ),
                                              child: GestureDetector(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Text(
                                                      "EDIT PROFILE",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: kMainYellow,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    final result =
                                                        await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditProfileScreen()));

                                                    if (result == true) {
                                                      setState(() {
                                                        customer =
                                                            api.getData();
                                                      });
                                                    }
                                                  }),
                                            ),
                                            RatingBarIndicator(
                                              rating: 3.35,
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 30.0,
                                              direction: Axis.horizontal,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ProfileSummary(
                                                    '10', 'Total no of jobs'),
                                                ProfileSummary(
                                                    snapshot
                                                        .data!.loyalityPoints,
                                                    'Loyality points')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                            width: double.infinity,
                                            margin:
                                                EdgeInsetsDirectional.symmetric(
                                                    horizontal: 10,
                                                    vertical: 30),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 1,
                                                        blurRadius: 5,
                                                        offset: Offset(0,
                                                            3), // horizontal, vertical offset
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        height: 40,
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Saved Places',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Container(
                                                                height: 25,
                                                                child: FloatingActionButton
                                                                    .small(
                                                                        child:
                                                                            Icon(
                                                                          size:
                                                                              15,
                                                                          FontAwesomeIcons
                                                                              .plus,
                                                                        ),
                                                                        elevation:
                                                                            3,
                                                                        backgroundColor:
                                                                            kMainYellow,
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pushNamed(
                                                                              context,
                                                                              '/add_address');
                                                                        }),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      FutureBuilder<
                                                          List<Address>>(
                                                        future:
                                                            api.fetchAddresses(
                                                                http.Client()),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasError) {
                                                            print(
                                                                snapshot.error);
                                                            return const Center(
                                                              child: Text(
                                                                  'An error has occurred!'),
                                                            );
                                                          } else if (snapshot
                                                              .hasData) {
                                                            return AddressList(
                                                                addresses:
                                                                    snapshot
                                                                        .data!);
                                                          } else {
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                MainButton('Sign out', () {
                                                  //  signout();
                                                }),
                                              ],
                                            ),
                                          ))
                                    ])));
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return Center(
                        child: CircularProgressIndicator(color: kMainYellow),
                      );
                    }),
              ),
            )));
  }
}

class AddAddress extends StatelessWidget {
  final String main;
  final String address;
  final IconData icon;
  AddAddress(this.main, this.address, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(
              horizontal: BorderSide(color: Colors.grey, width: 0.5))),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(flex: 1, child: Icon(icon, size: 30)),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(main),
                SizedBox(height: 5),
                Text(address,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                        color: Colors.grey[500]))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileSummary extends StatelessWidget {
  final String big;
  final String small;
  ProfileSummary(this.big, this.small);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            big,
            style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.w500,
                color: Color(0xFF625C5C)),
          ),
        ),
        Text(small,
            style: TextStyle(
              fontSize: 15,
            ))
      ],
    );
  }
}

class AddressList extends StatelessWidget {
  const AddressList({super.key, required this.addresses});

  final List<Address> addresses;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: RawScrollbar(
        child: Container(
          height: 100,
          child: ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              return AddAddress(
                addresses[index].title,
                addresses[index].address,
                Icons.location_on,
              );
            },
          ),
        ),
      ),
    );
  }
}
