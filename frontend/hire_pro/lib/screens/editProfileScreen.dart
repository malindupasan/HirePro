import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/services/imageUpload.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/smallButton.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
                    Stack(
                      children: [
                        Container(
                          width: 150, // Set the desired width of the container
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
                                        fontSize: 48, color: kMainYellow),
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
                                        AlertDialog(
                                      title: const Text(
                                        'Change profile picture using,',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      content: const Text(''),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SmallButton('Camera', () async {
                                              changeProfilePicture(
                                                  ImageSource.camera);
                                            }, kMainYellow, Colors.white),
                                            SmallButton('Gallery', () async {
                                              changeProfilePicture(
                                                  ImageSource.gallery);
                                            }, kMainYellow, Colors.white)
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                        ),
                      ],
                    ),
                    Text(
                      'Edit Account',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Column(
                      children: [
                        EditField('Full Name', 'Harini Samaliarachchi'),
                        EditField('Email', 'samaliarachchih@gmail.com'),
                        EditField('Mobile Number', '0761232323'),
                        EditField('Password', ''),
                      ],
                    ),
                    MainButton("Save", () {}),
                  ],
                ),
              ),
            )));
  }
}

class EditField extends StatelessWidget {
  String label;
  String value;
  EditField(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 6),
      ],
    );
  }
}
