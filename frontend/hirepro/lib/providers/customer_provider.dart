import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:hirepro/models/customer.dart';
import 'package:hirepro/services/api.dart';
import 'package:hirepro/services/imageUpload.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CustomerProvider extends ChangeNotifier {
  Customer? _customer;
  bool isLoading = false;
  Api api = Api();
  int _code = 0;
  String? _signupId;
  File _image = File('');
  ImageUpload imageUpload = ImageUpload();
  bool _editField = true;
  bool _isImageChanged = false;

  Customer? get customerData => _customer;
  int get verificationCode => _code;
  String get signupId => _signupId!;
  File get image => _image;
  bool get editField => _editField;
  bool get isImageChanged => _isImageChanged;

  void toggleEditField() {
    _editField = !_editField;
    notifyListeners();
  }

  Future<bool> register(name, email, phone, password) async {
    bool status = false;
    Response response = await api.signup(name, phone, email, password);
    Map<String, dynamic> responseObject = jsonDecode(response.body);
    _signupId = responseObject['id'];
    notifyListeners();
    print(signupId);
    if (response.statusCode == 200) {
      status = true;
    }
    return status;
  }

  Future<bool> sendVerifyCode(code) async {
    bool val = false;
    print('entered' + signupId);
    Response response = await api.sendCode(code, signupId);

    if (response.statusCode == 200) {
      print('code sent');
      val = true;
    }
    return val;
  }

  Future<bool> verifyCode(code) async {
    bool response = await api.checkCode(code, signupId);

    return response;
  }

  void updateCode(int code) {
    _code = code;
  }

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

  void changeProfilePicture(ImageSource source) async {
    final file = await imageUpload.pickImage(source);
    if (file != null) {
      final croppedImage =
          await imageUpload.crop(file: file, cropStyle: CropStyle.circle);
      if (croppedImage != null) {
        _image = File(
          croppedImage.path,
        );
        _isImageChanged = true;
        notifyListeners();
      }
    }
  }

  Future<bool> doesFileExist() async {
    try {
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('customer_profile_images/${_customer!.id}.png');
      final firebase_storage.FullMetadata metadata = await ref.getMetadata();
      return true;
    } catch (e) {
      if (e is firebase_storage.FirebaseException &&
          e.code == 'object-not-found') {
        return false;
      }
      print('Error checking file existence: $e');
      return false;
    }
  }

  Future<String> getImageUrl() async {
    try {
      final firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child('customer_profile_images/${_customer!.id}.png');
      final String downloadURL = await ref.getDownloadURL();
      _image = File(downloadURL);
      notifyListeners();
      return downloadURL;
    } catch (e) {
      print('Error retrieving image from Firebase Storage: $e');
      return '';
    }
  }

  Future<bool> uploadProfilePicture() async {
    if (_image.path == '') {
      print('no image selected');
      return false;
    }

    try {
      if (await doesFileExist()) {
        final firebase_storage.Reference previousRef = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('customer_profile_images/${_customer!.id}.png');
        await previousRef.delete();
      }

      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('customer_profile_images/${_customer!.id}.png');
      print(_image.path);
      await storageRef.putFile(_image);
      _isImageChanged = false;
      notifyListeners();
      return true;
    } catch (error) {
      print('Error uploading file: $error');
    }
    return false;
  }
}
