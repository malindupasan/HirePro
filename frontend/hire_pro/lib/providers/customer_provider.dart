import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hire_pro/models/customer.dart';
import 'package:hire_pro/services/api.dart';
import 'package:hire_pro/services/imageUpload.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CustomerProvider extends ChangeNotifier {
  late Customer? _customer;
  final imageUpload = ImageUpload();

  bool isLoading = false;
  Api api = Api();

  Customer get customerData => _customer!;
  Future<void> getCustomerData() async {
    isLoading = true;
    notifyListeners();
    final response = await api.getData();
    _customer = response;
    isLoading = false;
    notifyListeners();
  }

  void changeName(String name) async {
    isLoading = true;
    notifyListeners();
    _customer?.name = name;
    await api.changeName(name);
    isLoading = false;
    notifyListeners();
  }
  // void changeProfilePicture(ImageSource source) async {
  //   final file = await imageUpload.pickImage(source);
  //   if (file != null) {
  //     final croppedImage =
  //         await imageUpload.crop(file: file, cropStyle: CropStyle.circle);
  //     if (croppedImage != null ) {
  //       _customer.image = File(
  //         croppedImage.path,
  //       );
  //       notifyListeners();
  //     }
  //   }
  // }
}
