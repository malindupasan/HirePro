import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_pro/widgets/LineDivider.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/smallButton.dart';
import 'package:card_swiper/card_swiper.dart';

class UserProfilesp extends StatefulWidget {
  const UserProfilesp({Key? key}) : super(key: key);

  @override
  State<UserProfilesp> createState() => _UserProfilespState();
}

List<String> images = [
  'images/male1.jpg',
  'images/male2.jpg',
  'images/male3.jpg'
];

class _UserProfilespState extends State<UserProfilesp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBarBackAndMore(),
        // bottomNavigationBar: BottomNavBar(),
        resizeToAvoidBottomInset: false,
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Container(
              height: 900,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        tag: "image",
                        child: ClipOval(
                          child: Image.asset(
                            'images/profile_pic.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Sachini Muthugala",
                      style: TextStyle(
                        fontSize: 30,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
                    Text(
                      'HirePro ID - 2002076',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                    ProfileSummary('LKR 120,000', 'Revenue Earned'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ProfileWidgets(
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                '15',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            'Completed'),
                        ProfileWidgets(
                            IconButton.filled(
                              icon: const Icon(Icons.attach_money),
                              onPressed: () {},
                            ),
                            'Wallet'),
                        ProfileWidgets(
                            IconButton(
                              icon: Icon(Icons.help),
                              onPressed: () {},
                            ),
                            'Help')
                      ],
                    ),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Introduction',
                            style: TextStyle(
                                color: kMainYellow,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                              'HandyNYC (Insured) - We are a Handyman Company Based in NYC That Presenting Home Owners - Renters and Business Solutions For Maintaining and Remodeling Their Property'),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  'Featured Projects',
                                  style: TextStyle(
                                      color: kMainYellow,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.edit,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gallery(),
                    MainButton('My Reviews', () {}),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
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
              fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        Text(small,
            style: TextStyle(
              fontSize: 10,
            ))
      ],
    );
  }
}

class ProfileWidgets extends StatelessWidget {
  final String text;
  final Widget button;
  ProfileWidgets(this.button, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Column(
        children: [
          button,
          Text(text,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 13,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}

class Gallery extends StatelessWidget {
  const Gallery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 200,
      child: Swiper(
        // autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          final image = images[index];
          return Image.asset(
            image,
            fit: BoxFit.fill,
          );
        },
        itemCount: images.length,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}
