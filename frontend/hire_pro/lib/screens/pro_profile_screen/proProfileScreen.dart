import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:hire_pro/screens/pro_profile_screen/reviews.dart';
import 'package:hire_pro/services/dateTimeFormatted.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/PercentageBar.dart';
import 'package:hire_pro/widgets/ReviewCard.dart';
import 'package:hire_pro/widgets/StarRating.dart';
import 'package:hire_pro/widgets/smallButton.dart';

class proProfileScreen extends StatefulWidget {
  const proProfileScreen({super.key});

  @override
  State<proProfileScreen> createState() => _proProfileScreenState();
}

List<String> images = [
  'images/male1.jpg',
  'images/male2.jpg',
  'images/male3.jpg'
];

class _proProfileScreenState extends State<proProfileScreen> {
  final List<Review> reviews = [
    Review(
      profilePicUrl: 'images/male1.jpg',
      name: 'John Doe',
      date: DateTime(2023, 7, 15),
      rating: 4.5,
      content:
          "Wow! I just had the most amazing experience with my hairstylist from the handyman app! They have truly worked magic with my hair. I couldn't be happier with the result!🌟🌟🌟🌟🌟",
    ),
    Review(
      profilePicUrl: 'images/male2.jpg',
      name: 'Jane Smith',
      date: DateTime(2023, 7, 20),
      rating: 5.0,
      content: 'Nulla vel magna et nisi euismod fermentum vel at leo.',
    ),
    Review(
      profilePicUrl: 'images/male3.jpg',
      name: 'Bob Johnson',
      date: DateTime(2023, 7, 25),
      rating: 3.0,
      content: 'Vivamus et dolor nec felis malesuada varius.',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: Color.fromARGB(255, 255, 244, 213),
              child: ProfileMain(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'I love what I do! I am a licensed cosmetologist. I specialize in blowouts/styling! You will always receive quality when you receive a service from me. I am always looking forward to making someone feel great not only on the outside but on the inside too.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Overview',
                            style: kHeading1,
                          ),
                        ),
                        overviewRow(FontAwesomeIcons.award, 'Hired 8 times'),
                        overviewRow(FontAwesomeIcons.locationDot, 'Colombo 03'),
                        overviewRow(
                            FontAwesomeIcons.clock, '3 years in buisiness'),
                      ],
                    ),
                  ),
                  // Container(
                  //   width: 1,
                  //   height: 120,
                  //   color: Colors.grey[600],
                  // ),
                  // Expanded(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         alignment: Alignment.topCenter,
                  //         child: Text(
                  //           'Social Media',
                  //           style: kHeading1,
                  //         ),
                  //       ),
                  //       overviewRow(FontAwesomeIcons.instagram, 'Emilyy_2000'),
                  //       overviewRow(FontAwesomeIcons.facebook, 'Emily William'),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Text(
              'Featured Projects',
              style: kHeading1,
            ),
            Gallery(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Reviews',
                style: kHeading1,
              ),
            ),
            Container(
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Excellent 4.5',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: kMainYellow),
                      ),
                      StarRating(4.5, 30),
                      Text('28 reviews')
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StarRatingSingle('5', 0.7),
                        StarRatingSingle('4', 0.3),
                        StarRatingSingle('3', 0.0),
                        StarRatingSingle('2', 0.0),
                        StarRatingSingle('1', 0.0),
                      ])
                ],
              ),
            ),
            Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: RawScrollbar(
                thumbColor: Color.fromARGB(255, 122, 122, 122),
                radius: Radius.circular(5),
                thickness: 10,
                thumbVisibility: true,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: reviews.length,
                  itemBuilder: (BuildContext context, int index) {
                    final review = reviews[index];
                    return ReviewCard(review: review);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallButton('More Reviews', () {},
                      const Color.fromARGB(255, 43, 43, 43), Colors.white),
                  SmallButton('Back', () {}, kMainYellow, Colors.white),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class StarRatingSingle extends StatelessWidget {
  String starno;
  double percentage;
  StarRatingSingle(this.starno, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(starno),
        Icon(
          FontAwesomeIcons.star,
          size: 13,
        ),
        PercentageBar(percentage, 150, 10),
        Text((percentage * 100).toString() + '%'),
      ],
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

class ProfileMain extends StatelessWidget {
  const ProfileMain({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: ClipOval(
            child: Image.asset(
              'images/female1.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Emily Williams',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Proffesional HairStylist',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[800]),
              ),
              StarRating(4.5, 25),
              SizedBox(
                height: 10,
              ),
              SmallButton('Accept', () {}, kMainYellow, Colors.white)
            ],
          ),
        )
      ],
    );
  }
}

class overviewRow extends StatelessWidget {
  overviewRow(this.icon, this.data);
  IconData icon;
  String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text(data),
        ],
      ),
    );
  }
}
