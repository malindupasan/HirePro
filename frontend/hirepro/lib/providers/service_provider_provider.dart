import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hirepro/models/service_provider.dart';
import 'package:hirepro/services/api.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ServiceProviderProvider extends ChangeNotifier {
  late ServiceProvider _serviceProvider;
  Api api = Api();
  String _imageUrl = '';
  String get imageUrl => _imageUrl;
  ServiceProvider get serviceProviderData => _serviceProvider;
  bool isLoading = false;
  Future<bool> getServiceProviderDetails(serviceProviderId) async {
    final response = await api.getServiceProviderData(serviceProviderId);
    _serviceProvider = response;

    if (response.id.isNotEmpty) {
      print(response.id);
      return true;
    }
    return false;
  }

  Future<String> getImageUrl(id) async {
    try {
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('serviceProvider/profilePicture/$id');
      final String downloadURL = await ref.getDownloadURL();

      _imageUrl = downloadURL;
      if (_imageUrl.isNotEmpty) {
        return downloadURL;
      }

      notifyListeners();
      return downloadURL;
    } catch (e) {
      print('Error retrieving image from Firebase Storage: $e');
      return '';
    }
  }
}
