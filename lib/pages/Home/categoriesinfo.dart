// ignore_for_file: camel_case_types, must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names, avoid_print, no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/pages/Authentication/Login.dart';
import 'package:ecommerce_user/Model/cartpage/Qtyupdatemodel.dart';
import 'package:ecommerce_user/Model/favoritepage/addtocartmodel.dart';
import 'package:ecommerce_user/Model/home/categories_itemmodel.dart';
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

class categories_items extends StatefulWidget {
  String? catid;
  String? title;

  @override
  State<categories_items> createState() => categories_itemsState();
  categories_items([
    this.catid,
    this.title,
  ]);
}

class categories_itemsState extends State<categories_items> {
  String? userid;
  String? currency;
  String? currency_position;
  TabController? tabController;
  int? cart;
  categories_item_model? categoriesdata;
  addtocartmodel? addtocartdata;
  cartcount count = Get.put(cartcount());

  categories_itemAPi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userid = prefs.getString(UD_user_id) ?? "";
      currency = prefs.getString(APPcurrency);
      currency_position = prefs.getString(APPcurrency_position);
      var map = {
        "user_id": userid,
        "cat_id": widget.catid,
      };
      print(map);
      var response = await Dio()
          .post(DefaultApi.appUrl + PostAPI.Categoryitems, data: map);
      print(response);
      categoriesdata = categories_item_model.fromJson(response.data);

