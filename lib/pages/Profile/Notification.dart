// ignore_for_file: file_names, avoid_print, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/Model/settings%20model/isnotificationmodel.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import '../../Theme/ThemeModel.dart';

class Notificationpage extends StatefulWidget {
  const Notificationpage({Key? key}) : super(key: key);

  @override
  State<Notificationpage> createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {
  bool status1 = false;
  String? userid;
  String? isnotification;
  String? ismail;
  isnotificationModel? notificationdata;

  isisnotificationAPI(notification, mail) async {
    loader.showLoading();
    print(userid);
    var map = {
      "user_id": userid,
      "notification_status": notification,
      "mail_status": mail,
    };
    print(map);

    var response =
        await Dio().post(DefaultApi.appUrl + PostAPI.Isnotification, data: map);
    var finallist = await response.data;
    notificationdata = isnotificationModel.fromJson(finallist);
    if (notificationdata!.status == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(UD_user_isnotification,
          notificationdata!.notificationStatus.toString());
      prefs.setString(UD_user_ismail, notificationdata!.mailStatus.toString());
    }
    loader.hideLoading();
    print(notificationdata!.mailStatus);
    print(notificationdata!.notificationStatus);
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString(UD_user_id);
      isnotification = prefs.getString(UD_user_isnotification);
      ismail = prefs.getString(UD_user_ismail);
    });
    print("unoti $isnotification");
    print("mail $ismail");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themenofier, child) {
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
              )),
          title: Text(
            LocaleKeys.Notification_Settings.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 12.sp),
          ),
          leadingWidth: 40,
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 1.7.h, left: 4.w, right: 4.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    LocaleKeys.Push_Notifications.tr(),
                    style: TextStyle(
                        fontFamily: 'Poppins_semibold', fontSize: 12.sp),
                  ),
                  Spacer(),
                  FlutterSwitch(
                    inactiveColor: Colors.grey,
                    activeColor: color.blackbutton,
                    width: 12.8.w,
                    height: 3.9.h,
                    value: isnotification == "1" ? false : true,
                    borderRadius: 30.0,
                    padding: 4.0,
                    showOnOff: false,
                    onToggle: (val) {
                      if (isnotification == "1") {
                        setState(() {
                          isnotification = "2";
                        });

                        isisnotificationAPI(isnotification, ismail);
                      } else {
                        setState(() {
                          isnotification = "1";
                        });
                        isisnotificationAPI(isnotification, ismail);
                      }
                      // setState(() {
                      //   status = val;
                      // });
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 1.h, bottom: 1.1.h),
                height: 0.8.sp,
                color: color.greybutton,
              ),
              Row(
                children: [
                  Text(
                    LocaleKeys.keepthisonnoti.tr(),
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                children: [
                  Text(
                    LocaleKeys.Emails,
                    style: TextStyle(
                        fontFamily: 'Poppins_semibold', fontSize: 12.sp),
                  ),
                  Spacer(),
                  FlutterSwitch(
                    inactiveColor: Colors.grey,
                    activeColor: color.blackbutton,
                    width: 12.8.w,
                    height: 3.9.h,
                    value: ismail == "1" ? false : true,
                    borderRadius: 30.0,
                    padding: 4.0,
                    showOnOff: false,
                    onToggle: (val1) {
                      if (ismail == "1") {
                        setState(() {
                          ismail = "2";
                        });
                        isisnotificationAPI(isnotification, ismail);
                      } else {
                        setState(() {
                          ismail = "1";
                        });
                        isisnotificationAPI(isnotification, ismail);
                      }
                      // setState(() {
                      //   status1 = val1;
                      // });
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 1.h, bottom: 1.1.h),
                height: 0.8.sp,
                color: Colors.black26,
              ),
              Row(
                children: [
                  Text(
                    LocaleKeys.Keep_this_on_to_receive_emails_from_system.tr(),
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    });
  }
}
