// ignore_for_file: file_names, avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_user/Model/settings%20model/helpmodel.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/height.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:ecommerce_user/utils/validator.dart/validator.dart';
import 'package:sizer/sizer.dart';

class Helpcontactus extends StatefulWidget {
  const Helpcontactus({Key? key}) : super(key: key);

  @override
  State<Helpcontactus> createState() => _HelpcontactusState();
}

class _HelpcontactusState extends State<Helpcontactus> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final message = TextEditingController();
  helpmodel? helpdata;
  helpAPI() async {
    try {
      loader.showLoading();
      var map = {
        "firstname": firstname.text.toString(),
        "lastname": lastname.text.toString(),
        "email": email.text.toString(),
        "message": message.text.toString()
      };
      print(map);
      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.contact, data: map);
      var finalist = await response.data;
      helpdata = helpmodel.fromJson(finalist);
      loader.hideLoading();
      if (helpdata!.status == 1) {
        Navigator.of(context).pop();
        loader.showErroDialog(description: helpdata!.message);
      } else {
        loader.showErroDialog(description: helpdata!.message);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              LocaleKeys.Help_Contact_Us.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 12.sp),
            ),
            centerTitle: true,
            leadingWidth: 40,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 4.5.w,
                      right: 4.5.w,
                      top: 1.h,
                    ),
                    child: Text(
                      LocaleKeys.Contectus.tr(),
                      style: TextStyle(
                          fontFamily: 'Poppins_semibold', fontSize: 12.sp),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 4.5.w,
                      top: 1.h,
                      right: 4.5.w,
                    ),
                    child: Row(children: [
                      const ImageIcon(
                        AssetImage('Assets/Icons/phone.png'),
                        size: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 2.w,
                          right: 2.w,
                        ),
                        child: Text(
                          LocaleKeys.No91_70164.tr(),
                          style: TextStyle(
                              fontFamily: 'Poppins', fontSize: 9.5.sp),
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 4.2.w,
                        right: 4.2.w,
                        top: MediaQuery.of(context).size.height / 80),
                    child: Row(children: [
                      const ImageIcon(
                        AssetImage('Assets/Icons/mail.png'),
                        size: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 2.w,
                          right: 2.w,
                        ),
                        child: Text(
                          LocaleKeys.Infotechgravitygmail.tr(),
                          style: TextStyle(
                              fontFamily: 'Poppins', fontSize: 9.5.sp),
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 4.2.w,
                      top: 1.6.h,
                      right: 4.w,
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ImageIcon(
                            AssetImage('Assets/Icons/address.png'),
                            size: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 2.w,
                              right: 2.w,
                            ),
                            child: Text(
                              maxLines: 3,
                              LocaleKeys.Company_address.tr(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 9.5.sp,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.h, left: 4.w, right: 4.w),
                    child: Text(
                      LocaleKeys.Inquiry_form.tr(),
                      style: const TextStyle(
                        fontFamily: 'Poppins_semibold',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 4.w, left: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 2.h,
                            bottom: 1.h,
                            // left: 4.w,
                          ),
                          width: 45.w,
                          child: TextFormField(
                            validator: (value) => Validators.validatefirstName(
                              value!,
                            ),
                            controller: firstname,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                hintText: LocaleKeys.First_name.tr(),
                                hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontSize: 11.sp),
                                border: const OutlineInputBorder(),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 2.h,
                            bottom: 1.h,
                          ),
                          width: 45.w,
                          child: TextFormField(
                            validator: (value) => Validators.validatelastName(
                              value!,
                            ),
                            controller: lastname,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                                hintText: LocaleKeys.Last_name.tr(),
                                hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontSize: 11.sp),
                                border: const OutlineInputBorder(),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 1.h, bottom: 1.h, left: 4.w, right: 4.w),
                    child: TextFormField(
                      validator: (value) => Validators.validateEmail(
                        value!,
                      ),
                      controller: email,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          hintText: LocaleKeys.Email.tr(),
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                              fontSize: 11.sp),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 1.h, bottom: 1.h, left: 4.w, right: 4.w),
                    child: TextFormField(
                      validator: (value) => Validators.validatemessage(
                        value!,
                      ),
                      controller: message,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          hintText: LocaleKeys.Message.tr(),
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                              fontSize: 11.sp),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 1.6.h,
                      bottom: MediaQuery.of(context).size.width / 99,
                      left: 4.w,
                      right: 4.w,
                    ),
                    height: 6.h,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          helpAPI();
                        } else {
                          loader.showErroDialog(
                              description:
                                  LocaleKeys.Please_enter_all_details.tr());
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: color.blackbutton),
                      child: Text(
                        LocaleKeys.Submit.tr(),
                        style: TextStyle(
                            fontFamily: 'Poppins_semibold',
                            color: Colors.white,
                            fontSize: fontsize.Buttonfontsize),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: const AssetImage('Assets/Icons/facebook.png'),
                        height: 4.h,
                        width: 4.h,
                      ),
                      SizedBox(
                        width: 2.5.w,
                      ),
                      Image(
                        image: const AssetImage('Assets/Icons/instagram.png'),
                        height: 4.5.h,
                        width: 4.5.h,
                      ),
                      SizedBox(
                        width: 2.5.w,
                      ),
                      Image(
                        image: const AssetImage('Assets/Icons/twitter.png'),
                        height: 4.5.h,
                        width: 4.5.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
