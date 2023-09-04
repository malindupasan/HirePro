import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/controllers/user_controller.dart';
import 'package:hire_pro/providers/customer_provider.dart';
import 'package:hire_pro/services/api.dart';
import 'package:hire_pro/services/imageUpload.dart';
import 'package:hire_pro/widgets/HireProAppBar.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/smallButton.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

String profilePic = '';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Api api = Api();
  UserController user = UserController();

  void initState() {
    super.initState();
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
          profilePic = croppedImage.path;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: HireProAppBar(context, 'Edit Profile'),
            resizeToAvoidBottomInset: false,
            body:
                Consumer<CustomerProvider>(builder: (context, customer, child) {
              nameController.text = customer.customerData!.name;
              return SingleChildScrollView(
                child: RawScrollbar(
                  thumbColor: Colors.grey,
                  thickness: 5,
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
                                          user.getInitials(
                                              customer.customerData!.name),
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
                                              Popup(),
                                        )),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        left: 270,
                                        top: 10,
                                        child: SizedBox(
                                          height: 30,
                                          child: FloatingActionButton.small(
                                            onPressed: () {
                                              setState(() {
                                                editField = !editField;
                                              });
                                            },
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
                              ),
                              EditField(
                                  label: 'Email',
                                  value: customer.customerData!.email,
                                  edit: () {
                                    Navigator.pushNamed(
                                        context, '/emailcoderequest',
                                        arguments:
                                            customer.customerData!.email);
                                  }),
                              EditField(
                                  label: 'Mobile Number',
                                  value: customer.customerData!.contact,
                                  edit: () {
                                    print('pressed');
                                  }),
                              EditField(
                                  label: 'Password',
                                  value: 'DummyPassword',
                                  edit: () {
                                    Navigator.pushNamed(
                                        context, '/change_password');
                                  }),
                            ],
                          ),
                          MainButton("Save", () async {
                            if (nameController.text !=
                                customer.customerData!.name) {
                              customer.changeName(nameController.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Changes saved successfully!')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('No changes to save')),
                              );
                            }
                          })
                        ],
                      ),
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
              left: 270,
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
