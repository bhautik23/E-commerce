// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_build_context_synchronously, avoid_print, unused_element

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce_user/Model/Loginmodel.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/height.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:ecommerce_user/utils/validator.dart/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_user/common%20class/color.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({Key? key}) : super(key: key);

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController Name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Phoneno = TextEditingController();

  @override
  void initState() {
    super.initState();
    getdata();
  }

  String? username;
  String? userid;
  String? useremail;
  String? usermobile;
  String? userprofileURl;
  String? selectedimage;
  String base64image = "";
  String? ImagefileName;
  // getprofilemodel? userdata;
  Loginmodel? editprofiledata;
  final ImagePicker _picker = ImagePicker();
  String imagepath = "";
  String imagename = "";

  imagePickerOption() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            Column(
              children: [
                SizedBox(
                  width: 100.w,
                  height: 20.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final XFile? photo = await _picker.pickImage(
                              source: ImageSource.camera);
                          imagepath = photo!.path;

                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 120,
                          width: 125,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Icon(Icons.camera_alt, size: 60),
                              ),
                              Text(
                                "Camara",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'poppins'),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final XFile? photo = await _picker.pickImage(
                              source: ImageSource.gallery);
                          imagepath = photo!.path;

                          setState(() {});

                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 120,
                          width: 125,
                          child: Column(
                            children: const [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Icon(Icons.photo, size: 60),
                              ),
                              Text(
                                "Photos",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'poppins'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      // style: TextButton.styleFrom(primary: globaldata.fullblk),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString(UD_user_id).toString();
    username = prefs.getString(UD_user_name).toString();
    useremail = prefs.getString(UD_user_email).toString();
    usermobile = prefs.getString(UD_user_mobile).toString();
    userprofileURl = prefs.getString(UD_user_profileimage).toString();

    setState(() {
      Name.value = TextEditingValue(text: username.toString());
      Email.value = TextEditingValue(text: useremail.toString());
      Phoneno.value = TextEditingValue(text: usermobile.toString());
    });
  }

  EditprofileAPI() async {
    try {
      var formdata = FormData.fromMap({
        "user_id": userid,
        "name": Name.text.toString(),
        "image": imagepath.isNotEmpty
            ? await MultipartFile.fromFile(imagepath,
                filename: imagepath.split("/").last)
            : userprofileURl,
      });
      print(formdata.fields);
      loader.showLoading();

      var response = await Dio()
          .post(DefaultApi.appUrl + PostAPI.Editprofile, data: formdata);

      var finallist = await response.data;
      editprofiledata = Loginmodel.fromJson(finallist);
      if (editprofiledata!.status == 1) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(UD_user_id, editprofiledata!.data!.id.toString());
        prefs.setString(UD_user_name, editprofiledata!.data!.name.toString());
        prefs.setString(
            UD_user_mobile, editprofiledata!.data!.mobile.toString());
        prefs.setString(UD_user_email, editprofiledata!.data!.email.toString());
        prefs.setString(
            UD_user_logintype, editprofiledata!.data!.loginType.toString());
        prefs.setString(
            UD_user_wallet, editprofiledata!.data!.wallet.toString());
        prefs.setString(UD_user_isnotification,
            editprofiledata!.data!.isNotification.toString());
        prefs.setString(
            UD_user_ismail, editprofiledata!.data!.isMail.toString());
        prefs.setString(
            UD_user_refer_code, editprofiledata!.data!.referralCode.toString());
        prefs.setString(UD_user_profileimage,
            editprofiledata!.data!.profileImage.toString());
        loader.hideLoading();
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 40,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
            )),
        title: Text(
          LocaleKeys.Edit_Profile.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 12.sp),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 2.h)),
          Stack(children: [
            SizedBox(
              height: 15.h,
              width: 15.h,
              child: ClipOval(
                child: imagepath.isNotEmpty
                    ? Image.file(
                        File(imagepath),
                        fit: BoxFit.fill,
                      )
                    : Image(
                        image: NetworkImage(userprofileURl.toString()),
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                    height: 5.5.h,
                    width: 11.5.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      splashColor: Colors.transparent,
                      icon: Icon(
                        Icons.photo_camera,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        imagePickerOption();
                        // chooseImage("camera");
                      },
                    ))),
          ]),
          Container(
            margin: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              top: 7.h,
            ),
            width: double.infinity,
            child: Center(
              child: Form(
                key: _formkey,
                child: TextFormField(
                  validator: (value) =>
                      Validators.validateRequired(value!, 'name'),
                  cursorColor: Colors.black,
                  controller: Name,
                  decoration: InputDecoration(
                      hintText: LocaleKeys.Name.tr(),
                      hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 10.5.sp),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: Colors.grey),
                      )),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              top: 2.h,
            ),
            width: double.infinity,
            child: Center(
              child: TextFormField(
                readOnly: true,
                cursorColor: Colors.black,
                controller: Email,
                decoration: InputDecoration(
                    hintText: LocaleKeys.Email.tr(),
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                        fontSize: 10.5.sp),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(color: Colors.grey),
                    )),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              top: 2.h,
            ),
            width: double.infinity,
            child: TextField(
              readOnly: true,
              cursorColor: Colors.black,
              controller: Phoneno,
              decoration: InputDecoration(
                  hintText: LocaleKeys.Phoneno.tr(),
                  hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                      fontSize: 10.5.sp),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(color: Colors.grey),
                  )),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              print("aa");
              if (_formkey.currentState!.validate()) {
                EditprofileAPI();
              }
            },
            child: Container(
              height: 6.5.h,
              margin:
                  EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h, bottom: 1.h),
              width: double.infinity,
              color: color.blackbutton,
              child: Center(
                child: Text(
                  LocaleKeys.Save.tr(),
                  style: TextStyle(
                      fontFamily: 'Poppins_semibold',
                      color: Colors.white,
                      fontSize: fontsize.Buttonfontsize),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showbottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
              height: 30.h,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      top: 2.h,
                      bottom: 2.h,
                    ),
                    child: Text(LocaleKeys.Select_Option.tr(),
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins')),
                  ),
                  SizedBox(
                    height: 0.8.sp,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 7.h,
                    child: InkWell(
                      onTap: () {
                        // chooseImage("camera");
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        LocaleKeys.Camera.tr(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Poppins_semibold',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 0.8.sp,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black12,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 7.h,
                    child: InkWell(
                      onTap: () {
                        // chooseImage(Gallary);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        LocaleKeys.Gallery.tr(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Poppins_semibold',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 0.8.sp,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black12,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 7.h,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        LocaleKeys.Cancel.tr(),
                        style: TextStyle(
                            fontSize: 13.sp, fontFamily: 'Poppins_semibold'),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }
}
