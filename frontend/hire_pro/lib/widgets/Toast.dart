import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class Toast {
  late String successtitle;
  late String successdescription;

  MotionToast SuccessToast(successtitle, successdescription) {
    return MotionToast.success(
      title: Text(successtitle),
      description: Text(successdescription),
    );
  }
}
