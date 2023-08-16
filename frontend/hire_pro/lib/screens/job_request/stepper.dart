import 'package:flutter/material.dart';
import 'package:hire_pro/screens/job_request/TaskAddScreen.dart';
import 'package:hire_pro/screens/job_request/confirmationScreen.dart';
import 'package:hire_pro/screens/job_request/searchingPros.dart';

import '../../services/api.dart';

class JobRequestScreen extends StatefulWidget {
  const JobRequestScreen({super.key});

  @override
  State<JobRequestScreen> createState() => _JobRequestScreenState();
}

class _JobRequestScreenState extends State<JobRequestScreen> {
  int currentStep = 0;
  Api api = Api();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // resizeToAvoidBottomInset: false,
            body: Stepper(
                elevation: 0,
                type: StepperType.horizontal,
                currentStep: currentStep,
                onStepContinue: () {
                  setState(() {
                    if (currentStep == 1) {
                      api.addLawnMowingTask();
                      currentStep += 1;
                    } else if (currentStep == 2) {
                      Navigator.pushNamed(context, '/biddings');
                    } else {
                      currentStep += 1;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep == 0) {
                      Navigator.pop(context);
                    } else {
                      currentStep -= 1;
                    }
                  });
                },
                steps: getSteps())));
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: Text('Task'),
          content: TaskAddScreen(),
        ),
        Step(
            isActive: currentStep >= 1,
            title: Text('Confirm'),
            content: ConfirmationScreen()),
        Step(
            isActive: currentStep >= 2,
            title: Text('Bidding'),
            content: SearchingPros())
      ];
}
