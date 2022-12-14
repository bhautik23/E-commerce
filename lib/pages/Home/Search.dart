// ignore_for_file: file_names, camel_case_types, avoid_print, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/Model/favoritepage/itemmodel.dart';
import 'package:ecommerce_user/Model/home/searchmodel.dart';
import 'package:ecommerce_user/common%20class/Allformater.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/pages/Home/product.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class productcontroller extends GetxController {
  var productlist = <itemmodel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchproduct();
  }

  fetchproduct() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString(UD_user_id);

      var map = {
        "user_id": userid,
        "filter": "",
        "search": "",
      };
      print(map);
      var product =
          await Dio().post(DefaultApi.appUrl + PostAPI.Searchitem, data: map);
      var productdata = searchmodel.fromJson(product.data);
      print(product);
      return productlist.assignAll(productdata.data!.toList());
    } catch (e) {
      print(e);
    }
  }
}

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController Search = TextEditingController();
  List<itemmodel> searchlist = [];
  searchmodel? searchdata;
  String? currency;
  String? currency_position;
  bool issearch = true;

  fetchproduct() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString(UD_user_id);
      currency = (prefs.getString('currency') ?? " ");
      currency_position = (prefs.getString('currency_position') ?? " ");
      issearch = true;

      var map = {
        "user_id": userid,
        "filter": "",
        "search": "",
      };
      print(map);
      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.Searchitem, data: map);
      searchdata = searchmodel.fromJson(response.data);
      print(response);
      issearch = false;
      return searchdata;
    } catch (e) {
      print(e);
    }
  }

  onsearch(String search) {
    setState(() {
      if (search.isEmpty) {
        searchlist.clear();
      }

      searchlist = searchdata!.data!
          .where((user) =>
              user.itemName!.toString().toLowerCase().contains(search))
          .toList();
    });
    print(searchlist);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                  )),
              title: Text(
                LocaleKeys.Search.tr(),
                textAlign: TextAlign.center,
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontFamily: 'Poppins_semibold',
                  fontSize: 16,
                ),
              ),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 50,
                  left: MediaQuery.of(context).size.width / 33,
                  right: MediaQuery.of(context).size.width / 33),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                    child: TextField(
                      onChanged: (text) {
                        onsearch(text);
                      },
                      cursorColor: Colors.black,
                      textAlignVertical: TextAlignVertical.bottom,
                      controller: Search,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 25,
                          ),
                          hintText: LocaleKeys.Search.tr(),
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontFamily: "Poppins"),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                    ),
                  ),
                  Expanded(
                      child: FutureBuilder(
                    future: issearch == true ? fetchproduct() : null,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (searchlist.isNotEmpty) {
                          return GridView.builder(
                              shrinkWrap: true,
                              itemCount: searchlist.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.65,
                                      crossAxisSpacing: 10,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Product(searchlist[index].id)),
                                    );
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                      ),
                                      margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                70,
                                      ),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  5)),
                                                  child: Image.network(
                                                    searchlist[index].imageUrl,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              if (searchlist[index]
                                                      .hasVariation ==
                                                  "0") ...[
                                                if (searchlist[index]
                                                            .availableQty ==
                                                        "" ||
                                                    int.parse(searchlist[index]
                                                            .availableQty
                                                            .toString()) <=
                                                        0) ...[
                                                  Positioned(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                      color: Colors.black38,
                                                      child: Text(
                                                        LocaleKeys.Out_of_Stock
                                                            .tr(),
                                                        style: TextStyle(
                                                          fontSize: 15.sp,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'poppins_semibold',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ]),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  110,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              50),
                                                ),
                                                Text(
                                                  searchlist[index]
                                                      .categoryInfo!
                                                      .categoryName,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontFamily: 'Poppins',
                                                    color: color.greenbutton,
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            50))
                                              ],
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  250,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    50,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    50,
                                              ),
                                              child: Text(
                                                searchlist[index].itemName,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 10.5.sp,
                                                  fontFamily:
                                                      'Poppins_semibold',
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  110,
                                            ),
                                            if (searchlist[index]
                                                    .hasVariation ==
                                                "1") ...[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      45,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      45,
                                                ),
                                                child: Text(
                                                  currency_position == "1"
                                                      ? "$currency${numberFormat.format(double.parse(searchlist[index].variation![0].productPrice))}"
                                                      : "${numberFormat.format(double.parse(searchlist[index].variation![0].productPrice))}$currency",
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontFamily: 'Poppins_bold',
                                                  ),
                                                ),
                                              )
                                            ] else ...[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      45,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      45,
                                                ),
                                                child: Text(
                                                  currency_position == "1"
                                                      ? "$currency${numberFormat.format(double.parse(searchlist[index].price))}"
                                                      : "${numberFormat.format(double.parse(searchlist[index].price))}$currency",
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontFamily: 'Poppins_bold',
                                                  ),
                                                ),
                                              )
                                            ]
                                          ])),
                                );
                              });
                        }
                        return Center(
                            child: Text(
                          LocaleKeys.No_data_found.tr(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Poppins_bold',
                          ),
                        ));
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: color.Metablue,
                        ),
                      );
                    },
                  ))
                ],
              ),
            )));
  }
}
