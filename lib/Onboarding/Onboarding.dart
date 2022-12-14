// ignore_for_file: prefer_const_constructors, unused_import, prefer_final_fields, file_names, avoid_print

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/Model/tutorialmodel.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:sizer/sizer.dart';

import '../pages/Home/Homepage.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController _pageController = PageController();
  bool onlastpage = false;
  tutorialMODEL? _data;

  tutorialAPI() async {
    try {
      var response = await Dio().get(DefaultApi.appUrl + GetAPI.tutorial);
      print(response);
      _data = tutorialMODEL.fromJson(response.data);
      if (_data!.status == 1) {
        if (_data!.data!.isEmpty) {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Homepage(0)),
          );
        } else {
          return _data;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  // int? initScreen;

  initdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt(init_Screen, 1);
    // initScreen = prefs.getInt(init_Screen);
  }

  @override
  void initState() {
    super.initState();
    initdata();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tutorialAPI(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: color.Metablue,
              ),
            ),
          );
        }
        return Scaffold(
          body: Stack(
            children: [
              PageView.builder(
                itemCount: _data!.data!.length,
                controller: _pageController,
                onPageChanged: (index) {
                  if (index + 1 == _data!.data!.length) {
                    setState(() {
                      onlastpage = true;
                      // (index == 2);
                    });
                  } else {
                    setState(() {
                      onlastpage = false;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w),
                    color: Colors.transparent,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 12),
                        SizedBox(
                          height: 55.h,
                          child: Center(
                            child: Image.network(
                              _data!.data![index].imageUrl.toString(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          _data!.data![index].title.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22, fontFamily: 'Poppins_bold'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          _data!.data![0].description.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                        )
                      ],
                    ),
                  );
                },
              ),
              onlastpage
                  ? Container(
                      alignment: Alignment(0, 0.85),
                      child: FloatingActionButton(
                        backgroundColor: Colors.black,
                        onPressed: () {
                          // Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage(0)),
                          );
                        },
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment(0, 0.85),
                      child: FloatingActionButton(
                        backgroundColor: Colors.black,
                        onPressed: () {
                          _pageController.nextPage(
                              duration: Duration(microseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
