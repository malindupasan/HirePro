import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/models/customer.dart';
import 'package:hire_pro/services/api.dart';
import 'package:hire_pro/services/imageUpload.dart';
import 'package:hire_pro/services/routes.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/smallButton.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    super.dispose();
  }

  // Future<Customer>? _name;
  Api api = Api();

  late Future<Customer> customer;
  void initState() {
    super.initState();
    customer = api.getData();
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

  bool editField = false;

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
            resizeToAvoidBottomInset: false,
            body: FutureBuilder<Customer>(
                future: customer,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    nameController.text = snapshot.data!.name;
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
                                              getInitials(snapshot.data!.name),
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Full Name',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Stack(
                                        children: [
                                          TextFormField(
                                            controller: nameController,
                                            readOnly: editField,
                                            // initialValue: snapshot.data!.name,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 280,
                                            top: 10,
                                            child: SizedBox(
                                              height: 30,
                                              child: FloatingActionButton.small(
                                                onPressed: () {
                                                  setState(() {
                                                    editField = !editField;
                                                  });
                                                },
                                                backgroundColor:
                                                    kSecondaryYellow,
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
                                  ),
                                  EditField(
                                      label: 'Email',
                                      value: snapshot.data!.email,
                                      edit: () {
                                        Navigator.pushNamed(
                                            context, '/emailcoderequest',
                                            arguments: snapshot.data!.email);
                                      }),
                                  EditField(
                                      label: 'Mobile Number',
                                      value: snapshot.data!.contact,
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
                              MainButton("Save", () async {
                                if (nameController.text !=
                                    snapshot.data!.name) {
                                  await api.changeName(nameController.text);
                                  Navigator.pop(context, true);
                                } else {
                                  Navigator.pop(context);
                                }
                              })
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Center(
                    child: CircularProgressIndicator(color: kMainYellow),
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
