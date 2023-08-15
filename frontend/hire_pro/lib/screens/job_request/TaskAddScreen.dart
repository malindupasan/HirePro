import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hire_pro/env.dart';
import 'package:hire_pro/models/address.dart';
import 'package:hire_pro/widgets/radioButton.dart';
import 'package:hire_pro/screens/job_request/jobRequest.dart';
import 'package:hire_pro/services/timePicker.dart';
import 'package:hire_pro/services/calander.dart';

enum SingingCharacter { lafayette, jefferson }

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({super.key});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  JobRequest job = JobRequest();
  String _selectedOption = '';
  List<String> _options = [
    'Yes',
    'No',
  ];
  List<PlatformFile> files = [];
  late dynamic category;
  void openFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png']);

    if (result != null) {
      setState(() {
        files = result.paths
            .map((path) => PlatformFile(
                  path: path,
                  name: id + '_' + category + '_' + DateTime.now().toString(),
                  size: 0, // Provide a default size (e.g., 0 bytes)
                ))
            .toList();
      });

      print(files);
      final file = File(files[0].path.toString());
    } else {
      // User canceled the picker
      // Handle the cancelation or provide appropriate code here
    }
  }

  @override
  Widget build(BuildContext context) {
    category = ModalRoute.of(context)!.settings.arguments;
    print(category);
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(
          'Enter Task Details',
          style: kHeading1,
        ),
        FormLabel('Location'),
        FormFieldNew(
          10,
          Icons.location_on,
          1,
          '',
          'Enter the location',
        ),
        FormLabel('Description'),
        FormFieldNew(
          10,
          Icons.description,
          5,
          '',
          'Ex: I have to repair my ...',
        ),
        FormLabel('Goods Provided'),
        RadioExample(),
        FormLabel('Enter Price Estimate'),
        Row(
          children: [
            Expanded(
                child: FormFieldNew(20, Icons.monetization_on, 1, '', 'min')),
            Expanded(
                child: FormFieldNew(20, Icons.monetization_on, 1, '', 'max')),
          ],
        ),
        FormLabel('Upload Photos'),
        FileUpload(),
        SizedBox(
          height: 20,
        ),
        if (files.isNotEmpty)
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            height: (files.length * 80 + 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Images',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: files.length,
                  itemBuilder: (BuildContext context, int index) {
                    String filename = files[index].name;

                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: const Color.fromARGB(255, 151, 151, 151),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Color.fromARGB(255, 246, 245, 244),
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.image,
                          color: Colors.black,
                        ),
                        title: Text(
                          filename,
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        Toggle(),
        if (job.isSchedule()) Calander(),
        if (job.isSchedule()) TimePicker(),
      ]),
    );
  }

  Container FileUpload() {
    return Container(
      height: 120,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: RawMaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.5)),
        fillColor: Colors.grey[200],
        onPressed: () {
          openFiles();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.upload_file,
              size: 75,
            ),
            Text("Upload here"),
          ],
        ),
      ),
    );
  }

  Container Toggle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ToggleButtons(
        direction: Axis.horizontal,
        onPressed: (int index) {
          setState(() {
            job.selectJobType(index);
          });
        },
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        selectedBorderColor: kMainYellow,
        selectedColor: kMainYellow,
        fillColor: kSecondaryYellow,
        color: Colors.black,
        constraints: const BoxConstraints(
          minHeight: 40.0,
          minWidth: 80.0,
        ),
        isSelected: job.selected(),
        children: job.type(),
      ),
    );
  }
}

class FormLabel extends StatelessWidget {
  final String label;
  FormLabel(this.label);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Text(
          label,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class FormFieldNew extends StatelessWidget {
  FormFieldNew(this.borderRadius, this.icon, this.lines, this.initialValue,
      this.placeholder);
  final double borderRadius;
  final int lines;
  final IconData icon;
  final String initialValue;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextFormField(
            initialValue: initialValue,
            style: TextStyle(fontSize: 14),
            maxLines: lines,
            cursorColor: Colors.blueGrey[700],
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(borderRadius)),
              hoverColor: Colors.blueGrey[700],
              hintText: placeholder,
              hintStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius)),
              focusColor: Colors.grey,
              suffixIcon: Icon(
                icon,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
