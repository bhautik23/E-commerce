// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, file_names, avoid_print, must_be_immutable, use_key_in_widget_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';

import 'package:sizer/sizer.dart';

import '../../Model/settings model/gallerymodel.dart';
import 'package:easy_localization/easy_localization.dart';

class Gallary extends StatefulWidget {
  const Gallary({Key? key}) : super(key: key);

  @override
  State<Gallary> createState() => _GallaryState();
}

class _GallaryState extends State<Gallary> {
  gallerymodel? Gallerydata;
  Future gallaryAPI() async {
    try {
      var response = await Dio().get(DefaultApi.appUrl + GetAPI.Gallery);
      var finalist = await response.data;
      Gallerydata = gallerymodel.fromJson(finalist);
      return Gallerydata;
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
                LocaleKeys.Gallery.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins_semibold', fontSize: 12.5.sp),
              ),
              centerTitle: true,
              leadingWidth: 40,
            ),
            body: FutureBuilder(
                future: gallaryAPI(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      itemCount: Gallerydata!.data!.length,
                      padding: EdgeInsets.all(5.sp),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 5.sp,
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.sp),
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => Gallerywidget(
                                      Gallerydata!.data!, index)));
                              // opengallery(
                              //     Gallerydata!.data![index].imageUrl, index);
                            },
                            child: Image.network(
                              Gallerydata!.data![index].imageUrl.toString(),
                              fit: BoxFit.cover,
                            ));
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: color.Metablue,
                    ),
                  );
                })));
  }

  opengallery(var imagelist, index) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => Gallerywidget(imagelist, index)));
  }
}

class Gallerywidget extends StatefulWidget {
  List<imageData>? imagedata;
  int? index;

  @override
  State<Gallerywidget> createState() => _GallerywidgetState();
  Gallerywidget(this.imagedata, this.index);
}

class _GallerywidgetState extends State<Gallerywidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
          ),
          body: Center(
            child: CarouselSlider.builder(
                itemCount: widget.imagedata!.length,
                itemBuilder: (context, index, realIndex) {
                  return SizedBox(
                    child: Image.network(
                      widget.imagedata![index].imageUrl!,
                      fit: BoxFit.fill,
                    ),
                  );
                },
                options: CarouselOptions(
                  initialPage: widget.index!,
                  enableInfiniteScroll: false,
                  disableCenter: true,
                  viewportFraction: 1,
                  height: 50.h,
                )),
          )),
    );
  }
}
