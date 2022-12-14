// ignore_for_file: file_names, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_user/Model/cartpage/promocodemodel.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class Selectpromocode extends StatefulWidget {
  const Selectpromocode({Key? key}) : super(key: key);

  @override
  State<Selectpromocode> createState() => _SelectpromocodeState();
}

class _SelectpromocodeState extends State<Selectpromocode> {
  promocodemodel? promocodedata;

  promocodeAPI() async {
    try {
      var response = await Dio().get(DefaultApi.appUrl + GetAPI.Promocodelist);
      promocodedata = promocodemodel.fromJson(response.data);
      return promocodedata;
    } catch (e) {
      rethrow;
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
                    // Get.back();
                    Navigator.pop(context, "0");
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  )),
              leadingWidth: 40,
              centerTitle: true,
            ),
            body: FutureBuilder(
              future: promocodeAPI(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: promocodedata!.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(
                              top: 1.h, left: 3.w, right: 3.w, bottom: 1.h),
                          padding: EdgeInsets.only(
                              left: 3.w, right: 2.5.w, top: 0.5.h, bottom: 1.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(
                                          'Assets/Icons/discount-code.png',
                                          height: 30),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                      promocodedata!.data![index].offerName
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontFamily: 'Poppins_semibold',
                                      )),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context,
                                          promocodedata!
                                              .data![index].offerCode);
                                      // Get.back("as");
                                    },
                                    child: Text(
                                        LocaleKeys.Apply.tr().toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 10.5.sp,
                                            fontFamily: 'Poppins_semibold',
                                            color: color.greenbutton)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      promocodedata!.data![index].offerCode
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'Poppins_semibold',
                                          color: color.greenbutton)),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Container(
                                height: 0.4.sp,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 2.h),
                              Text(promocodedata!.data![index].description!,
                                  style: TextStyle(
                                      fontSize: 10.5.sp,
                                      fontFamily: 'Poppins',
                                      color: Colors.grey)),
                            ],
                          ));
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: color.Metablue,
                  ),
                );
              },
            )));
  }
}
