import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/widgets/FormFieldRegular.dart';
import 'package:hirepro/widgets/HireProAppBar.dart';
import 'package:hirepro/widgets/MainButton.dart';
import 'package:hirepro/widgets/TermsAndPolicy.dart';
import 'package:hirepro/widgets/image_upload.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({super.key});

  @override
  State<ComplaintForm> createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: HireProAppBar(context, "Make a complaint"),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 800,
                child: Column(
                  children: [
                    Form(
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start, children: [
                          Container(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                   const  Row(
                                      children: [
                                        Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        Text(
                                          ' *',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Container(
                                      height: 150, // Set the desired height for the TextField
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      ),
                                      child: SingleChildScrollView(
                                        child: TextField(
                                          controller: textController,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            hintText: 'Enter clear description of the issue',
                                            border: InputBorder.none,
                                          ),
                                          maxLines: null,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft, // Align text to the left
                            child: Text('Images for proof', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          SizedBox(height: 13),
                          UploadImageBox('Upload images here'),
                          SizedBox(height: 20),
                          Container(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MainButton('Add', () {}
                                // {
                                //   signUpUser();
                                //   Navigator.pushNamed(context, '/otp_mobile');
                                // }
                              ),
                            ],
                          ),
                          )
                        ]),
                      ),
                  ],
                ),
              )
          ),
          )
        ));
  }

  void signUpUser() async {
    if (textController.text.isNotEmpty) {
    }
  }
}
