import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hire_pro/env.dart';
import 'package:hire_pro/screens/job_request/jobRequest.dart';
import 'package:hire_pro/services/timePicker.dart';
import 'package:hire_pro/services/calander.dart';
import 'package:hire_pro/widgets/smallButton.dart';

enum SingingCharacter { Yes, No }

String? formLocation;
String? formDescription;
String? formMin;
String? formMax;
String? formGoods;
DateTime? calanderDate;
TimeOfDay? formselectedTime;
late String globalCategory;
String? formArea;
SingingCharacter? formbool = SingingCharacter.No;

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({super.key});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final location = TextEditingController();
  final description = TextEditingController();
  final min = TextEditingController();
  final max = TextEditingController();
  final area = TextEditingController();
  bool isChecked = false;
  SingingCharacter? _character = SingingCharacter.No;

  @override
  void dispose() {
    location.dispose();
    description.dispose();
    min.dispose();
    max.dispose();
    super.dispose();
  }

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

  void updateValues() {
    formLocation = location.text;
    formDescription = description.text;
    formMax = max.text;
    formMin = min.text;
    formArea = area.text;
  }

  @override
  Widget build(BuildContext context) {
    category = ModalRoute.of(context)!.settings.arguments;

    globalCategory = category;

    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(
          'Enter Task Details',
          style: kHeading1,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          category,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        FormLabel('Location'),
        FormFieldNew(5, Icons.location_on, 1, '', location),
        if (category == 'Lawn Mowing')
          Column(
            children: [
              FormLabel('Land Area (sq. meters)'),
              FormFieldNew(5, Icons.grass_sharp, 1, '', area),
            ],
          ),
        FormLabel('Description'),
        FormFieldNew(5, Icons.description, 5, '', description),
        FormLabel('Goods Provided'),
        RadioExample(
          character: _character,
        ),
        FormLabel('Enter Price Estimate'),
        Row(
          children: [
            Expanded(
                child: FormFieldNew(10, Icons.monetization_on, 1, 'min', min)),
            Expanded(
                child: FormFieldNew(10, Icons.monetization_on, 1, 'max', max)),
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
        Row(
          children: [
            Checkbox(
                value: isChecked,
                activeColor: kMainYellow,
                onChanged: (value) {
                  setState(() {
                    isChecked = !isChecked;
                    updateValues();
                  });
                }),
            Text(
              "I agree that the information provided above is accurate.",
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ]),
    );
  }

  Container FileUpload() {
    return Container(
      height: 120,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
  FormFieldNew(this.borderRadius, this.icon, this.lines, this.placeholder,
      this.controller);
  final double borderRadius;
  final int lines;
  final IconData icon;

  final String placeholder;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextFormField(
            style: TextStyle(fontSize: 14),
            maxLines: lines,
            cursorColor: Colors.blueGrey[700],
            controller: controller,
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

class RadioExample extends StatefulWidget {
  SingingCharacter? character;
  RadioExample({
    super.key,
    this.character,
  });

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: const Text('No'),
            leading: Radio<SingingCharacter>(
              activeColor: kMainYellow,
              value: SingingCharacter.No,
              groupValue: widget.character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  widget.character = value;
                  formbool = value;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('Yes'),
            leading: Radio<SingingCharacter>(
              activeColor: kMainYellow,
              value: SingingCharacter.Yes,
              groupValue: widget.character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  widget.character = value;
                  formbool = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
