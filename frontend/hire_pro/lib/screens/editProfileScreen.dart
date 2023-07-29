import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/MyNavigationWidget.dart';
import 'package:hire_pro/widgets/FormInput.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/MainCard.dart';
import 'package:hire_pro/widgets/NavButton.dart';
import 'package:hire_pro/widgets/smallButton.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Container(
                      width: 150, // Set the desired width of the container
                      height: 150, // Set the desired height of the container
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Create a circular shape
                        border: Border.all(
                          color: kMainYellow, // Set the border color
                          width: 2, // Set the border width
                        ),
                      ),
                      child: Hero(
                        tag: 'image',
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
                    MainCard(
                        240,
                        335,
                        kMainGrey,
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              EditField(
                                  'Display Name', 'Harini Samaliarachchi'),
                              EditField('Phone Number', '+94 769140020'),
                              EditField(
                                  'Email Address', 'samaliarachchih@gmail.com'),
                            ],
                          ),
                        )),
                    MainButton("Save", () {}),
                  ],
                ),
              ),
            )));
  }
}

class EditField extends StatelessWidget {
  final String label;
  final String value;
  EditField(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: TextStyle(
              color: kMainYellow,
              fontSize: 12,
              overflow: TextOverflow.ellipsis)),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 3,
              child: Text(value,
                  style: TextStyle(
                      fontSize: 15, overflow: TextOverflow.ellipsis))),
          SizedBox(
            width: 10,
          ),
          Expanded(child: SmallButton('Edit', () {}, kMainYellow, Colors.white))
        ],
      )
    ]);
  }
}
