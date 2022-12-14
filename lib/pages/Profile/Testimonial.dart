// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, file_names, avoid_unnecessary_containers, non_constant_identifier_names, avoid_print, use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ecommerce_user/Model/settings%20model/addratingmodel.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/height.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_user/common%20class/color.dart';

import '../Authentication/Login.dart';
import '../../Model/settings model/ratereviewmodel.dart';

class Ratingreview extends StatefulWidget {
  const Ratingreview({Key? key}) : super(key: key);

  @override
  State<Ratingreview> createState() => _RatingreviewState();
}

class _RatingreviewState extends State<Ratingreview> {
  String userid = "";
  Ratereviewmodel? finaldata;

  @override
  void initState() {
    super.initState();
    getstatus();
  }

  getstatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = (prefs.getString(UD_user_id) ?? "null");
    });
  }

  Future reviewAPI() async {
    var response = await Dio().get(DefaultApi.appUrl + GetAPI.rattinglist);
    var finallist = await response.data;
    finaldata = Ratereviewmodel.fromJson(finallist);
    return finaldata;
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
                LocaleKeys.Ratingreview.tr(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontFamily: 'Poppins_semibold', fontSize: 12.sp),
              ),
              leadingWidth: 40,
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
                elevation: 0.0,
                backgroundColor: color.blackbutton,
                onPressed: () {
                  userid == "null"
                      ? Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (c) => Login()),
                          (r) => false)
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Testimonioal()),
                        );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                )),
            body: FutureBuilder(
                future: reviewAPI(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(
                                  top: 0.8.h, left: 4.w, right: 4.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                        ),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              finaldata!
                                                  .data![index].profileImage
                                                  .toString()),
                                          backgroundColor: Colors.black12,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(finaldata!.data![index].name
                                              .toString()),
                                          SizedBox(
                                            height: 4.sp,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (finaldata!
                                                      .data![index].ratting ==
                                                  "1") ...[
                                                Image.asset(
                                                  "Assets/Image/ratting1.png",
                                                  width: 25.w,
                                                )
                                              ] else if (finaldata!
                                                      .data![index].ratting ==
                                                  "2") ...[
                                                Image.asset(
                                                  "Assets/Image/ratting2.png",
                                                  width: 25.w,
                                                )
                                              ] else if (finaldata!
                                                      .data![index].ratting ==
                                                  "3") ...[
                                                Image.asset(
                                                  "Assets/Image/ratting3.png",
                                                  width: 25.w,
                                                )
                                              ] else if (finaldata!
                                                      .data![index].ratting ==
                                                  "4") ...[
                                                Image.asset(
                                                  "Assets/Image/ratting4.png",
                                                  // color: Colors.white,
                                                  width: 25.w,
                                                )
                                              ] else if (finaldata!
                                                      .data![index].ratting ==
                                                  "5") ...[
                                                Image.asset(
                                                  "Assets/Image/ratting5.png",
                                                  width: 25.w,
                                                )
                                              ],
                                              SizedBox(
                                                width: 32.w,
                                              ),
                                              Container(
                                                child: Text(
                                                  finaldata!.data![index].date
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 9.sp,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.1.h,
                                  ),
                                  Text(
                                    finaldata!.data![index].comment.toString(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.grey,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                ],
                              ),
                            ),
                        separatorBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(
                                  bottom: 0.5.h, left: 2.5.w, right: 2.5.w),
                              height: 0.8.sp,
                              color: Colors.grey,
                            ),
                        itemCount: finaldata!.data!.length);
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: color.Metablue,
                    ),
                  );
                })));
  }
}

class Testimonioal extends StatefulWidget {
  const Testimonioal({Key? key}) : super(key: key);

  @override
  State<Testimonioal> createState() => _TestimonioalState();
}

class _TestimonioalState extends State<Testimonioal> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Comment = TextEditingController();
  String userid = "";
  int? rating;
  addratingmodel? finallist;

  addraring() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = (prefs.getString(UD_user_id) ?? "null");
    });
    try {
      loader.showLoading();
      // loader.showLoading();
      var map = {
        "user_id": userid,
        "comment": Comment.text.toString(),
        "ratting": rating.toString(),
      };
      print(map);

      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.addrating, data: map);
      finallist = addratingmodel.fromJson(response.data);

      if (finallist!.status == 1) {
        loader.hideLoading();
        Comment.clear();
        Navigator.of(context).pop();
        loader.showErroDialog(description: finallist!.message);
      } else {
        Navigator.of(context).pop();
        loader.showErroDialog(description: finallist!.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 6.h, bottom: 5.h),
            child: Text(LocaleKeys.Ratingreview.tr(),
                style:
                    TextStyle(fontSize: 17.sp, fontFamily: 'Poppins_semibold')),
          ),
          RatingBar.builder(
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 60,
            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: color.redbutton,
            ),
            onRatingUpdate: (Value) {
              setState(() {
                rating = Value.toInt();
              });
              print(rating);
            },
          ),
          SizedBox(
            height: 40,
          ),
          Form(
            key: _formkey,
            child: Container(
              margin: EdgeInsets.only(
                top: 0.8.h,
                left: 3.5.w,
                right: 3.5.w,
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: Comment,
                maxLines: 10,
                cursorColor: Colors.grey,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    hintText: LocaleKeys.Enteryoureview.tr(),
                    hintStyle:
                        TextStyle(fontSize: 11.sp, fontFamily: "Poppins"),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                    )),
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            height: 15,
          )
        ],
      ),
      bottomSheet: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              // margin: EdgeInsets.only(
              //   left: 1.6.w,
              //   right: 1.6.w,
              //   bottom: 1.5.h,
              // ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey)),
              height: 6.5.h,
              width: 47.w,
              child: TextButton(
                style: ElevatedButton.styleFrom(
                    // foregroundColor: Colors.grey,
                    ),
                child: Text(
                  LocaleKeys.Cancel.tr(),
                  style: TextStyle(
                      fontFamily: 'Poppins_semibold',
                      color: color.redbutton,
                      fontSize: fontsize.Buttonfontsize),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              // margin: EdgeInsets.only(
              //   right: 1.6.w,
              //   left: 1.6.w,
              //   bottom: 1.5.h,
              // ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              height: 6.5.h,
              width: 47.w,
              child: TextButton(
                onPressed: () {
                  if (Comment.text.isEmpty) {
                    loader.showErroDialog(
                      description: LocaleKeys.Please_enter_all_details.tr(),
                    );
                  } else {
                    addraring();
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: color.blackbutton,
                ),
                child: Text(
                  LocaleKeys.Submit.tr(),
                  style: TextStyle(
                      fontFamily: 'Poppins_semiBold',
                      color: Colors.white,
                      fontSize: fontsize.Buttonfontsize),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
