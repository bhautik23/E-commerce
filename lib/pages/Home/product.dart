// ignore_for_file: must_be_immutable, prefer_const_constructors, unrelated_type_equality_checks, unused_import, prefer_final_fields, camel_case_types, use_key_in_widget_constructors, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/pages/Authentication/Login.dart';
import 'package:ecommerce_user/Model/cartpage/Qtyupdatemodel.dart';
import 'package:ecommerce_user/Model/favoritepage/addtocartmodel.dart';
import 'package:ecommerce_user/Model/home/itemdetailsmodel.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/Allformater.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/icons.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/pages/Favorite/showvariation.dart';
import 'package:ecommerce_user/pages/Home/Homepage.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import '../Cart/cartpage.dart';

class buttoncontroller extends GetxController {
  RxInt _variationselecationindex = 0.obs;
}

class Product extends StatefulWidget {
  int? itemid;

  @override
  State<Product> createState() => _ProductState();
  Product([
    this.itemid,
  ]);
}

class _ProductState extends State<Product> {
  String? userid = "";
  int? cart;
  itemdetailsmodel? itemdata;
  buttoncontroller select = Get.put(buttoncontroller());
  cartcount count = Get.put(cartcount());
  bool? isproductdetail = true;
  String? currency;
  String? currency_position;
  List<String> arr_addonsid = [];
  List<String> arr_addonsname = [];
  List<String> arr_addonsprice = [];

  @override
  void initState() {
    super.initState();
  }

