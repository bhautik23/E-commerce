// ignore_for_file: file_names, constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Themesharedprefrences {
  static const PREF_KEY = "prefrences";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(PREF_KEY, value);
  }

  getTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(PREF_KEY) ?? false;
  }
}
