// ignore_for_file: camel_case_types, depend_on_referenced_packages, unused_local_variable

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecommerce_user/Widgets/loader.dart';

class internet {
  static bool isoffline = false;

  // connections();
  conect() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    result == ConnectivityResult.none
        ? Fluttertoast.showToast(
            msg: "Please check internet connection",
            toastLength: Toast.LENGTH_SHORT,
          )
        : null;
    var connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.

      if (result == ConnectivityResult.none) {
        //there is no any connection
        internet.isoffline = false;
        loader.showErroDialog(
          description: "Please check internet connection",
        );
        Fluttertoast.showToast(
          msg: "Please check internet connection",
          toastLength: Toast.LENGTH_SHORT,
        );
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network

        internet.isoffline = true;
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi

        internet.isoffline = true;
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection

        internet.isoffline = true;
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening

        internet.isoffline = true;
      }
    });
  }
}
