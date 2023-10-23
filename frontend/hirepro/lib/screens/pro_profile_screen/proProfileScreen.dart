import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hirepro/constants.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:hirepro/providers/service_provider_provider.dart';
import 'package:hirepro/screens/pro_profile_screen/reviews.dart';
import 'package:hirepro/widgets/PercentageBar.dart';
import 'package:hirepro/widgets/ReviewCard.dart';
import 'package:hirepro/widgets/StarRating.dart';
import 'package:hirepro/widgets/smallButton.dart';
import 'package:provider/provider.dart';

List<String> images = [
  'images/male1.jpg',
  'images/male2.jpg',
  'images/male3.jpg'
];

class proProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic id = ModalRoute.of(context)!.settings.arguments;

    return FutureBuilder<bool>(
      future: Provider.of<ServiceProviderProvider>(context, listen: false)
          .getServiceProviderDetails(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator(
            minHeight: 30,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
              body: SafeArea(
                  child: Consumer<ServiceProviderProvider>(
            builder: (context, serviceProData, child) => Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Color.fromARGB(255, 255, 244, 213),
                      child: ProfileMain(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        serviceProData.serviceProviderData.intro,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      height: 150,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                overviewRow(
                                    FontAwesomeIcons.award, 'Hired 8 times'),
                                overviewRow(
                                    FontAwesomeIcons.locationDot, 'Colombo 03'),
                                overviewRow(FontAwesomeIcons.clock,
                                    '3 years in buisiness'),
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
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Reviews',
                        style: kHeading1,
                      ),
                    ),
                    Container(
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 30),
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
                    if (serviceProData.serviceProviderData.reviews.isNotEmpty)
                      Container(
                        height: 200,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: RawScrollbar(
                          thumbColor: Color.fromARGB(255, 122, 122, 122),
                          radius: Radius.circular(5),
                          thickness: 10,
                          child: ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: serviceProData
                                .serviceProviderData.reviews.length,
                            itemBuilder: (BuildContext context, int index) {
                              final review = serviceProData
                                  .serviceProviderData.reviews[index];
                              return ReviewCard(review: review);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                        ),
                      ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallButton(
                              'More Reviews',
                              () {},
                              const Color.fromARGB(255, 43, 43, 43),
                              Colors.white),
                          SmallButton('Back', () {
                            Navigator.pop(context);
                          }, kMainYellow, Colors.white),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )));
        }
      },
    );
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
        PercentageBar(percentage, 120, 10),
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
    return Consumer<ServiceProviderProvider>(
      builder: (context, serviceProData, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // horizontal, vertical offset
                )
              ],
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
                  serviceProData.serviceProviderData.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (String category
                        in serviceProData.serviceProviderData.category)
                      Container(
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color.fromARGB(255, 244, 222, 222),
                        ),
                        child: Text(
                          textAlign: TextAlign.left,
                          category,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ),
                  ],
                ),
                StarRating(4.5, 25),
                const SizedBox(
                  height: 10,
                ),
                SmallButton('Accept', () {}, kMainYellow, Colors.white)
              ],
            ),
          )
        ],
      ),
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
