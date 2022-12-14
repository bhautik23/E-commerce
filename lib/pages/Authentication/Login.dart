// ignore_for_file: file_names, use_build_context_synchronously, unused_field, prefer_final_fields, non_constant_identifier_names, unused_element, avoid_print, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ecommerce_user/pages/Authentication/Otp.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_user/Model/Loginmodel.dart';
import 'package:ecommerce_user/Model/signupmodel.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:ecommerce_user/utils/validator.dart/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../config/API/API.dart';
import '../Home/Homepage.dart';
import 'Forgotpassword.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    token();
  }

  String? Logintype = "";
  String? countrycode = "91";

  token() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Logintype = prefs.getString(App_check_addons);
    });
    await FirebaseMessaging.instance.getToken().then((token) {
      if (kDebugMode) {
        print(token);
      }
      print("token");
      Googletoken = token!;
    });
  }

  GoogleSignInAccount? user;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  Map? userdata;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  final email = TextEditingController();
  final mobile = TextEditingController();
  final password = TextEditingController();
  Loginmodel? jsondata;
  Map<String, dynamic>? _userData;
  bool _loggedIn = true;
  String _name = "You're not logged in";
  AccessToken? _accessToken;
  String? Googletoken;

  _FBlogin() async {
    final LoginResult result = await FacebookAuth.instance.login(
        // permissions: [
        //   //   "id",
        //   //   "first_name",
        //   //   "last_name",
        //   "public_profile",
        //   "email",
        // ],
        );
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      Map userdata = await FacebookAuth.instance.getUserData();
      if (kDebugMode) {
        print(userdata);
      }
      // _userData = userdata;

      print("email  ${userdata["email"]}");
      print("name  ${userdata["name"]}");

      print("id  ${userdata["id"]}");
      _FBlogout();

      registerAPIforfb(userdata["email"], userdata["name"], userdata["id"]);
    } else {
      print(result.status);
      print(result.message);
    }
  }

  registerAPIforfb(email, name, id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loader.showLoading();
    var map = {
      "name": name,
      "email": email,
      "mobile": "",
      "token": Googletoken,
      "facebook_id": id,
      "login_type": "facebook",
    };
    var response =
        await Dio().post(DefaultApi.appUrl + PostAPI.register, data: map);
    print(response);
    Signupmodel data = Signupmodel.fromJson(response.data);
    loader.hideLoading();
    if (data.status == 1) {
      prefs.setString(UD_user_id, data.data!.id.toString());
      prefs.setString(UD_user_name, data.data!.name.toString());
      prefs.setString(UD_user_mobile, data.data!.mobile.toString());
      prefs.setString(UD_user_email, data.data!.email.toString());
      prefs.setString(UD_user_profileimage, data.data!.profileImage.toString());
      prefs.setString(UD_user_logintype, data.data!.loginType.toString());
      Get.to(() => Homepage(0));
    } else if (data.status == 2) {
      Get.to(() => Signup(email, name, "facebook", id.toString()));
    } else if (data.status == 3) {
      Get.to(() => Otp(email));
    } else {
      loader.showErroDialog(description: data.message);
    }
  }

  _FBlogout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
  }

  login() async {
    try {
      loader.showLoading();

      var map = Logintype == "mobile"
          ? {
              "mobile": "+${countrycode! + mobile.value.text}",
              "token": Googletoken,
            }
          : {
              "password": password.text.toString(),
              "email": email.text.toString(),
              "token": Googletoken
            };

      print(map);
      var response = await Dio().post(
        DefaultApi.appUrl + PostAPI.loginAPi,
        data: map,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            print(status);
            return status! < 500;
          },
        ),
      );
      print(response);
      if (response.statusCode! > 300) {
        loader.showErroDialog(description: "serrr");
      }
      // print(response.data);
      var finallist = await response.data;
      jsondata = Loginmodel.fromJson(finallist);

      loader.hideLoading();

      if (jsondata!.status == 1) {
        password.clear();
        email.clear();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(UD_user_id, jsondata!.data!.id.toString());
        prefs.setString(UD_user_name, jsondata!.data!.name.toString());
        prefs.setString(UD_user_mobile, jsondata!.data!.mobile.toString());
        prefs.setString(UD_user_email, jsondata!.data!.email.toString());
        prefs.setString(
            UD_user_logintype, jsondata!.data!.loginType.toString());
        prefs.setString(UD_user_wallet, jsondata!.data!.wallet.toString());
        prefs.setString(
            UD_user_isnotification, jsondata!.data!.isNotification.toString());
        prefs.setString(UD_user_ismail, jsondata!.data!.isMail.toString());
        prefs.setString(
            UD_user_refer_code, jsondata!.data!.referralCode.toString());
        prefs.setString(
            UD_user_profileimage, jsondata!.data!.profileImage.toString());

        print(jsondata!.data);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage(0)),
        );
      } else if (jsondata!.status == 2) {
        // password.clear();
        // email.clear();

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Otp(Logintype == "mobile"
                  ? "+${countrycode! + mobile.value.text}"
                  : email.text.toString())),
        );
      } else {
        loader.showErroDialog(description: jsondata!.message);
        print(jsondata!.message);
      }

      return jsondata;
    } on DioError catch (e) {
      loader.showErroDialog(description: "server time  out");
      print(e.type);

      if (e.type == DioErrorType.connectTimeout) {
        loader.showErroDialog(description: "server time  out");
      }
      loader.hideLoading();

      // loader.showErroDialog(description: e.toString());
      print("close");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final value = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Alert",
                  style: TextStyle(),
                ),
                content: Text(
                  "are you sure to exit",
                  style: TextStyle(),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(LocaleKeys.No.tr()),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(LocaleKeys.Yes.tr()),
                  ),
                ],
              );
            },
          );
          if (value != null) {
            return Future.value(value);
          } else {
            return Future.value(false);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin:
                        EdgeInsets.only(left: 4.5.w, top: 3.5.h, bottom: 1.h),
                    child: Text(
                      LocaleKeys.Login.tr(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 23.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins_Bold'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      left: 4.5.w,
                    ),
                    child: Text(
                      LocaleKeys.Signin_to_your_account.tr(),
                      // LocaleKeys.Signin_to_your_account,
                      style: TextStyle(fontSize: 12.sp, fontFamily: 'Poppins'),
                    ),
                  ),
                  if (Logintype == "mobile") ...[
                    Container(
                      margin: EdgeInsets.only(
                        top: 2.5.h,
                        bottom: 2.5.h,
                        left: 4.w,
                        right: 4.w,
                      ),
                      child: Center(
                        child: IntlPhoneField(
                          cursorColor: Colors.grey,
                          disableLengthCheck: true,
                          controller: mobile,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: LocaleKeys.Phoneno.tr(),
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          initialCountryCode: 'IN',
                          onCountryChanged: (value) {
                            countrycode = value.dialCode;
                            print(countrycode);
                          },
                        ),
                      ),
                    ),
                  ] else ...[
                    Container(
                      margin:
                          EdgeInsets.only(top: 2.5.h, left: 4.w, right: 4.w),
                      child: Center(
                        child: TextFormField(
                          validator: (value) => Logintype == "email"
                              ? Validators.validateEmail(value!)
                              : null,
                          cursorColor: Colors.grey,
                          controller: email,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: LocaleKeys.Email.tr(),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              )),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 2.5.h, left: 4.w, right: 4.w),
                      child: Center(
                        child: TextFormField(
                          validator: (value) =>
                              Validators.validatePassword(value!),
                          cursorColor: Colors.grey,
                          controller: password,
                          obscureText: _obscureText,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  )),
                              hintText: LocaleKeys.Password.tr(),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              )),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(right: 4.w, top: 1.5.h),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Forgotpass()),
                          );
                        },
                        child: Text(
                          LocaleKeys.Forgot_Password.tr(),
                          style: TextStyle(
                              fontFamily: 'Poppins_semiBold',
                              fontSize: 10.5.sp),
                        ),
                      ),
                    ),
                  ],
                  Container(
                    margin: EdgeInsets.only(
                      top: 2.h,
                      right: 4.w,
                      left: 4.w,
                    ),
                    height: 6.5.h,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        print(mobile.value);
                        // if (mobile.value.text.isEmpty) {
                        //   loader.showErroDialog(description: "enter");
                        // }

                        if (_formkey.currentState!.validate()) {
                          print("12");
                          if (Logintype == "mobile") {
                            print("1");
                            if (mobile.value.text.isEmpty) {
                              loader.showErroDialog(
                                  description:
                                      LocaleKeys.Please_enter_all_details.tr());
                            } else {
                              login();
                            }
                          } else {
                            print("dkjklndsgbkljdabkj");
                            login();
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                          // foregroundColor: Colors.grey,
                          backgroundColor: color.Metablue),
                      child: Text(
                        LocaleKeys.Login.tr(),
                        style: TextStyle(
                            fontFamily: 'Poppins_Bold',
                            color: Colors.white,
                            fontSize: 13.sp),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 4.5.h),
                    child: Text(LocaleKeys.OR.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins_semiBold',
                          fontSize: 11.sp,
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    top: 4.h,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            borderRadius: BorderRadius.circular(6)),
                        child: Card(
                          elevation: 0,
                          child: InkWell(
                              borderRadius: BorderRadius.zero,
                              onTap: () async {
                                googlelogin();
                              },
                              child: Image.asset(
                                'Assets/Icons/google.png',
                                height: 5.h,
                                width: 11.w,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            borderRadius: BorderRadius.circular(6)),
                        child: Card(
                          elevation: 0,
                          child: InkWell(
                              onTap: () async {
                                print("object");

                                _FBlogin();
                              },
                              child: Image.asset(
                                'Assets/Icons/facebook.png',
                                height: 5.h,
                                width: 11.w,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 7.h),
                      child: Text(
                        LocaleKeys.Dont_have_an_account.tr(),
                        style:
                            TextStyle(fontFamily: 'Poppins', fontSize: 10.5.sp),
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      child: Text(
                        LocaleKeys.Signup.tr(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Poppins_semiBold', fontSize: 12.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
              decoration: BoxDecoration(color: color.Metablue),
              height: 8.h,
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage(0)),
                  );
                },
                child: Center(
                    child: Text(
                  LocaleKeys.Skip_continue.tr(),
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 13.sp),
                )),
              )),
        ),
      ),
    );
  }

  googlelogin() async {
    loader.showLoading();
    await _googleSignIn.signIn().then((value) {
      loader.hideLoading();
      _googleSignIn.signOut();
      registerAPI(value!);

      print(value);
    }).catchError((e) {
      loader.showErroDialog(description: e);
    });
  }

  registerAPI(GoogleSignInAccount value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loader.showLoading();
    var map = {
      "name": value.displayName,
      "email": value.email,
      "mobile": "",
      "token": Googletoken,
      "google_id": value.id,
      "login_type": "google",
    };
    var response =
        await Dio().post(DefaultApi.appUrl + PostAPI.register, data: map);
    print(response);
    Signupmodel data = Signupmodel.fromJson(response.data);
    loader.hideLoading();
    if (data.status == 1) {
      prefs.setString(UD_user_id, data.data!.id.toString());
      prefs.setString(UD_user_name, data.data!.name.toString());
      prefs.setString(UD_user_mobile, data.data!.mobile.toString());
      prefs.setString(UD_user_email, data.data!.email.toString());
      prefs.setString(UD_user_profileimage, data.data!.profileImage.toString());
      prefs.setString(UD_user_logintype, data.data!.loginType.toString());
      Get.to(() => Homepage(0));
    } else if (data.status == 2) {
      Get.to(() => Signup(
          value.email, value.displayName, "google", value.id.toString()));
    } else if (data.status == 3) {
      Get.to(() => Otp(value.email));
    } else {
      loader.showErroDialog(description: data.message);
    }
  }
}
