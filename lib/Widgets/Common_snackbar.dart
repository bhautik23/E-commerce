// ignore_for_file: file_names, unnecessary_string_interpolations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Showsnackbar {
  Showsnackbar(SnackBar snackBar);

  static void error(String error) {
    Get.snackbar(
      'Error',
      '$error',
      duration: Duration(seconds: 4),
      backgroundColor: Colors.black,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
}
