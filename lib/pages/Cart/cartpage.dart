// ignore_for_file: unrelated_type_equality_checks, prefer_const_constructors, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:ecommerce_user/Model/cartpage/Qtyupdatemodel.dart';
import 'package:ecommerce_user/Model/cartpage/cartlistmodel.dart';
import 'package:ecommerce_user/Model/cartpage/isopenclose.dart';
import 'package:ecommerce_user/Model/changepasswordmodel.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/Allformater.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/height.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/pages/Home/Homepage.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'Ordersummary.dart';

class Viewcart extends StatefulWidget {
  const Viewcart({Key? key}) : super(key: key);

  @override
  State<Viewcart> createState() => _ViewcartState();
}

class _ViewcartState extends State<Viewcart> {
  int showbutton = 0;
  cartlistmodel? cartdata;
  String? currency;
  String? currency_position;
  String? userid;
  cartcount count = Get.put(cartcount());

  cartlistAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString(UD_user_id);
    currency = (prefs.getString(APPcurrency) ?? "");
    currency_position = (prefs.getString(APPcurrency_position) ?? "");

    try {
      var map = {"user_id": userid};

      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.Getcart, data: map);
      var finalist = await response.data;
      cartdata = cartlistmodel.fromJson(finalist);
      count.cartcountnumber(cartdata!.data!.length);

      return cartdata!.data;
    } catch (e) {
      rethrow;
    }
  }

  changeQTYAPI(userid, cartid, qty) async {
    try {
      loader.showLoading();
      var map = {
        "user_id": userid.toString(),
        "cart_id": cartid.toString(),
        "qty": qty.toString()
      };
      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.Qtyupdate, data: map);

      var finallist = await response.data;
      var QTYdata = QTYupdatemodel.fromJson(finallist);
      if (QTYdata.status == 1) {
        loader.hideLoading();
        setState(() {
          cartlistAPI();
          // cartdata.data.removeAt(index)
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  deleteitem(cartid) async {
    loader.showLoading();
    try {
      var map = {"cart_id": cartid};
      var response = await Dio()
          .post(DefaultApi.appUrl + PostAPI.Deletecartitem, data: map);
      var data = changepasswordmodel.fromJson(response.data);
      setState(() {
        cartdata!.data!.remove(cartid);
      });
      loader.hideLoading();
    } catch (e) {
      rethrow;
    }
  }

  isopencloseMODEL? isopendata;
  isopenAPI() async {
    loader.showLoading();
    var map = {
      "user_id": userid,
    };

    var response = await Dio().post(
      DefaultApi.appUrl + PostAPI.isopenclose,
      data: map,
    );
    isopendata = isopencloseMODEL.fromJson(response.data);
    loader.hideLoading();
    if (isopendata!.status == 1) {
      if (isopendata!.isCartEmpty == "0") {
        Get.to(() => Ordersummary("1"));
      } else {
        Get.to(() => Homepage(0));
      }
    } else {
      loader.showErroDialog(description: isopendata!.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
      future: cartlistAPI(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: color.Metablue,
              ),
            ),
          );
        } else if (cartdata!.data!.isEmpty) {
          return Scaffold(
            body: Center(
              child: Text(
                LocaleKeys.No_data_found.tr(),
                style: TextStyle(
                    fontFamily: 'Poppins', fontSize: 11.sp, color: Colors.grey),
              ),
            ),
          );
        }
        return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                LocaleKeys.Mycart.tr(),
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontFamily: 'Poppins_semibold',
                ),
              ),
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: EdgeInsets.only(bottom: 6.5.h),
              child: ListView.builder(
                itemCount: cartdata!.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                        top: 1.h, left: 1.5.h, right: 1.5.h, bottom: 1.h),
                    height: 15.5.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.8.sp,
                        )),
                    child: Row(children: [
                      SizedBox(
                        width: 28.w,
                        height: 15.5.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              bottomLeft: Radius.circular(7)),
                          child: Image.network(
                            cartdata!.data![index].itemImage.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 1.h, right: 2.w, left: 2.w, bottom: 0.8.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      cartdata!.data![index].itemName
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: 'Poppins_semibold',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  if (cartdata!.data![index].variation ==
                                      "") ...[
                                    Expanded(
                                      child: Text(
                                        "-",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 9.sp,
                                          color: Colors.grey,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    Expanded(
                                      child: Text(
                                        cartdata!.data![index].variation
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 9.sp,
                                          color: Colors.grey,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                              Row(
                                children: [
                                  if (cartdata!.data![index].addonsName ==
                                      "") ...[
                                    Expanded(
                                      child: Text(
                                        "-",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 9.sp,
                                          color: Colors.grey,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    Expanded(
                                      child: Text(
                                        cartdata!.data![index].addonsName
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 9.sp,
                                          color: Colors.grey,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(children: [
                                  SizedBox(
                                    child: Text(
                                      currency_position == "1"
                                          ? "$currency${(numberFormat.format(double.parse(cartdata!.data![index].itemPrice!.toString()) * int.parse(cartdata!.data![index].qty.toString())))}"
                                          : "${(numberFormat.format(double.parse(cartdata!.data![index].itemPrice!.toString()) * int.parse(cartdata!.data![index].qty.toString())))}$currency",
                                      // '\$${numberFormat.format(int.parse(${cartdata!.data![index].itemPrice.toString()}* ${cartdata!.data![index].qty)})}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins_semibold',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 3.6.h,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                      // color: Theme.of(context).accentColor
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              if (cartdata!.data![index].qty ==
                                                  "1") {
                                                deleteitem(
                                                    cartdata!.data![index].id);
                                              } else {
                                                changeQTYAPI(
                                                  cartdata!.data![index].userId,
                                                  cartdata!.data![index].id,
                                                  int.parse(cartdata!
                                                          .data![index].qty
                                                          .toString()) -
                                                      1,
                                                );
                                              }
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
                                            cartdata!.data![index].qty
                                                .toString(),
                                            style: TextStyle(fontSize: 10.sp),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              changeQTYAPI(
                                                cartdata!.data![index].userId,
                                                cartdata!.data![index].id,
                                                int.parse(cartdata!
                                                        .data![index].qty
                                                        .toString()) +
                                                    1,
                                              );
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: color.greenbutton,
                                              size: 16,
                                            )),
                                      ],
                                    ),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
                  );
                },
              ),
            ),
            bottomSheet: Container(
              margin: EdgeInsets.only(
                left: 3.w,
                right: 3.w,
                top: 1.h,
              ),
              height: 6.5.h,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  isopenAPI();
                },
                style: TextButton.styleFrom(
                  backgroundColor: color.Metablue,
                ),
                child: Text(
                  LocaleKeys.Checkout.tr(),
                  style: TextStyle(
                      fontFamily: 'Poppins_semibold',
                      color: Colors.white,
                      fontSize: fontsize.Buttonfontsize),
                ),
              ),
            ));
      },
    ));
  }
}
