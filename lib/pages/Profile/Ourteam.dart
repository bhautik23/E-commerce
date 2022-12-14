// ignore_for_file: file_names, avoid_print, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:ecommerce_user/Model/settings%20model/ourteammodel.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Ourteampage extends StatefulWidget {
  const Ourteampage({Key? key}) : super(key: key);

  @override
  State<Ourteampage> createState() => _OurteampageState();
}

class _OurteampageState extends State<Ourteampage> {
  ourteammodel? ourteamdata;
  ourteamAPI() async {
    try {
      var response = await Dio().get(DefaultApi.appUrl + GetAPI.ourteam);

      print(response);
      var finallist = await response.data;
      ourteamdata = ourteammodel.fromJson(finallist);

      return ourteamdata;
    } catch (e) {
      print(e);
    }
  }

  _launchURL(String url) async {
    await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                  )),
              title: Text(
                LocaleKeys.Our_Team.tr(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontFamily: 'Poppins_semibold', fontSize: 12.sp),
              ),
              leadingWidth: 40,
              centerTitle: true,
            ),
            body: FutureBuilder(
              future: ourteamAPI(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (ourteamdata!.data!.isEmpty) {
                    return Center(
                      child: Text(
                        LocaleKeys.No_data_found.tr(),
                        style:
                            TextStyle(fontSize: 12.sp, fontFamily: 'Poppins'),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: ourteamdata!.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            top: Get.size.height * 0.005,
                            bottom: Get.size.height * 0.005,
                            left: Get.size.width * 0.03,
                            right: Get.size.width * 0.03),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                ourteamdata!.data![index].title,
                                style: TextStyle(
                                  fontSize: 11.5.sp,
                                  fontFamily: 'Poppins_semibold',
                                ),
                              ),
                              subtitle: Text(
                                ourteamdata!.data![index].subtitle,
                                style: TextStyle(
                                  fontSize: 9.5.sp,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  ourteamdata!.data![index].imageUrl,
                                  height: Get.size.height * 0.5,
                                  width: Get.size.width * 0.13,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Text(
                              ourteamdata!.data![index].description,
                              style: TextStyle(
                                  fontSize: 9.5.sp,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: Get.size.height * 0.02,
                                bottom: Get.size.height * 0.02,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _launchURL(ourteamdata!.data![index].fb);
                                    },
                                    child: Image(
                                      image: AssetImage(
                                          'Assets/Icons/facebook.png'),
                                      width: Get.size.width * 0.08,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.5.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURL(
                                          ourteamdata!.data![index].insta);
                                    },
                                    child: Image(
                                      image: const AssetImage(
                                          'Assets/Icons/instagram.png'),
                                      // height: 4.5.h,
                                      width: Get.size.width * 0.1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.5.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURL(
                                          ourteamdata!.data![index].youtube);
                                    },
                                    child: Image(
                                      image: const AssetImage(
                                          'Assets/Icons/twitter.png'),
                                      // height: 4.5.h,
                                      width: Get.size.width * 0.09,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: Get.size.height * 0.02,
                                bottom: Get.size.height * 0.02,
                              ),
                              height: Get.size.height * 0.001,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      );
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
