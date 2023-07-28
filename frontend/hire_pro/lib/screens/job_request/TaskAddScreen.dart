import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hire_pro/screens/job_request/jobRequest.dart';
import 'package:hire_pro/services/timePicker.dart';
import 'package:hire_pro/services/calander.dart';

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
  void openFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    List<PlatformFile> files =
        []; // Declare the 'files' list outside the if block

    if (result != null) {
      files = result.paths
          .map((path) => PlatformFile(
                path: path,
                name: 'default_filename', // Provide a default filename
                size: 0, // Provide a default size (e.g., 0 bytes)
              ))
          .toList();
    } else {
      // User canceled the picker
      // Handle the cancelation or provide appropriate code here
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        // Container(
        //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //     alignment: Alignment.centerLeft,
        //     child: GestureDetector(
        //       child: Icon(Icons.arrow_back),
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //     )),
        Text(
          'Enter Task Details',
          style: kHeading1,
        ),
        FormLabel('Location'),
        FormFieldNew(
          10,
          Icons.location_on,
          1,
          'Default Address',
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
        RadioButton(_options, _selectedOption),
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
        Toggle(),
        if (job.isSchedule()) Calander(),
        if (job.isSchedule()) TimePicker(),
        // Container(
        //     alignment: Alignment.bottomRight,
        //     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        //     child: SmallButton(
        //       'Submit',
        //       () {
        //         Navigator.pushNamed(context, '/confirm_job_request');
        //       },
        //       kMainYellow,
        //       Colors.white,
        //     ))
      ]),
    );
  }

  Row RadioButton(List<String> _options, String _selectedOption) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _options.map((option) {
        return Row(
          children: [
            Radio<String>(
              value: option,
              groupValue: _selectedOption,
              onChanged: (selectedOption) {
                setState(() {
                  if (selectedOption != null) _selectedOption = selectedOption;
                });
              },
              activeColor: kMainYellow,
            ),
            Text(option),
          ],
        );
      }).toList(),
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
