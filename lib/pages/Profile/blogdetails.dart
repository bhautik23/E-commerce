// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, use_key_in_widget_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:ecommerce_user/common%20class/Allformater.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class Blogsdetailspage extends StatefulWidget {
  var imageurl;
  var title;
  var date;
  var discription;

  @override
  State<Blogsdetailspage> createState() => _BlogsdetailspageState();
  Blogsdetailspage([this.imageurl, this.title, this.date, this.discription]);
}

class _BlogsdetailspageState extends State<Blogsdetailspage> {
  @override
  Widget build(BuildContext context) => SafeArea(
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
            LocaleKeys.Blogs_details.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 12.sp),
          ),
          leadingWidth: 40,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: Get.size.width * 0.03,
                top: Get.size.height * 0.002,
                bottom: Get.size.height * 0.002,
                right: Get.size.width * 0.03),
            child: InkWell(
              onTap: () {
                Get.to(() => Blogsdetailspage());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.size.height * 0.25,
                    width: Get.size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.imageurl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Get.size.height * 0.015,
                      bottom: Get.size.height * 0.015,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 14.sp, fontFamily: 'Poppins_bold'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: Get.size.height * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${LocaleKeys.Posted_by.tr()} Admin",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10.5.sp,
                              fontFamily: 'Poppins_semibold'),
                        ),
                        Text(
                          FormatedDate(widget.date),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10.5.sp,
                              fontFamily: 'Poppins_semibold'),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.discription, // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
}
