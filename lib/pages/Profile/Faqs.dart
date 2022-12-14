// ignore_for_file: file_names, override_on_non_overriding_member, avoid_print

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_user/Model/settings%20model/faqmodel.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class Faqs extends StatefulWidget {
  const Faqs({Key? key}) : super(key: key);

  @override
  State<Faqs> createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  faqmodel? faqdata;

  @override
  void initState() {
    super.initState();
    faqsAPI();
  }

  @override
  Future faqsAPI() async {
    try {
      var response = await Dio().get(DefaultApi.appUrl + GetAPI.faq);
      var finallist = await response.data;
      faqdata = faqmodel.fromJson(finallist);
      print(faqdata!.data.toString());
      return faqdata;
    } catch (e) {
      print(e.toString());
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
                LocaleKeys.Faqs.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins_semibold', fontSize: 12.5.sp),
              ),
              centerTitle: true,
              leadingWidth: 40,
            ),
            body: FutureBuilder(
                future: faqsAPI(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (faqdata!.data!.isEmpty) {
                      return Center(
                        child: Text(
                          LocaleKeys.No_data_found.tr(),
                          style:
                              TextStyle(fontSize: 12.sp, fontFamily: 'Poppins'),
                        ),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.only(left: 4.w, right: 3.5.w),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 6.3.h,
                                    width: MediaQuery.of(context).size.width,
                                    padding:
                                        EdgeInsets.only(left: 1.w, right: 1.w),
                                    color: Colors.grey.shade300,
                                    child: Text(
                                      faqdata!.data![index].title.toString(),
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontFamily: 'Poppins_semibold',
                                          color: Colors.black,
                                          fontSize: 10.sp),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 2.sp, bottom: 1.sp),
                                    child: Text(
                                      faqdata!.data![index].description
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.grey,
                                          fontSize: 10.5.sp),
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 1,
                            color: Colors.grey,
                            margin: EdgeInsets.only(top: 1.h, bottom: 0.5.h),
                          );
                        },
                        itemCount: faqdata!.data!.length,
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: color.Metablue,
                    ),
                  );
                })));
  }
}
