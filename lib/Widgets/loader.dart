// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_user/common%20class/color.dart';

class loader {
  // show error; Dialog
  static void showErroDialog(
      {String title = 'Single E-commerce',
      String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
              ),
              Text(
                description ?? '',
                style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                style: ElevatedButton.styleFrom(
                  // backgroundColor: color.Metablue,
                ),
                child: Text(
                  "Ok",
                  style: TextStyle(
                    // color: ,

                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showLoading([String? message]) {
    Get.dialog(
      barrierDismissible: false,
      // useSafeArea: true,
      barrierColor: Colors.transparent,
      Center(
        child: CircularProgressIndicator(
          color: color.Metablue,
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}

class dialogbox {
  static void showDialog(
      {String title = 'Single Resturant',
      String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                description ?? '',
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(color: color.redbutton, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