      return categoriesdata;
    } catch (e) {
      print(e);
    }
  }

  addtocart(itemid, itemname, itemimage, itemtype, itemtax, itemprice) async {
    try {
      loader.showLoading();
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
      }
    } catch (e) {
      print(e);
    }
  }

  managefavarite(var itemid, String isfavorite, index, _index) async {
    try {
      loader.showLoading();
      var map = {"user_id": userid, "item_id": itemid, "type": isfavorite};
      print(map);

      var favoriteresponse = await Dio()
          .post(DefaultApi.appUrl + PostAPI.Managefavorite, data: map);
      print(favoriteresponse);
      var finaldata = QTYupdatemodel.fromJson(favoriteresponse.data);

      if (finaldata.status == 1) {
        loader.hideLoading();

        setState(() {
          isfavorite == "favorite"
              ? categoriesdata!
                  .items![_index].subcategoryItems![index].isFavorite = "1"
              : categoriesdata!
                  .items![_index].subcategoryItems![index].isFavorite = "0";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categories_itemAPi(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SafeArea(
              child: Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: color.Metablue,
              ),
            ),
          ));
        }
        return SafeArea(
          child: DefaultTabController(
            length: categoriesdata!.items!.length,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 20,
                    )),
                automaticallyImplyLeading: false,
                // elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                title: Text(
                  widget.title!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'Poppins_semibold',
                  ),
                ),
                bottom: TabBar(
                  // dragStartBehavior: DragStartBehavior.start,
                  isScrollable: true,
                  controller: tabController,
                  labelColor: color.blackbutton,
                  labelStyle: TextStyle(
                    fontFamily: 'Poppins_semibold',
                    fontSize: 11.sp,
                  ),
                  indicatorColor: color.blackbutton,
                  indicatorWeight: 3,
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: TextStyle(
                    fontFamily: 'Poppins_semibold',
                    fontSize: 11.sp,
                  ),
                  tabs: List.generate(categoriesdata!.items!.length, (index) {
                    return Tab(
                      text: categoriesdata!.items![index].subcategoryName,
                    );
                  }),
                ),
              ),
              body: TabBarView(
                  controller: tabController,
                  children:
                      List.generate(categoriesdata!.items!.length, (_index) {
                    if (categoriesdata!
                        .items![_index].subcategoryItems!.isEmpty) {
                      return Center(
                        child: Text(LocaleKeys.No_data_found.tr()),
                      );
                    }
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: categoriesdata!
                            .items![_index].subcategoryItems!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.65,
                                crossAxisSpacing: 10,
                                crossAxisCount: 2),
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 33,
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
                                  Get.to(() => Product(categoriesdata!
                                      .items![_index]
                                      .subcategoryItems![index]
                                      .id));
                                },
                                child: Column(children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5)),
                                          child: Image.network(
                                            categoriesdata!
                                                .items![_index]
                                                .subcategoryItems![index]
                                                .imageUrl,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      if (categoriesdata!
                                              .items![_index]
                                              .subcategoryItems![index]
                                              .hasVariation ==
                                          "0") ...[
                                        if (categoriesdata!
                                                    .items![_index]
                                                    .subcategoryItems![index]
                                                    .availableQty ==
                                                "" ||
                                            int.parse(categoriesdata!
                                                    .items![_index]
                                                    .subcategoryItems![index]
                                                    .availableQty
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
                                                  fontFamily:
                                                      'poppins_semibold',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
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
                                              } else if (categoriesdata!
                                                      .items![_index]
                                                      .subcategoryItems![index]
                                                      .isFavorite ==
                                                  "0") {
                                                managefavarite(
                                                    categoriesdata!
                                                        .items![_index]
                                                        .subcategoryItems![
                                                            index]
                                                        .id,
                                                    "favorite",
                                                    index,
                                                    _index);
                                              } else {
                                                managefavarite(
                                                    categoriesdata!
                                                        .items![_index]
                                                        .subcategoryItems![
                                                            index]
                                                        .id,
                                                    "unfavorite",
                                                    index,
                                                    _index);
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
                                                child: categoriesdata!
                                                            .items![_index]
                                                            .subcategoryItems![
                                                                index]
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
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
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
                                        categoriesdata!
                                            .items![_index]
                                            .subcategoryItems![index]
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
                                          categoriesdata!
                                              .items![_index]
                                              .subcategoryItems![index]
                                              .itemName,
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
                                        left:
                                            MediaQuery.of(context).size.width /
                                                50,
                                        right:
                                            MediaQuery.of(context).size.width /
                                                50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (categoriesdata!
                                                .items![_index]
                                                .subcategoryItems![index]
                                                .hasVariation ==
                                            "1") ...[
                                          Text(
                                            currency_position == "1"
                                                ? "$currency${numberFormat.format(double.parse(categoriesdata!.items![_index].subcategoryItems![index].variation![0].productPrice.toString()))}"
                                                : "${numberFormat.format(double.parse(categoriesdata!.items![_index].subcategoryItems![index].variation![0].productPrice.toString()))}$currency",
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily: 'Poppins_bold',
                                            ),
                                          ),
                                        ] else ...[
                                          Text(
                                            currency_position == "1"
                                                ? "$currency${numberFormat.format(double.parse(categoriesdata!.items![_index].subcategoryItems![index].price.toString()))}"
                                                : "${numberFormat.format(double.parse(categoriesdata!.items![_index].subcategoryItems![index].price.toString()))}$currency",
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily: 'Poppins_bold',
                                            ),
                                          ),
                                        ],
                                        if (categoriesdata!
                                                    .items![_index]
                                                    .subcategoryItems![index]
                                                    .availableQty ==
                                                "" ||
                                            int.parse(categoriesdata!
                                                    .items![_index]
                                                    .subcategoryItems![index]
                                                    .availableQty
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
                                        ] else if (categoriesdata!
                                                .items![_index]
                                                .subcategoryItems![index]
                                                .isCart ==
                                            "0") ...[
                                          InkWell(
                                            onTap: () async {
                                              if (categoriesdata!
                                                          .items![_index]
                                                          .subcategoryItems![
                                                              index]
                                                          .hasVariation ==
                                                      "1" ||
                                                  categoriesdata!
                                                      .items![_index]
                                                      .subcategoryItems![index]
                                                      .addons!
                                                      .isNotEmpty) {
                                                cart = await Get.to(() =>
                                                    showvariation(categoriesdata!
                                                            .items![_index]
                                                            .subcategoryItems![
                                                        index]));
                                                if (cart == 1) {
                                                  setState(() {
                                                    categoriesdata!
                                                        .items![_index]
                                                        .subcategoryItems![
                                                            index]
                                                        .isCart = "1";
                                                    categoriesdata!
                                                        .items![_index]
                                                        .subcategoryItems![
                                                            index]
                                                        .itemQty = int.parse(
                                                            categoriesdata!
                                                                .items![_index]
                                                                .subcategoryItems![
                                                                    index]
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
                                                      categoriesdata!
                                                          .items![_index]
                                                          .subcategoryItems![
                                                              index]
                                                          .id,
                                                      categoriesdata!
                                                          .items![_index]
                                                          .subcategoryItems![
                                                              index]
                                                          .itemName,
                                                      categoriesdata!
                                                          .items![_index]
                                                          .subcategoryItems![
                                                              index]
                                                          .imageName,
                                                      categoriesdata!
                                                          .items![_index]
                                                          .subcategoryItems![
                                                              index]
                                                          .itemType,
                                                      categoriesdata!
                                                          .items![_index]
                                                          .subcategoryItems![
                                                              index]
                                                          .tax,
                                                      categoriesdata!
                                                          .items![_index]
                                                          .subcategoryItems![
                                                              index]
                                                          .price);
                                                  print("add to cart api");
                                                }
                                              }
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
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
                                                        color:
                                                            color.greenbutton),
                                                  ),
                                                )),
                                          ),
                                        ] else if (categoriesdata!
                                                .items![_index]
                                                .subcategoryItems![index]
                                                .isCart ==
                                            "1") ...[
                                          Container(
                                            height: 3.6.h,
                                            width: 22.w,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
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
                                                              .The_item_has_multtiple_customizations_added_Go_to_cart__to_remove_item);
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: color.greenbutton,
                                                      size: 16,
                                                    )),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  child: Text(
                                                    categoriesdata!
                                                        .items![_index]
                                                        .subcategoryItems![
                                                            index]
                                                        .itemQty!
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10.sp),
                                                  ),
                                                ),
                                                InkWell(
                                                    onTap: () async {
                                                      if (categoriesdata!
                                                                  .items![
                                                                      _index]
                                                                  .subcategoryItems![
                                                                      index]
                                                                  .hasVariation ==
                                                              "1" ||
                                                          // ignore: prefer_is_empty
                                                          categoriesdata!
                                                                  .items![
                                                                      _index]
                                                                  .subcategoryItems![
                                                                      index]
                                                                  .addons!
                                                                  .length >
                                                              0) {
                                                        cart = await Get.to(
                                                            () => showvariation(
                                                                categoriesdata!
                                                                        .items![
                                                                            _index]
                                                                        .subcategoryItems![
                                                                    index]));

                                                        if (cart == 1) {
                                                          setState(() {
                                                            categoriesdata!
                                                                .items![_index]
                                                                .subcategoryItems![
                                                                    index]
                                                                .itemQty = int.parse(categoriesdata!
                                                                    .items![
                                                                        _index]
                                                                    .subcategoryItems![
                                                                        index]
                                                                    .itemQty!
                                                                    .toString()) +
                                                                1;
                                                          });
                                                        }
                                                        // await Navigator
                                                        //     .push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //       builder: (context) =>
                                                        //           showvariation(
                                                        //               favoritedata!.data![
                                                        //                   index]),
                                                        //       fullscreenDialog:
                                                        //           true),
                                                        // ).then((value) =>
                                                        //     setState(
                                                        //         () {}));

                                                      } else {
                                                        addtocart(
                                                            categoriesdata!
                                                                .items![_index]
                                                                .subcategoryItems![
                                                                    index]
                                                                .id,
                                                            categoriesdata!
                                                                .items![_index]
                                                                .subcategoryItems![
                                                                    index]
                                                                .itemName,
                                                            categoriesdata!
                                                                .items![_index]
                                                                .subcategoryItems![
                                                                    index]
                                                                .imageName,
                                                            categoriesdata!
                                                                .items![_index]
                                                                .subcategoryItems![
                                                                    index]
                                                                .itemType,
                                                            categoriesdata!
                                                                .items![_index]
                                                                .subcategoryItems![
                                                                    index]
                                                                .tax,
                                                            categoriesdata!
                                                                .items![_index]
                                                                .subcategoryItems![
                                                                    index]
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
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              70)),
                                ]),
                              ));
                        });
                  })),
            ),
          ),
        );
      },
    );
  }
}
