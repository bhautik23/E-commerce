// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors, non_constant_identifier_names, must_be_immutable, avoid_print

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/pages/Authentication/Login.dart';
import 'package:ecommerce_user/Model/cartpage/Qtyupdatemodel.dart';
import 'package:ecommerce_user/Model/favoritepage/addtocartmodel.dart';
import 'package:ecommerce_user/Model/home/searchmodel.dart';
import 'package:ecommerce_user/Theme/ThemeModel.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/Allformater.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/pages/Favorite/showvariation.dart';
import 'package:ecommerce_user/pages/Home/Homepage.dart';
import 'package:ecommerce_user/pages/Home/product.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class Trendingfood extends StatefulWidget {
  String? type;
  String? typename;

  @override
  State<Trendingfood> createState() {
    return _TrendingfoodState();
  }

  Trendingfood([this.type, this.typename]);
}

class _TrendingfoodState extends State<Trendingfood> {
  // int groupvalue = 0;
  // int group2value = 0;
  String? userid;
  searchmodel? itemdata;
  String? currency;
  String? currency_position;
  addtocartmodel? addtocartdata;
  int? cart;
  cartcount count = Get.put(cartcount());
  bool isfirstcome = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  viewallAPI(filter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString(UD_user_id) ?? "";
    currency = prefs.getString(APPcurrency);
    currency_position = prefs.getString(APPcurrency_position);
    try {
      loader.showLoading();
      var map = {
        "user_id": userid,
        "filter": filter,
        "search": widget.type,
      };
      print(map);
      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.Searchitem, data: map);
      print(response);
      isfirstcome = false;
      loader.hideLoading();
      itemdata = searchmodel.fromJson(response.data);
      print("object ${itemdata!.data!.length}");
      setState(() {
        _scaffoldKey.currentWidget.reactive();
      });
      return itemdata;
    } catch (e) {
      print(e);
    }
  }

  addtocart(itemid, itemname, itemimage, itemtype, itemtax, itemprice) async {
    try {
      loader.showLoading();
      isfirstcome = true;
      var map = {
        "user_id": userid,
        "item_id": itemid,
        "item_name": itemname,
        "item_image": itemimage,
        "item_type": itemtype,
        "tax": itemtax,
        "item_price": numberFormat.format(double.parse(itemprice)),
        "variation_id": "",
        "variation": "",
        "addons_id": "",
        "addons_name": "",
        "addons_price": "",
        "addons_total_price": numberFormat.format(double.parse("0")),
      };

      print(map);

      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.Addtocart, data: map);
      print(response);
      addtocartdata = addtocartmodel.fromJson(response.data);
      if (addtocartdata!.status == 1) {
        loader.hideLoading();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(APPcart_count, addtocartdata!.cartCount.toString());

        count.cartcountnumber(int.parse(prefs.getString(APPcart_count)!));
        setState(() {
          // FavoriteAPI();
        });
      } else {
        loader.showErroDialog(
          description: addtocartdata!.message!,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  managefavarite(
    var itemid,
    String isfavorite,
    index,
  ) async {
    try {
      loader.showLoading();
      var map = {"user_id": userid, "item_id": itemid, "type": isfavorite};
      print(map);

      var favoriteresponse = await Dio()
          .post(DefaultApi.appUrl + PostAPI.Managefavorite, data: map);
      print(favoriteresponse);
      var finaldata = QTYupdatemodel.fromJson(favoriteresponse.data);

      if (finaldata.status == 1) {
        setState(() {
          isfavorite == "favorite"
              ? itemdata!.data![index].isFavorite = "1"
              : itemdata!.data![index].isFavorite = "0";
        });
        loader.hideLoading();
      } else {
        loader.hideLoading();
        loader.showErroDialog(description: finaldata.message);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              leadingWidth: 40,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                  )),
              title: Text(
                widget.typename!,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 16),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Consumer(builder:
                              (context, ThemeModel themenofier, child) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  color: themenofier.isdark
                                      ? Colors.black
                                      : Colors.white,
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          25,
                                      right: MediaQuery.of(context).size.width /
                                          30),
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            LocaleKeys.Select_Option.tr(),
                                            style: TextStyle(
                                                fontFamily: 'Poppins_bold',
                                                fontSize: 20),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: Icon(Icons.close))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          isfirstcome = true;
                                          setState(() {
                                            itemdata!.data!.clear();
                                          });
                                          viewallAPI("1");
                                          Get.back();
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              LocaleKeys.Veg.tr(),
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 12, bottom: 12),
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          isfirstcome = true;
                                          setState(() {
                                            itemdata!.data!.clear();
                                          });
                                          viewallAPI("2");
                                          Get.back();
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              LocaleKeys.Nonveg.tr(),
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 12, bottom: 12),
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          isfirstcome = true;
                                          setState(() {
                                            itemdata!.data!.clear();
                                          });
                                          viewallAPI("");
                                          Get.back();
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              LocaleKeys.Both.tr(),
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 12, bottom: 12),
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          });
                        });
                  },
                  icon: ImageIcon(
                    AssetImage('Assets/Icons/Filter.png'),
                    size: 22,
                  ),
                )
              ],
            ),
            body: FutureBuilder(
              future: isfirstcome == true ? viewallAPI("") : null,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      shrinkWrap: true,
                      itemCount: itemdata!.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.65,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 33,
                          bottom: MediaQuery.of(context).size.height / 95,
                          right: MediaQuery.of(context).size.width / 33),
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 70,
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                    () => Product(itemdata!.data![index].id));
                              },
                              child: Column(children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.3,
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)),
                                        child: Image.network(
                                          itemdata!.data![index].imageUrl,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    if (itemdata!.data![index].hasVariation ==
                                        "0") ...[
                                      if (itemdata!.data![index].availableQty ==
                                              "" ||
                                          int.parse(itemdata!
                                                  .data![index].availableQty
                                                  .toString()) <=
                                              0) ...[
                                        Positioned(
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            color: Colors.black38,
                                            child: Text(
                                              LocaleKeys.Out_of_Stock.tr(),
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.white,
                                                fontFamily: 'poppins_semibold',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                    Positioned(
                                        top: 5.0,
                                        right: 5.0,
                                        child: InkWell(
                                          onTap: () {
                                            if (userid == "") {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (c) =>
                                                              Login()),
                                                      (r) => false);
                                            } else if (itemdata!
                                                    .data![index].isFavorite ==
                                                "0") {
                                              managefavarite(
                                                itemdata!.data![index].id,
                                                "favorite",
                                                index,
                                              );
                                            } else if (itemdata!
                                                    .data![index].isFavorite ==
                                                "1") {
                                              managefavarite(
                                                itemdata!.data![index].id,
                                                "unfavorite",
                                                index,
                                              );
                                            }
                                          },
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  17,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      80),
                                              decoration: BoxDecoration(
                                                // shape: BoxShape.values,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.black26,
                                              ),
                                              child: itemdata!.data![index]
                                                          .isFavorite ==
                                                      "0"
                                                  ? SvgPicture.asset(
                                                      'Assets/Icons/Favorite.svg',
                                                      color: Colors.white,
                                                    )
                                                  : SvgPicture.asset(
                                                      'Assets/Icons/Favoritedark.svg',
                                                      color: Colors.white,
                                                    )),
                                        )),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                95)),
                                Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                50)),
                                    Text(
                                      itemdata!.data![index].categoryInfo!
                                          .categoryName,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Poppins',
                                        color: color.greenbutton,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                50))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                50)),
                                    Expanded(
                                      child: Text(
                                        itemdata!.data![index].itemName,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 10.5.sp,
                                          fontFamily: 'Poppins_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          50,
                                      right: MediaQuery.of(context).size.width /
                                          50),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (itemdata!.data![index].hasVariation ==
                                          "1") ...[
                                        Text(
                                          currency_position == "1"
                                              ? "$currency${numberFormat.format(double.parse(itemdata!.data![index].variation![0].productPrice.toString()))}"
                                              : "${numberFormat.format(double.parse(itemdata!.data![index].variation![0].productPrice.toString()))}$currency",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontFamily: 'Poppins_bold',
                                          ),
                                        ),
                                      ] else ...[
                                        Text(
                                          currency_position == "1"
                                              ? "$currency${numberFormat.format(double.parse(itemdata!.data![index].price.toString()))}"
                                              : "${numberFormat.format(double.parse(itemdata!.data![index].price.toString()))}$currency",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontFamily: 'Poppins_bold',
                                          ),
                                        ),
                                      ],
                                      //
                                      if (itemdata!.data![index].availableQty ==
                                              "" ||
                                          int.parse(itemdata!
                                                  .data![index].availableQty
                                                  .toString()) <=
                                              0) ...[
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            height: 3.5.h,
                                            width: 17.w,
                                            child: Center(
                                              child: Text(
                                                LocaleKeys.ADD.tr(),
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 9.5.sp,
                                                    color: color.greenbutton),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ] else if (itemdata!
                                              .data![index].isCart ==
                                          "0") ...[
                                        InkWell(
                                          onTap: () async {
                                            if (itemdata!.data![index]
                                                        .hasVariation ==
                                                    "1" ||
                                                itemdata!.data![index].addons!
                                                    .isNotEmpty) {
                                              cart = await Get.to(() =>
                                                  showvariation(
                                                      itemdata!.data![index]));
                                              if (cart == 1) {
                                                setState(() {
                                                  itemdata!.data![index]
                                                      .isCart = "1";
                                                  itemdata!.data![index]
                                                      .itemQty = int.parse(
                                                          itemdata!.data![index]
                                                              .itemQty!
                                                              .toString()) +
                                                      1;
                                                });
                                              }
                                            } else {
                                              if (userid == "") {
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (c) =>
                                                                Login()),
                                                        (r) => false);
                                              } else {
                                                addtocart(
                                                    itemdata!.data![index].id,
                                                    itemdata!
                                                        .data![index].itemName,
                                                    itemdata!
                                                        .data![index].imageName,
                                                    itemdata!
                                                        .data![index].itemType,
                                                    itemdata!.data![index].tax,
                                                    itemdata!
                                                        .data![index].price);
                                                print("add to cart api");
                                              }
                                            }
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              height: 3.5.h,
                                              width: 17.w,
                                              child: Center(
                                                child: Text(
                                                  LocaleKeys.ADD.tr(),
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 9.5.sp,
                                                      color: color.greenbutton),
                                                ),
                                              )),
                                        ),
                                      ] else if (itemdata!
                                              .data![index].isCart ==
                                          "1") ...[
                                        Container(
                                          height: 3.6.h,
                                          width: 22.w,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // color: Theme.of(context).accentColor
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    loader.showErroDialog(
                                                        description: LocaleKeys
                                                                .The_item_has_multtiple_customizations_added_Go_to_cart__to_remove_item
                                                            .tr());
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: color.greenbutton,
                                                    size: 16,
                                                  )),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                child: Text(
                                                  itemdata!
                                                      .data![index].itemQty!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 10.sp),
                                                ),
                                              ),
                                              InkWell(
                                                  onTap: () async {
                                                    if (itemdata!.data![index]
                                                                .hasVariation ==
                                                            "1" ||
                                                        // ignore: prefer_is_empty
                                                        itemdata!
                                                                .data![index]
                                                                .addons!
                                                                .length >
                                                            0) {
                                                      cart = await Get.to(() =>
                                                          showvariation(
                                                              itemdata!.data![
                                                                  index]));
                                                      if (cart == 1) {
                                                        setState(
                                                          () {
                                                            itemdata!
                                                                    .data![index]
                                                                    .itemQty =
                                                                int.parse(itemdata!
                                                                        .data![
                                                                            index]
                                                                        .itemQty!
                                                                        .toString()) +
                                                                    1;
                                                          },
                                                        );
                                                      }
                                                    } else {
                                                      addtocart(
                                                          itemdata!
                                                              .data![index].id,
                                                          itemdata!.data![index]
                                                              .itemName,
                                                          itemdata!.data![index]
                                                              .imageName,
                                                          itemdata!.data![index]
                                                              .itemType,
                                                          itemdata!
                                                              .data![index].tax,
                                                          itemdata!.data![index]
                                                              .price);
                                                      print("addtocartAPI");
                                                      // addtocart(
                                                      //     index,
                                                      //     "trending");
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: color.greenbutton,
                                                    size: 16,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width /
                                            70)),
                              ]),
                            ));
                      });
                }
                return SizedBox(
                  height: 1,
                );
              },
            )));
  }
}
