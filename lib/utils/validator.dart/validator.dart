// ignore_for_file: prefer_is_empty, unused_local_variable, unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';

class Validators {
  static String? validateName(String value, String type) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "$type is Required";
    } else if (!regExp.hasMatch(value)) {
      return "$type must be a-z and A-Z";
    }
    return null;
  }

  static String? validateRequired(String value, String type) {
    if (value.length == 0) {
      return "$type is Required";
    }
    return null;
  }

  static String? validateempty(String value, String type) {
    if (value.length == 0) {
      loader.showErroDialog(description: type);
    }
    return null;
  }

  static String? validateOtp(String value) {
    String pattern = '';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Enter Otp";
    }
    return null;
  }

  static String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Phone number is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Phone number is not valid";
    }
    return null;
  }

  static String? validateCountryCode(String value) {
    String pattern = r'(^\d{0,3}$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Country code is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Country Code is not valid";
    }
    return null;
  }

  static String? validateEmail(
    String value,
  ) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.length <= 0) {
      return LocaleKeys.Please_enter_valid_email_address.tr();
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    String pattern =
        r'^.*(?=.{8,})((?=.*[!@#$%^&*()\-_=+{};:,<.>]){1})(?=.*\d)((?=.*[a-z]){1})((?=.*[A-Z]){1}).*$';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Password is Required";
    }
    //  else if (!regExp.hasMatch(value)) {
    //   return "Minimum 8 characters password required\nwith a combination of uppercase and lowercase letter and number are required.";
    // }
    else {
      return null;
    }
  }

  String? validateDate(String value) {
    String pattern = r'([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Date is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter valid date";
    }
    return null;
  }

  static String? validatefirstName(
    String value,
  ) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "First name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "First name must be a-z and A-Z";
    }
    return null;
  }

  static String? validatelastName(
    String value,
  ) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Last name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Last name must be a-z and A-Z";
    }
    return null;
  }

  static String? validatemessage(
    String value,
  ) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Last name is Required";
    }
    return null;
  }

  static String? validatecardno(
    String value,
  ) {
    if (value.isEmpty || value.length < 16) {
      return "invalid card no";
    } else {
      return null;
    }
  }

  static String? validatecardexpirmonth(
    String value,
  ) {
    if (value.isEmpty || value.length < 2 || value.length > 2) {
      return "Invalid Month";
    } else {
      return null;
    }
  }

  static String? validatecardexpiryear(
    String value,
  ) {
    if (value.isEmpty || value.length < 4 || value.length > 4) {
      return "Invalid Year";
    } else {
      return null;
    }
  }

  static String? validatecardcvv(
    String value,
  ) {
    if (value.isEmpty || value.length < 3 || value.length > 3) {
      return "Invalid Year";
    } else {
      return null;
    }
  }
}
