import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/controllers/task_controller.dart';
import 'package:hire_pro/providers/task_provider.dart';
import 'package:hire_pro/screens/job_request/jobRequest.dart';
import 'package:hire_pro/services/timePicker.dart';
import 'package:hire_pro/services/calander.dart';
import 'package:hire_pro/widgets/image_upload.dart';
import 'package:hire_pro/widgets/smallButton.dart';
import 'package:hire_pro/widgets/stepper_bar.dart';
import 'package:provider/provider.dart';

enum GoodsProvided { Yes, No }

String formGoods = '';
DateTime? calanderDate;
TimeOfDay? formselectedTime;
GoodsProvided? formbool = GoodsProvided.No;

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
  GoodsProvided? _character = GoodsProvided.No;

  @override
  void dispose() {
    location.dispose();
    description.dispose();
    min.dispose();
    max.dispose();
    super.dispose();
  }

  JobRequest job = JobRequest();

  late dynamic category;

  final _taskFormKey = GlobalKey<FormState>();
  TaskController taskController = TaskController();

  @override
  Widget build(BuildContext context) {
    category = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NewStepper(kMainYellow, Colors.grey, Colors.grey),
                Form(
                  key: _taskFormKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Task Details',
                          style: kHeading1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          category,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        FormLabel('Location'),
                        FormFieldNew(5, Icons.location_on, 1, '', location,
                            (value) {
                          if (taskController.locationValidate(value) != null) {
                            return taskController.locationValidate(value);
                          }

                          return null;
                        }),
                        if (category == 'Lawn Mowing')
                          Column(
                            children: [
                              FormLabel('Land Area (sq. meters)'),
                              FormFieldNew(5, Icons.grass_sharp, 1, '', area,
                                  (value) {
                                if (taskController.priceValidate(value) !=
                                    null) {
                                  return taskController.priceValidate(value);
                                }

                                return null;
                              }),
                            ],
                          ),
                        FormLabel('Description'),
                        FormFieldNew(5, Icons.description, 5, '', description,
                            (value) {
                          if (taskController.descriptionValidate(value) !=
                              null) {
                            return taskController.descriptionValidate(value);
                          }

                          return null;
                        }),
                        FormLabel('Goods Provided'),
                        RadioExample(
                          character: _character,
                        ),
                        FormLabel('Enter Price Estimate'),
                        Row(
                          children: [
                            Expanded(
                                child: FormFieldNew(
                                    10, Icons.monetization_on, 1, 'min', min,
                                    (value) {
                              if (taskController.priceValidate(value) != null) {
                                return taskController.priceValidate(value);
                              }

                              return null;
                            })),
                            Expanded(
                                child: FormFieldNew(
                                    10, Icons.monetization_on, 1, 'max', max,
                                    (value) {
                              if (taskController.priceValidate(value) != null) {
                                return taskController.priceValidate(value);
                              }

                              return null;
                            })),
                          ],
                        ),
                        FormLabel('Upload Photos'),
                        // FileUpload(),
                        UploadImageBox("Upload Images Here"),
                        SizedBox(
                          height: 20,
                        ),

                        Toggle(),
                        if (job.isSchedule()) Calander(),
                        if (job.isSchedule()) TimePicker(),
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallButton('Continue', () {
                      if (_taskFormKey.currentState!.validate()) {
                        if (category == "Lawn Mowing") {
                          Provider.of<TaskProvider>(context, listen: false)
                              .taskCategory = category;
                          Provider.of<TaskProvider>(context, listen: false)
                              .initialize();
                          Provider.of<TaskProvider>(context, listen: false)
                              .createLawnMowingTask(
                                  area.text,
                                  description.text,
                                  location.text,
                                  min.text,
                                  max.text,
                                  '0',
                                  '0',
                                  calanderDate.toString(),
                                  formselectedTime.toString(),
                                  job.isSchedule());
                        }

                        Navigator.pushNamed(context, '/confirm_job_request');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor:
                                  Color.fromARGB(255, 247, 141, 141),
                              content:
                                  Text('Please fill the details properly.')),
                        );
                      }
                    }, kMainYellow, Colors.white),
                    SmallButton('Back', () {
                      Navigator.pop(context);
                    }, Colors.grey, Colors.white)
                  ],
                )
              ],
            ),
          ),
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
      this.controller, this.function);
  final double borderRadius;
  final int lines;
  final IconData icon;
  final String? Function(String?)? function;
  final String placeholder;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextFormField(
            validator: function,
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
  GoodsProvided? character;
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
            leading: Radio<GoodsProvided>(
              activeColor: kMainYellow,
              value: GoodsProvided.No,
              groupValue: widget.character,
              onChanged: (GoodsProvided? value) {
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
            leading: Radio<GoodsProvided>(
              activeColor: kMainYellow,
              value: GoodsProvided.Yes,
              groupValue: widget.character,
              onChanged: (GoodsProvided? value) {
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
