import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:card_swiper/card_swiper.dart';

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
                          alignment: Alignment.topCenter,
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
                  Container(
                    width: 1,
                    height: 120,
                    color: Colors.grey[600],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Social Media',
                            style: kHeading1,
                          ),
                        ),
                        overviewRow(FontAwesomeIcons.instagram, 'Emilyy_2000'),
                        overviewRow(FontAwesomeIcons.facebook, 'Emily William'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Featured Projects',
              style: kHeading1,
            ),
            Gallery(),
            Text(
              'Reviews',
              style: kHeading1,
            ),
            Row(
          children: [
            Column(children: [],),
            Column(children: [])
          ],
            )
          ],
        ),
      ),
    ));
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
              RatingBarIndicator(
                rating: 4.5,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                unratedColor: Colors.grey,
                itemCount: 5,
                itemSize: 25.0,
                direction: Axis.horizontal,
              ),
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
