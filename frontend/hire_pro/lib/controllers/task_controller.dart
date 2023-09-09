import 'package:flutter/material.dart';

class TaskController {
  late GlobalKey taskFormKey;

  String? locationValidate(String? location) {
    if (location!.isEmpty) {
      return "Location can't be empty";
    }

    return null;
  }

  String? descriptionValidate(String? description) {
    if (description!.isEmpty) {
      return "Description can't be empty";
    }
    if (description.length > 500) {
      return "Description exceeds it's maximum.";
    }
    return null;
  }

  String? priceValidate(String? price) {
    if (price!.isEmpty) {
      return "This field is required";
    }
    if (!RegExp(r'^\d+$').hasMatch(price)) {
      return "Invalid estimate";
    }
    return null;
  }
  
}
