import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_pro/controllers/user_controller.dart';
import 'package:hire_pro/models/address.dart';
import 'package:hire_pro/providers/address_provider.dart';
import 'package:hire_pro/providers/customer_provider.dart';
import 'package:hire_pro/services/api.dart';
import 'package:hire_pro/widgets/HireProAppBar.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Api api = Api();
  UserController user = UserController();

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddressProvider>(context, listen: false).getAllAddresses();
     
      Provider.of<CustomerProvider>(context, listen: false).getCustomerData();
    });
    super.initState();
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
                  child: Center(
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Consumer<CustomerProvider>(
                                        builder: (context, customer, child) {
                                      return Column(
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
                                                    backgroundColor: kMainGrey,
                                                    child: Text(
                                                      user.getInitials(customer
                                                          .customerData!.name),
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
                                            customer.customerData!.name,
                                            style: const TextStyle(
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
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/edit_profile');
                                                }),
                                          ),
                                          RatingBarIndicator(
                                            rating: 3.35,
                                            itemBuilder: (context, index) =>
                                                const Icon(
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
                                                  customer.customerData!
                                                      .loyalityPoints,
                                                  'Loyality points')
                                            ],
                                          )
                                        ],
                                      );
                                    })),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      width: double.infinity,
                                      margin: EdgeInsetsDirectional.symmetric(
                                          horizontal: 10, vertical: 30),
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
                                                    BorderRadius.circular(10),
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
                                              child: Consumer<AddressProvider>(
                                                builder: (context, addressList,
                                                        child) =>
                                                    Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
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
                                                                  fontSize: 17,
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
                                                                          () async{
                                                                       await addressList
                                                                            .getCurrentLocation();
                                                                        Navigator.pushNamed(
                                                                            context,
                                                                            '/add_address');
                                                                      }),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    AddressList(
                                                        addresses: addressList
                                                            .addresses),
                                                  ],
                                                ),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          MainButton('Sign out', () {
                                            //  signout();
                                          }),
                                        ],
                                      ),
                                    ))
                              ])))),
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
