// ignore_for_file: prefer_final_fields, file_names, non_constant_identifier_names, use_build_context_synchronously, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, avoid_print, unused_field
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_user/Model/favoritepage/addtocartmodel.dart';
import 'package:ecommerce_user/Model/otpsucessdata.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/pages/Home/Homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:ecommerce_user/utils/validator.dart/validator.dart';
import 'package:sizer/sizer.dart';

class Otp extends StatefulWidget {
  String? emailno;

  @override
  State<Otp> createState() => _OtpState();
  Otp([this.emailno]);
}

class _OtpState extends State<Otp> {
  final otp = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  otpsuccessdata? userdata;

  _Otpverify() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String logintype = prefs.getString(App_check_addons)!;
    try {
      loader.showLoading();
      var map = logintype == 'mobile'
          ? {
              "mobile": widget.emailno,
              "otp": otp.text.toString(),
              "token": Googletoken,
            }
          : {
              "email": widget.emailno,
              "otp": otp.text.toString(),
              "token": "cdccdcdcddcfdvbfdvbfgbgf"
            };
      print(map);
      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.otpverify, data: map);
      print(response);
      var finaluserdata = await response.data;
      userdata = otpsuccessdata.fromJson(finaluserdata);
      loader.hideLoading();
      if (userdata!.status == 0) {
        loader.showErroDialog(description: userdata!.message);
      } else if (userdata!.status == 1) {
        prefs.setString(UD_user_id, userdata!.data!.id.toString());
        prefs.setString(UD_user_name, userdata!.data!.name.toString());
        prefs.setString(UD_user_email, userdata!.data!.email.toString());
        prefs.setString(UD_user_mobile, userdata!.data!.mobile.toString());
        prefs.setString(
            UD_user_logintype, userdata!.data!.loginType.toString());
        prefs.setString(
            UD_user_profileimage, userdata!.data!.profileImage.toString());
        prefs.setString(
            UD_user_refer_code, userdata!.data!.referralCode.toString());

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage(0)),
        );
      }
    } catch (e) {
      loader.showErroDialog(description: e.toString());
      print(e);
    }
  }

  addtocartmodel? data;

  resendOTP() async {
    loader.showLoading();
    var map = {
      "email": widget.emailno,
    };
    var response =
        await Dio().post(DefaultApi.appUrl + PostAPI.resendotp, data: map);

    addtocartmodel data = addtocartmodel.fromJson(response.data);
    loader.hideLoading();
    if (data.status == 1) {
      loader.showErroDialog(description: data.message);
    } else {
      loader.showErroDialog(description: data.message);
    }
  }

  int _start = 120;
  bool isresend = false;
  Timer? _timer;
  String? Googletoken;
  @override
  void initState() {
    super.initState();
    startTimer();
    token();
  }

  token() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      print(token);
      Googletoken = token!;
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            isresend = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black,
                  size: 20,
                )),
            leadingWidth: 40,
          ),
          body: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                  top: 1.5.h,
                )),
                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 4.w, top: 3.h, bottom: 1.h),
                    child: Text(LocaleKeys.OTP_Verification.tr(),
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Poppins_Bold',
                        ))),
                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      left: 4.w,
                      right: 4.w,
                    ),
                    child: Text(
                      LocaleKeys.Enter_OTP_here.tr(),
                      style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                    )),
                Container(
                  margin: EdgeInsets.only(
                    top: 3.h,
                    left: 4.w,
                    right: 4.w,
                  ),
                  child: Center(
                    child: TextFormField(
                      validator: (value) => Validators.validateOtp(value!),
                      cursorColor: Colors.black38,
                      keyboardType: TextInputType.number,
                      controller: otp,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: LocaleKeys.Enter_OTP_here.tr(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color.blackgrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color.blackgrey),
                          )),
                    ),
                  ),
                ),
                if (isresend == false) ...[
                  Container(
                      margin: EdgeInsets.only(
                        top: 1.h,
                        left: 4.w,
                        right: 4.w,
                      ),
                      alignment: Alignment.centerRight,
                      child: Text(_start.toString())),
                ],
                Container(
                  margin: EdgeInsets.only(
                    top: 4.h,
                    left: 4.w,
                    right: 4.w,
                  ),
                  height: 6.5.h,
                  width: MediaQuery.of(context).size.width / 1.09,
                  child: TextButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        _Otpverify();
                      }
                    },
                    style:
                        TextButton.styleFrom(backgroundColor: color.redbutton),
                    child: Text(
                      LocaleKeys.Verify_Proceed.tr(),
                      style: TextStyle(
                          fontFamily: 'Poppins_Bold',
                          color: Colors.white,
                          fontSize: 17),
                    ),
                  ),
                ),
                if (isresend == true) ...[
                  Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 3.h),
                      child: InkWell(
                          child: Text(
                        LocaleKeys.Dont_receive_an_OTP.tr(),
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 14),
                      ))),
                  Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 1.h),
                      child: InkWell(
                          onTap: () {
                            resendOTP();
                            // Navigator.pop(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Signup()),
                            // );
                          },
                          child: Text(
                            LocaleKeys.Resend_OTP.tr(),
                            style: TextStyle(
                                fontFamily: 'Poppins_semiBold',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 12.sp),
                          ))),
                ],
              ],
            ),
          )),
    );
  }
}
