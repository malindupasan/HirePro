import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/controllers/task_controller.dart';
import 'package:hire_pro/models/address.dart';
import 'package:hire_pro/providers/address_provider.dart';
import 'package:hire_pro/providers/task_provider.dart';
import 'package:hire_pro/screens/job_request/jobRequest.dart';
import 'package:hire_pro/services/timePicker.dart';
import 'package:hire_pro/services/calander.dart';
import 'package:hire_pro/widgets/MediumButton.dart';
import 'package:hire_pro/widgets/form_field_new.dart';
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
  // final location = TextEditingController();
  String location = '';
  final description = TextEditingController();
  final min = TextEditingController();
  final max = TextEditingController();
  final area = TextEditingController();
  String currentLocation = '';
  String latitude = '';
  String longitude = '';
  bool isChecked = false;
  GoodsProvided? _character = GoodsProvided.No;

  @override
  void dispose() {
    description.dispose();
    min.dispose();
    max.dispose();
    super.dispose();
  }

  JobRequest job = JobRequest();

  late dynamic category;

  final _taskFormKey = GlobalKey<FormState>();
  TaskController taskController = TaskController();
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddressProvider>(context, listen: false).setSelectedAddress();
    });

    category = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          category,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Consumer<AddressProvider>(
                          builder: (context, address, child) => Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FormLabel('Location'),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          isClicked = false;
                                        });
                                      },
                                      child: const Text(
                                        'My addresses',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          isClicked = true;
                                        });
                                        await address.getCurrentLocation();
                                        Navigator.pushNamed(
                                            context, '/set_location');
                                      },
                                      child: const Text(
                                        'Set location',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              if (isClicked)
                                FormFieldNew(10, Icons.location_on, 1,
                                    address.pinAddress, null, (p0) => null),
                              if (!isClicked)
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  width: double.infinity,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey)),
                                    child: DropdownButton<Address>(
                                    
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      dropdownColor: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(10),
                                      
                                      icon: Icon(
                                        Icons.arrow_drop_down_circle,
                                        color: Colors.grey[500],
                                      ),
                                      value: address.selectedAddress,
                                      onChanged: (newValue) {
                                        address
                                            .changeSelectedAddress(newValue!);
                                        address.updateCoordinates(
                                            double.parse(newValue.latitude),
                                            double.parse(newValue.longitude));
                                      },
                                      items: address.addresses
                                          .map<DropdownMenuItem<Address>>(
                                              (Address value) {
                                        return DropdownMenuItem<Address>(
                                          value: value,
                                          child: Text(value.address),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // FormFieldNew(
                        //     5, Icons.location_on, 1, currentLocation, location,
                        //     (value) {
                        //   if (taskController.locationValidate(value) != null) {
                        //     return taskController.locationValidate(value);
                        //   }

                        //   return null;
                        // }),

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
                        const SizedBox(
                          height: 20,
                        ),

                        Toggle(),
                        if (job.isSchedule()) Calander(),
                        if (job.isSchedule()) TimePicker(),
                      ]),
                ),
                Consumer<AddressProvider>(
                  builder: (context, locationData, child) => Row(
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
                                    locationData.selectedAddress.address,
                                    min.text,
                                    max.text,
                                    locationData.getLatitude().toString(),
                                    locationData.getLongitude().toString(),
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
                        Provider.of<TaskProvider>(context, listen: false)
                            .resetFiles();
                        Navigator.pop(context);
                      }, Colors.grey, Colors.white)
                    ],
                  ),
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
