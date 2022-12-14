// ignore_for_file: file_names

import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:ecommerce_user/Theme/Theme_shared_pref.dart';

class ThemeModel extends ChangeNotifier {
  late bool _isdark;
  late Themesharedprefrences themesharedprefrences;
  bool get isdark => _isdark;

  ThemeModel(Brightness dark) {
    _isdark = false;
    themesharedprefrences = Themesharedprefrences();
    getThemeprefrences();
  }

  set isDark(bool value) {
    _isdark = value;
    themesharedprefrences.setTheme(value);
    notifyListeners();
  }

  getThemeprefrences() async {
    _isdark = await themesharedprefrences.getTheme(_isdark);
    notifyListeners();
  }
}
