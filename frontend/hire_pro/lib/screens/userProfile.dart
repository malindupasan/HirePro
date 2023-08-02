import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_pro/widgets/LineDivider.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/smallButton.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  TextEditingController _emailController = TextEditingController();
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // bottomNavigationBar: BottomNavBar(),
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width:
                                150, // Set the desired width of the container
                            height:
                                150, // Set the desired height of the container
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // Create a circular shape
                              border: Border.all(
                                color: kMainYellow, // Set the border color
                                width: 2, // Set the border width
                              ),
                            ),
                            child: Hero(
                              tag: "image",
                              child: ClipOval(
                                child: Image.asset(
                                  'images/profile_pic.png', // Replace with your image URL
                                  fit: BoxFit
                                      .cover, // Adjust the image's fit within the circular border
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Harini Samaliarachchi",
                            style: TextStyle(
                              fontSize: 30,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                                onTap: () {
                                  Navigator.pushNamed(context, '/edit_profile');
                                }),
                          ),
                          // Text(
                          //   "Stars you've earned",
                          //   style: TextStyle(fontSize: 13),
                          // ),
                          RatingBarIndicator(
                            rating: 3.35,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 30.0,
                            direction: Axis.horizontal,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ProfileSummary('15', 'Total no of jobs'),
                              ProfileSummary('12.7', 'Loyality points')
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsetsDirectional.symmetric(
                            horizontal: 10, vertical: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // horizontal, vertical offset
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        'Saved Places',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  RawScrollbar(
                                    thumbColor: Colors.grey,
                                    radius: Radius.circular(5),
                                    thumbVisibility: true,
                                    child: Container(
                                      height: 130,
                                      child: ListView(
                                        padding: EdgeInsets.all(10),
                                        children: [
                                          AddAddress('Home', 'Add Address',
                                              Icons.home_outlined),
                                          AddAddress('Work', 'Add Address',
                                              Icons.work_outlined),
                                          AddAddress('School', 'Add Address',
                                              Icons.school_outlined),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MainButton('Sign out', () {}),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
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
        children: [
          Icon(icon, size: 30),
          SizedBox(
            width: 30,
          ),
          Column(
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
        Text(
          big,
          style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.w500,
              color: Color(0xFF625C5C)),
        ),
        Text(small,
            style: TextStyle(
              fontSize: 15,
            ))
      ],
    );
  }
}