  addtocartmodel? addtocartdata;
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

      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.Addtocart, data: map);

      addtocartdata = addtocartmodel.fromJson(response.data);
      if (addtocartdata!.status == 1) {
        isproductdetail = true;
        loader.hideLoading();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(APPcart_count, addtocartdata!.cartCount.toString());

        count.cartcountnumber(int.parse(prefs.getString(APPcart_count)!));
        // setState(() {});
      }
    } catch (e) {
      rethrow;
    }
  }

  Future itemdetailsAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = (prefs.getString(UD_user_id) ?? "");
    currency = (prefs.getString(APPcurrency) ?? "");
    currency_position = (prefs.getString(APPcurrency_position) ?? "");
    loader.showLoading();
    try {
      var map = {
        "user_id": userid ?? "",
        "item_id": widget.itemid,
      };

      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.Itemdetails, data: map);

      isproductdetail = false;

      // print(response);
      // var finalist = await response.data;
      // print(object)
      itemdata = itemdetailsmodel.fromJson(response.data);
      loader.hideLoading();
      return itemdata;
    } catch (e) {
      rethrow;
    }
  }

  removefavarite(String isfavorite, String itemid) async {
    try {
      loader.showLoading();
      var map = {"user_id": userid, "item_id": itemid, "type": isfavorite};
      var response = await Dio()
          .post(DefaultApi.appUrl + PostAPI.Managefavorite, data: map);
      var finaldata = QTYupdatemodel.fromJson(response.data);
      if (finaldata.status == 1) {
        setState(() {
          isproductdetail = true;
        });

        loader.hideLoading();
      }
    } catch (e) {
      rethrow;
    }
  }

  add_to_cartAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double addonstotalprice = 0;
    for (int i = 0; i < arr_addonsprice.length; i++) {
      addonstotalprice = addonstotalprice + double.parse(arr_addonsprice[i]);
    }
    try {
      loader.showLoading();
      var map = {
        "user_id": userid,
        "item_id": itemdata!.data!.id,
        "item_name": itemdata!.data!.itemName,
        "item_image": itemdata!.data!.itemImages![0].imageName,
        "item_type": itemdata!.data!.itemType,
        "tax": numberFormat.format(double.parse(
          itemdata!.data!.tax,
        )),
        "item_price": itemdata!.data!.hasVariation == "1"
            ? numberFormat.format(double.parse(itemdata!
                .data!
                .variation![
                    int.parse(select._variationselecationindex.toString())]
                .productPrice!))
            : numberFormat.format(double.parse(itemdata!.data!.price!)),
        "variation_id": itemdata!.data!.hasVariation == "1"
            ? itemdata!
                .data!
                .variation![
                    int.parse(select._variationselecationindex.toString())]
                .id
            : "",
        "variation": itemdata!.data!.hasVariation == "1"
            ? itemdata!
                .data!
                .variation![
                    int.parse(select._variationselecationindex.toString())]
                .variation
            : "",
        "addons_id": arr_addonsid.join(","),
        "addons_name": arr_addonsname.join(","),
        "addons_price": arr_addonsprice.join(","),
        "addons_total_price": numberFormat.format(addonstotalprice),
      };

      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.Addtocart, data: map);
      var finaldata = addtocartmodel.fromJson(response.data);
      loader.hideLoading();
      if (finaldata.status == 1) {
        prefs.setString(APPcart_count, finaldata.cartCount.toString());
        count.cartcountnumber.value =
            (int.parse(prefs.getString(APPcart_count)!));

        // print("cartcount   ${count.cartcountnumber.value}");
        setState(() {
          // isproductdetail = true;
          select._variationselecationindex(2);
          // SharedPreferences prefs = await SharedPreferences.getInstance();
        });
        // Navigator.of(context).pop();
        // Navigator.pop(context, Favorite());

      } else {
        loader.showErroDialog(description: finaldata.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
      future: isproductdetail == true ? itemdetailsAPI() : null,
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
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.green,
                          child: ClipRRect(
                            child: Image.network(
                              itemdata!.data!.itemImages![0].imageUrl
                                  .toString(),
                              fit: BoxFit.fill,
                            ),
                          )),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 4.w, top: 7.3.h)),
                          Expanded(
                            child: Text(
                              itemdata!.data!.itemName.toString(),
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: 'Poppins_semibold',
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w, right: 4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              itemdata!.data!.categoryInfo!.categoryName,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontFamily: 'Poppins',
                                color: color.greenbutton,
                              ),
                            ),
                            Text(
                              itemdata!.data!.preparationTime,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontFamily: 'Poppins',
                                  color: Colors.black38),
                            ),
                          ],
                        ),
                      ),
                      Row(children: [
                        Padding(
                            padding: EdgeInsets.only(
                          left: 4.w,
                        )),
                        if (itemdata!.data!.hasVariation == "1") ...[
                          Text(
                            currency_position == "1"
                                ? "$currency${numberFormat.format(double.parse(itemdata!.data!.variation![0].productPrice.toString()))}"
                                : "${numberFormat.format(double.parse(itemdata!.data!.variation![0].productPrice.toString()))}$currency",
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontFamily: 'Poppins_bold',
                            ),
                          ),
                        ] else ...[
                          Text(
                            currency_position == "1"
                                ? "$currency${numberFormat.format(double.parse(itemdata!.data!.price.toString()))}"
                                : "${numberFormat.format(double.parse(itemdata!.data!.price.toString()))}$currency",
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontFamily: 'Poppins_bold',
                            ),
                          ),
                        ],
                      ]),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 4.w,
                          right: 4.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (itemdata!.data!.availableQty == "" ||
                                int.parse(itemdata!.data!.availableQty
                                        .toString()) <=
                                    0) ...[
                              Text(
                                LocaleKeys.Out_of_Stock.tr(),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 8.sp,
                                  color: color.blackgrey,
                                ),
                              ),
                            ] else if (itemdata!.data!.tax == "" ||
                                itemdata!.data!.tax == "0") ...[
                              Text(
                                LocaleKeys.Inclusive_of_all_taxes.tr(),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 8.sp,
                                  color: color.greenbutton,
                                ),
                              ),
                            ] else ...[
                              Text(
                                "${itemdata!.data!.tax}% ${LocaleKeys.additional_tax.tr()}",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 8.sp,
                                  color: color.redbutton,
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 4.w,
                          right: 4.w,
                          top: 1.h,
                        ),
                        child: Text(
                          LocaleKeys.Description,
                          style: TextStyle(
                              fontSize: 15.sp, fontFamily: 'Poppins_semibold'),
                        ),
                      ),
                      if (itemdata!.data!.itemDescription == "" ||
                          itemdata!.data!.itemDescription == null) ...[
                        Container(
                          margin:
                              EdgeInsets.only(left: 4.w, top: 1.h, right: 4.w),
                          alignment: Alignment.topLeft,
                          child: Text(
                            " - ",
                            style: TextStyle(
                                fontSize: 10.5.sp, fontFamily: 'Poppins'),
                          ),
                        ),
                      ] else ...[
                        Container(
                          margin:
                              EdgeInsets.only(left: 4.w, top: 1.h, right: 4.w),
                          alignment: Alignment.topLeft,
                          child: Text(
                            itemdata!.data!.itemDescription,
                            style: TextStyle(
                                fontSize: 10.5.sp, fontFamily: 'Poppins'),
                          ),
                        ),
                      ],
                      if (itemdata!.data!.hasVariation == "1") ...[
                        Container(
                          margin: EdgeInsets.only(
                              left: 4.w, top: 2.h, bottom: 1.h, right: 4.w),
                          child: Text(
                            itemdata!.data!.attribute!,
                            style: TextStyle(
                                fontFamily: 'Poppins_bold', fontSize: 15.sp),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(0),
                          height: itemdata!.data!.variation!.length * 6.5.h,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: itemdata!.data!.variation!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 5.w, bottom: 1.h, right: 5.w),
                                child: InkWell(
                                  onTap: () {
                                    select._variationselecationindex(index);
                                  },
                                  child: Row(
                                    children: [
                                      Obx(
                                        () => Container(
                                          height: 3.3.h,
                                          width: 3.3.h,
                                          decoration: BoxDecoration(
                                              color:
                                                  select._variationselecationindex ==
                                                          index
                                                      ? color.greenbutton
                                                      : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: color.greenbutton)),
                                          child: Icon(Icons.done,
                                              color:
                                                  select._variationselecationindex ==
                                                          index
                                                      ? Colors.white
                                                      : Colors.transparent,
                                              size: 13.sp),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (itemdata!.data!.variation![index]
                                                      .availableQty ==
                                                  "" ||
                                              int.parse(itemdata!
                                                      .data!
                                                      .variation![index]
                                                      .availableQty
                                                      .toString()) <=
                                                  0) ...[
                                            Text(
                                              itemdata!.data!.variation![index]
                                                  .variation!,
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Poppins_semibold',
                                                color: color.greybutton,
                                              ),
                                            ),
                                            Text(
                                              currency_position == "1"
                                                  ? "$currency${numberFormat.format(double.parse(itemdata!.data!.variation![index].productPrice!))} ${LocaleKeys.Out_of_Stock.tr()}"
                                                  : "${numberFormat.format(double.parse(itemdata!.data!.variation![index].productPrice!))}$currency ${LocaleKeys.Out_of_Stock.tr()}",
                                              style: TextStyle(
                                                fontSize: 8.sp,
                                                fontFamily: 'Poppins',
                                                color: color.greybutton,
                                              ),
                                            )
                                          ] else ...[
                                            Text(
                                              itemdata!.data!.variation![index]
                                                  .variation!,
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Poppins_semibold',
                                              ),
                                            ),
                                            Text(
                                              currency_position == "1"
                                                  ? "$currency${numberFormat.format(double.parse(itemdata!.data!.variation![index].productPrice!))}"
                                                  : "${numberFormat.format(double.parse(itemdata!.data!.variation![index].productPrice!))}$currency",
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  fontFamily: 'Poppins'),
                                            )
                                          ]
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      if (itemdata!.data!.addons!.isNotEmpty) ...[
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              left: 4.w, bottom: 1.h, right: 4.w),
                          child: Text(
                            LocaleKeys.Add_ons.tr(),
                            style: TextStyle(
                                fontFamily: 'Poppins_bold', fontSize: 15.sp),
                          ),
                        ),
                        SizedBox(
                          height: itemdata!.data!.addons!.length * 6.5.h,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: itemdata!.data!.addons!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 5.w, bottom: 1.h, right: 5.w),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      var addonobject =
                                          itemdata!.data!.addons![index];

                                      addonobject.isselected == true
                                          ? addonobject.isselected = false
                                          : addonobject.isselected = true;

                                      itemdata!.data!.addons!.removeAt(index);

                                      itemdata!.data!.addons!
                                          .insert(index, addonobject);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 3.3.h,
                                        width: 3.3.h,
                                        decoration: BoxDecoration(
                                            color: itemdata!
                                                        .data!
                                                        .addons![index]
                                                        .isselected ==
                                                    false
                                                ? Colors.transparent
                                                : color.greenbutton,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            border: Border.all(
                                                color: color.greenbutton)),
                                        child: Icon(Icons.done,
                                            color: itemdata!
                                                        .data!
                                                        .addons![index]
                                                        .isselected ==
                                                    false
                                                ? Colors.transparent
                                                : Colors.white,
                                            size: 13.sp),
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            itemdata!
                                                .data!.addons![index].name!,
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: 'Poppins_semibold',
                                            ),
                                          ),
                                          Text(
                                            currency_position == "1"
                                                ? "$currency${numberFormat.format(double.parse(itemdata!.data!.addons![index].price.toString()))}"
                                                : "${numberFormat.format(double.parse(itemdata!.data!.addons![index].price.toString()))}$currency",
                                            style: TextStyle(
                                                fontSize: 8.sp,
                                                fontFamily: 'Poppins'),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      if (itemdata!.relateditems!.isNotEmpty) ...[
                        Container(
                          margin: EdgeInsets.only(
                            left: 4.w,
                            right: 4.w,
                            bottom: 1.h,
                            top: 1.h,
                          ),
                          child: Text(
                            LocaleKeys.Related_roducts.tr(),
                            style: TextStyle(
                                fontFamily: 'Poppins_semibold',
                                fontSize: 14.5.sp),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          height: 33.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: itemdata!.relateditems!.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Product(
                                          itemdata!.relateditems![index].id)),
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                          width: 0.8.sp, color: Colors.grey)),
                                  margin: EdgeInsets.only(
                                    top: 1.h,
                                    left: 1.7.w,
                                    right: 1.7.w,
                                  ),
                                  height: 32,
                                  width: 45.w,
                                  child: Column(children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 20.h,
                                          width: 46.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight:
                                                      Radius.circular(5))),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5)),
                                            child: Image.network(
                                              itemdata!.relateditems![index]
                                                  .imageUrl,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        if (itemdata!.relateditems![index]
                                                .hasVariation ==
                                            "0") ...[
                                          if (itemdata!.relateditems![index]
                                                      .availableQty ==
                                                  "" ||
                                              int.parse(itemdata!
                                                      .relateditems![index]
                                                      .availableQty
                                                      .toString()) <=
                                                  0) ...[
                                            Positioned(
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 20.h,
                                                width: 46.w,
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
                                            right: 5.0,
                                            top: 5.0,
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
                                                        .relateditems![index]
                                                        .isFavorite ==
                                                    "0") {
                                                  removefavarite(
                                                      "favorite",
                                                      itemdata!
                                                          .relateditems![index]
                                                          .id
                                                          .toString());
                                                } else {
                                                  removefavarite(
                                                      "unfavorite",
                                                      itemdata!
                                                          .relateditems![index]
                                                          .id
                                                          .toString());
                                                }
                                              },
                                              child: Container(
                                                  height: 6.h,
                                                  width: 12.w,
                                                  padding: EdgeInsets.all(9.sp),
                                                  // margin: EdgeInsets.only(
                                                  //     left: 30.5.w,
                                                  //     top: MediaQuery.of(context)
                                                  //             .size
                                                  //             .height /
                                                  //         99),
                                                  decoration: BoxDecoration(
                                                    // shape: BoxShape.values,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.black26,
                                                  ),
                                                  child: itemdata!
                                                              .relateditems![
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
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.w, right: 2.w, top: 1.h),
                                          child: Row(
                                            children: [
                                              Text(
                                                itemdata!.relateditems![index]
                                                    .categoryInfo!.categoryName,
                                                style: TextStyle(
                                                    fontSize: 8.5.sp,
                                                    fontFamily: 'Poppins',
                                                    color: color.greenbutton,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 2.w,
                                            right: 2.w,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  itemdata!.relateditems![index]
                                                      .itemName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.w,
                                              right: 2.w,
                                              top: 1.3.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (itemdata!.relateditems![index]
                                                      .hasVariation ==
                                                  "1") ...[
                                                Text(
                                                  currency_position == "1"
                                                      ? "$currency${numberFormat.format(double.parse(itemdata!.relateditems![index].variation![0].productPrice.toString()))}"
                                                      : "${numberFormat.format(double.parse(itemdata!.relateditems![index].variation![0].productPrice.toString()))}$currency",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'Poppins_bold',
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ] else ...[
                                                Text(
                                                  currency_position == "1"
                                                      ? "$currency${numberFormat.format(double.parse(itemdata!.relateditems![index].price.toString()))}"
                                                      : "${numberFormat.format(double.parse(itemdata!.relateditems![index].price.toString()))}$currency",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'Poppins_bold',
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                              if (itemdata!.relateditems![index]
                                                      .hasVariation ==
                                                  "0") ...[
                                                if (itemdata!
                                                            .relateditems![
                                                                index]
                                                            .availableQty ==
                                                        "" ||
                                                    int.parse(itemdata!
                                                            .relateditems![
                                                                index]
                                                            .availableQty
                                                            .toString()) <=
                                                        0) ...[
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey)),
                                                      height: 3.5.h,
                                                      width: 17.w,
                                                      child: Center(
                                                        child: Text(
                                                          LocaleKeys.ADD.tr(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 9.5.sp,
                                                              color: color
                                                                  .greenbutton),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ]
                                              ] else if (itemdata!
                                                      .relateditems![index]
                                                      .isCart ==
                                                  "0") ...[
                                                InkWell(
                                                  onTap: () async {
                                                    if (itemdata!
                                                                .relateditems![
                                                                    index]
                                                                .hasVariation ==
                                                            "1" ||
                                                        itemdata!
                                                            .relateditems![
                                                                index]
                                                            .addons!
                                                            .isNotEmpty) {
                                                      cart = await Get.to(() =>
                                                          showvariation(itemdata!
                                                                  .relateditems![
                                                              index]));
                                                      if (cart == 1) {
                                                        setState(() {
                                                          itemdata!
                                                              .relateditems![
                                                                  index]
                                                              .isCart = "1";
                                                          itemdata!
                                                              .relateditems![
                                                                  index]
                                                              .itemQty = int
                                                                  .parse(
                                                                itemdata!
                                                                    .relateditems![
                                                                        index]
                                                                    .itemQty!
                                                                    .toString(),
                                                              ) +
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
                                                            itemdata!
                                                                .relateditems![
                                                                    index]
                                                                .id,
                                                            itemdata!
                                                                .relateditems![
                                                                    index]
                                                                .itemName,
                                                            itemdata!
                                                                .relateditems![
                                                                    index]
                                                                .imageName,
                                                            itemdata!
                                                                .relateditems![
                                                                    index]
                                                                .itemType,
                                                            itemdata!
                                                                .relateditems![
                                                                    index]
                                                                .tax,
                                                            itemdata!
                                                                .relateditems![
                                                                    index]
                                                                .price);
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        border: Border.all(
                                                            color:
                                                                Colors.grey)),
                                                    height: 3.5.h,
                                                    width: 17.w,
                                                    child: Center(
                                                      child: Text(
                                                        LocaleKeys.ADD.tr(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 9.5.sp,
                                                            color: color
                                                                .greenbutton),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ] else if (itemdata!
                                                      .relateditems![index]
                                                      .isCart ==
                                                  "1") ...[
                                                Container(
                                                  height: 3.6.h,
                                                  width: 22.w,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    // color: Theme.of(context).accentColor
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            loader
                                                                .showErroDialog(
                                                              description:
                                                                  LocaleKeys
                                                                          .The_item_has_multtiple_customizations_added_Go_to_cart__to_remove_item
                                                                      .tr(),
                                                            );
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: color
                                                                .greenbutton,
                                                            size: 16,
                                                          )),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                        child: Text(
                                                          itemdata!
                                                              .relateditems![
                                                                  index]
                                                              .itemQty!
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 10.sp),
                                                        ),
                                                      ),
                                                      InkWell(
                                                          onTap: () async {
                                                            if (itemdata!
                                                                        .relateditems![
                                                                            index]
                                                                        .hasVariation ==
                                                                    "1" ||
                                                                // ignore: prefer_is_empty
                                                                itemdata!
                                                                        .relateditems![
                                                                            index]
                                                                        .addons!
                                                                        .length >
                                                                    0) {
                                                              cart = await Get.to(() =>
                                                                  showvariation(
                                                                      itemdata!
                                                                              .relateditems![
                                                                          index]));
                                                              if (cart == 1) {
                                                                setState(() {
                                                                  itemdata!
                                                                      .relateditems![
                                                                          index]
                                                                      .itemQty = int
                                                                          .parse(
                                                                        itemdata!
                                                                            .relateditems![index]
                                                                            .itemQty!
                                                                            .toString(),
                                                                      ) +
                                                                      1;
                                                                });
                                                              }
                                                            } else {
                                                              addtocart(
                                                                  itemdata!
                                                                      .relateditems![
                                                                          index]
                                                                      .id,
                                                                  itemdata!
                                                                      .relateditems![
                                                                          index]
                                                                      .itemName,
                                                                  itemdata!
                                                                      .relateditems![
                                                                          index]
                                                                      .imageName,
                                                                  itemdata!
                                                                      .relateditems![
                                                                          index]
                                                                      .itemType,
                                                                  itemdata!
                                                                      .relateditems![
                                                                          index]
                                                                      .tax,
                                                                  itemdata!
                                                                      .relateditems![
                                                                          index]
                                                                      .price);

                                                              // addtocart(
                                                              //     index,
                                                              //     "trending");
                                                            }
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: color
                                                                .greenbutton,
                                                            size: 16,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.2.h,
                                        )
                                      ],
                                    )
                                  ])),
                            ),
                          ),
                        ),
                      ],
                      SizedBox(
                        height: 9.h,
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: 1.h,
                    left: 3.w,
                    child: Container(
                        height: 5.5.h,
                        width: 5.5.h,
                        // margin: EdgeInsets.only(left: 2.5.w, top: 1.5.h),
                        decoration: BoxDecoration(
                          // shape: BoxShape.values,
                          borderRadius: BorderRadius.circular(6),
                          color: color.blackbutton,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ))),
                Positioned(
                  right: 3.w,
                  top: 1.h,
                  child: Container(
                    height: 5.5.h,
                    width: 5.5.h,
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.height / 80),
                    // margin: EdgeInsets.only(left: 86.w, top: 1.5.h),
                    decoration: BoxDecoration(
                      // shape: BoxShape.values,
                      borderRadius: BorderRadius.circular(6),
                      color: color.blackbutton,
                    ),
                    child: InkWell(
                      onTap: () {
                        if (userid == "") {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (c) => Login()),
                              (r) => false);
                        } else if (itemdata!.data!.isFavorite == "0") {
                          removefavarite("favorite", widget.itemid.toString());
                        } else {
                          removefavarite(
                              "unfavorite", widget.itemid.toString());
                        }
                      },
                      child: itemdata!.data!.isFavorite == "0"
                          ? SvgPicture.asset(
                              'Assets/Icons/Favorite.svg',
                              color: Colors.white,
                            )
                          : SvgPicture.asset(
                              'Assets/Icons/Favoritedark.svg',
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            bottomSheet: Container(
                color: Colors.white,
                height: 8.h,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: color.Metablue)),
                        height: 6.5.h,
                        width: 47.w,
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                            // Background color
                            // foregroundColor:
                            //     Colors.grey, // Text Color (Foreground color)
                          ),
                          child: Obx(() => count.cartcountnumber == 0
                              ? Text(
                                  LocaleKeys.Viewcart.tr(),
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: color.Metablue,
                                      fontSize: 13.sp),
                                )
                              : Text(
                                  "${LocaleKeys.Viewcart.tr()}(${count.cartcountnumber.value.toString()})",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: color.Metablue,
                                      fontSize: 13.sp),
                                )),
                          onPressed: () {
                            if (userid == "") {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (c) => Login()),
                                  (r) => false);
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homepage(2)),
                              );
                            }
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: color.Metablue,
                          ),
                        ),
                        height: 6.5.h,
                        width: 47.w,
                        child: TextButton(
                          onPressed: () {
                            arr_addonsid.clear();
                            arr_addonsname.clear();
                            arr_addonsprice.clear();
                            for (int i = 0;
                                i < itemdata!.data!.addons!.length;
                                i++) {
                              if (itemdata!.data!.addons![i].isselected ==
                                  true) {
                                arr_addonsid.add(
                                    itemdata!.data!.addons![i].id.toString());
                                arr_addonsname.add(
                                    itemdata!.data!.addons![i].name.toString());
                                arr_addonsprice.add(numberFormat.format(
                                    double.parse(itemdata!
                                        .data!.addons![i].price
                                        .toString())));
                              }
                            }

                            add_to_cartAPI();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: color.Metablue,
                          ),
                          child: Text(
                            LocaleKeys.Add_to_cart.tr(),
                            style: TextStyle(
                                fontFamily: 'Poppins_Bold',
                                color: Colors.white,
                                fontSize: 13.sp),
                          ),
                        ),
                      ),
                    ])));
      },
    ));
  }
}
