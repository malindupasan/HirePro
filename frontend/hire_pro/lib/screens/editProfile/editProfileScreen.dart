import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/models/customer.dart';
import 'package:hire_pro/services/api.dart';
import 'package:hire_pro/services/imageUpload.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/smallButton.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

String jsondata =
    '{"full_name": "John Doe", "email": "samaliarachchih@gmail.com", "phone_number": "123-456-7890"}';
var userData = jsonDecode(jsondata);

class _EditProfileState extends State<EditProfile> {
  final keyCounter = GlobalKey<_EditFieldState>();
  String defaultImage = 'images/profile_pic.png';
  final imageUpload = ImageUpload();
  File? _image;
  void changeProfilePicture(ImageSource source) async {
    final file = await imageUpload.pickImage(source);
    if (file != null) {
      final croppedImage =
          await imageUpload.crop(file: file, cropStyle: CropStyle.circle);
      if (croppedImage != null) {
        setState(() {
          _image = File(
            croppedImage.path,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Api api = Api();
    return SafeArea(
        child: Scaffold(
            // bottomNavigationBar: BottomNavBar(),
            resizeToAvoidBottomInset: false,
            body: FutureBuilder(
                future: api.getUser(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    Center(
                      child: CircularProgressIndicator(color: kMainYellow),
                    );
                  }
                  // Customer customer = snapshot.data;

                  return SingleChildScrollView(
                    child: Center(
                      child: Container(
                        height: 700,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
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
                                          foregroundImage: _image != null
                                              ? FileImage(_image!)
                                              : null,
                                          child: Text(
                                            'HS',
                                            style: TextStyle(
                                                fontSize: 48,
                                                color: kMainYellow),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  left: 105,
                                  child: FloatingActionButton.small(
                                      backgroundColor: kMainYellow,
                                      child: Icon(
                                        FontAwesomeIcons.camera,
                                        size: 15,
                                      ),
                                      onPressed: () => showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Popup(),
                                          )),
                                ),
                              ],
                            ),
                            Text(
                              'Edit Account',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            Column(
                              children: [
                                EditField(
                                    key: keyCounter,
                                    label: 'Full Name',
                                    value: "Harini",
                                    edit: () {
                                      setState(() {
                                        keyCounter.currentState!.editField =
                                            !keyCounter.currentState!.editField;
                                      });
                                    }),
                                EditField(
                                    label: 'Email',
                                    value: 'samaliarachchih@gmail.com',
                                    edit: () {
                                      Navigator.pushNamed(
                                          context, '/emailcoderequest',
                                          arguments: userData['email']);
                                    }),
                                EditField(
                                    label: 'Mobile Number',
                                    value: '0761232323',
                                    edit: () {
                                      print('pressed');
                                    }),
                                EditField(
                                    label: 'Password',
                                    value: 'hariniU',
                                    edit: () {
                                      Navigator.pushNamed(
                                          context, '/change_password');
                                    }),
                              ],
                            ),
                            MainButton("Save", () {}),
                          ],
                        ),
                      ),
                    ),
                  );
                })));
  }

  AlertDialog Popup() {
    return AlertDialog(
      title: const Text(
        'Change profile picture using,',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      content: const Text(''),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SmallButton('Camera', () async {
              changeProfilePicture(ImageSource.camera);
            }, kMainYellow, Colors.white),
            SmallButton('Gallery', () async {
              changeProfilePicture(ImageSource.gallery);
            }, kMainYellow, Colors.white)
          ],
        )
      ],
    );
  }
}

class EditField extends StatefulWidget {
  final String label;
  final String value;
  final VoidCallback edit;

  EditField(
      {super.key,
      required this.label,
      required this.value,
      required this.edit});

  @override
  State<EditField> createState() => _EditFieldState();
}

class _EditFieldState extends State<EditField> {
  bool editField = true;
  bool password = false;

  void isPassword() {
    if (widget.label == 'Password') {
      setState(() {
        password = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    isPassword();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 6),
        Stack(
          children: [
            TextFormField(
              obscureText: password,
              readOnly: editField,
              initialValue: widget.value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Positioned(
              left: 280,
              top: 10,
              child: SizedBox(
                height: 30,
                child: FloatingActionButton.small(
                  onPressed: widget.edit,
                  backgroundColor: kSecondaryYellow,
                  child: Icon(
                    FontAwesomeIcons.pen,
                    color: Colors.grey[800],
                    size: 12,
                  ),
                  elevation: 1,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
      ],
    );
  }
}
