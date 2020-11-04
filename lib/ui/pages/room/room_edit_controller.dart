import 'dart:io';

import 'package:flutter/material.dart';

class RoomEditController with ChangeNotifier {
  File selectedImageFile;
  void notifySelectImage(String imagePath) {
    selectedImageFile = File(imagePath);
    notifyListeners();
  }
}
