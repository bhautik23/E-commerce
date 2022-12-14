// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors, unrelated_type_equality_checks, camel_case_types, must_be_immutable, file_names, avoid_print, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Trans;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/Model/cartpage/isopenclose.dart';
import 'package:ecommerce_user/Model/cartpage/ordersummaryModel.dart';
import 'package:ecommerce_user/Model/checkpromocodeModel.dart';
import 'package:ecommerce_user/Model/settings%20model/getaddressmodel.dart';
import 'package:ecommerce_user/Theme/ThemeModel.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/Allformater.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/height.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/pages/Home/Homepage.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import '../Profile/manage address.dart';
import 'Promocode.dart';
import 'Payment option.dart';

class addresscontrol extends GetxController {
  RxList addressdata = [].obs;
}

class Ordersummary extends StatefulWidget {
  String? ordertype;
  // const Ordersummary({Key? key}) : super(key: key);

  @override
  State<Ordersummary> createState() => _OrdersummaryState();
  Ordersummary([this.ordertype]);
}

class _OrdersummaryState extends State<Ordersummary> {
  order_summary_model? summarydata;
  String? userid;
  String? currency;
  String? currency_position;
  String ordersubtotal = "0";
  String deliveryfees = "0";
  String discountoffer = "0.00";
  String ordertotal = "0";
  String promocodedata = "0";
  bool? isfirstcome = true;
  addData? Addressdata;
  String? reslat;
  String? minorder_amount;
  String? maxorder_amount;
  String? reslang;
  // String? deliveryfees;
  String? deliverycharge;

  checkpromocodemodel? applypromocode;
  SummaryAPI() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userid = prefs.getString(UD_user_id);
      currency = prefs.getString(APPcurrency);
      currency_position = prefs.getString(APPcurrency_position);
      reslat = prefs.getString(restaurantlat);
      reslang = prefs.getString(restaurantlang);
      deliverycharge = prefs.getString(deliverycharges)!;
      minorder_amount = prefs.getString(min_order_amount)!;
      maxorder_amount = prefs.getString(max_order_amount)!;
      print(deliverycharge);

      var map = {
        "user_id": userid,
      };
      // print("summary $map");
      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.Summary, data: map);
      summarydata = order_summary_model.fromJson(response.data);
      ordersubtotal = summarydata!.summery!.orderTotal.toString();
      ordertotal =
          (summarydata!.summery!.orderTotal + summarydata!.summery!.tax)
              .toString();
      // print(ordertotal);
      // print(response);
      isfirstcome = false;
      return summarydata;
    } catch (e) {
      print(e);
    }
  }

  checkpromocodeAPI() async {
    try {
      loader.showLoading();
      var map = {
        "user_id": userid,
        "offer_code": promocodedata,
      };
      print(map);
      var response = await Dio()
          .post(DefaultApi.appUrl + PostAPI.Checkpromocode, data: map);
      print(response);
      applypromocode = checkpromocodemodel.fromJson(response.data);
      loader.hideLoading();
      if (applypromocode!.status == 1) {
        print(ordersubtotal);
        print(applypromocode!.data!.offerAmount);
        print(applypromocode!.data!.minAmount!);

        if ((double.parse(ordersubtotal)) <=
            (double.parse(applypromocode!.data!.minAmount!))) {
          loader.showErroDialog(
              description: LocaleKeys.You_are_not_eligeble_for_this_offer.tr());
        } else {
          if (applypromocode!.data!.offerType == "2") {
            setState(() {
              discountoffer = (double.parse(ordersubtotal) *
                      double.parse(applypromocode!.data!.offerAmount!) /
                      100)
                  .toString();

              ordertotal = (double.parse(ordertotal) -
                      (double.parse(ordersubtotal) *
                          double.parse(applypromocode!.data!.offerAmount!) /
                          100))
                  .toString();
              print("as $ordertotal");
            });
          } else {
            setState(() {
              discountoffer = applypromocode!.data!.offerAmount!;
              ordertotal = (double.parse(ordertotal) -
                      double.parse(applypromocode!.data!.offerAmount!))
                  .toString();
            });
          }

          print("$discountoffer , $ordertotal");
        }
      } else {
        loader.showErroDialog(description: applypromocode!.message!);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var maxLines = 15;
    TextEditingController Promocode = TextEditingController();
    TextEditingController Ordernote = TextEditingController();

    return Consumer(builder: (context, ThemeModel themenofier, child) {
      return SafeArea(
          child: FutureBuilder(
        future: isfirstcome == true ? SummaryAPI() : null,
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
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                  )),
              leadingWidth: 40,
              title: Text(
                LocaleKeys.Ordersummary.tr(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontFamily: 'Poppins_semibold', fontSize: 12.sp),
              ),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.only(
                bottom: 8.h,
                top: 1.h,
                left: 3.5.w,
                right: 3.5.w,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.Productsummary.tr(),
                      style: TextStyle(
                          fontFamily: 'Poppins_semibold', fontSize: 12.sp),
                    ),
                    Container(
                        // color: Colors.black12,
                        height: 14.5.h * summarydata!.data!.length,
                        margin: EdgeInsets.only(
                          top: 2.h,
                        ),
                        child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(1.h),
                                width: double.infinity,
                                height: 13.5.h,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              summarydata!
                                                  .data![index].itemName,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10.5.sp,
                                                  fontFamily: 'Poppins'),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(top: 1.h),
                                            child: Text(
                                                '${LocaleKeys.Qty.tr()} ${summarydata!.data![index].qty}',
                                                style: TextStyle(
                                                  fontSize: 9.sp,
                                                  fontFamily:
                                                      'Poppins_semibold',
                                                )),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                currency_position == "1"
                                                    ? "$currency${numberFormat.format(double.parse(summarydata!.data![index].totalPrice.toString()))}"
                                                    : "${numberFormat.format(double.parse(summarydata!.data![index].totalPrice.toString()))}$currency",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily:
                                                      'Poppins_semibold',
                                                )),
                                          ),
                                        ],
                                      )
                                    ]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 1.h,
                              );
                            },
                            itemCount: summarydata!.data!.length)),
                    Container(
                        margin: EdgeInsets.only(top: 1.2.h),
                        padding: EdgeInsets.only(
                          top: 2.5.h,
                          left: 1.2.w,
                          right: 1.2.w,
                        ),
                        width: double.infinity,
                        height: 14.5.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: themenofier.isdark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(LocaleKeys.Promocode.tr(),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins_semibold',
                                  )),
                              if (discountoffer == "0.00") ...[
                                InkWell(
                                  onTap: () async {
                                    // Get.to(() => Selectpromocode());
                                    promocodedata = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Selectpromocode(),
                                      ),
                                    );
                                    if (promocodedata != "0") {
                                      setState(() {
                                        promocodedata;
                                        Promocode.value = TextEditingValue(
                                            text: promocodedata);
                                      });
                                      print(promocodedata);
                                      print("${Promocode.text} data");
                                      // widget.promocode

                                    }
                                  },
                                  child: Text(
                                    LocaleKeys.Selectpromo.tr(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontFamily: 'Poppins',
                                      color: color.greenbutton,
                                    ),
                                  ),
                                )
                              ],
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding:
                                      EdgeInsets.only(left: 2.w, right: 2.w),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.grey)),
                                  // color: Colors.black12,
                                  height: 4.5.h,
                                  width: 63.w,
                                  child: Text(
                                    promocodedata == "0"
                                        ? LocaleKeys.haveapromocode.tr()
                                        : promocodedata,
                                    style: TextStyle(
                                        color: promocodedata == "0"
                                            ? Colors.grey
                                            : Colors.black,
                                        fontSize: 10.5.sp,
                                        fontFamily: "Poppins"),
                                  )

                                  // TextField(
                                  //   readOnly: true,
                                  //   cursorColor: Colors.black,
                                  //   textAlignVertical:
                                  //       TextAlignVertical.bottom,
                                  //   controller: Promocode,
                                  //   decoration: InputDecoration(
                                  //       hintText:  LocaleKeys.haveapromocode,
                                  //       hintStyle: TextStyle(
                                  //           color: Colors.grey,
                                  //           fontSize: 10.5.sp,
                                  //           fontFamily: "Poppins"),
                                  //       enabledBorder: OutlineInputBorder(
                                  //         borderSide:
                                  //             BorderSide(color: Colors.grey),
                                  //       ),
                                  //       focusedBorder: OutlineInputBorder(
                                  //         borderSide:
                                  //             BorderSide(color: Colors.grey),
                                  //       )),
                                  // ),

                                  ),
                              // Spacer(),
                              if (discountoffer == "0.00") ...[
                                SizedBox(
                                  height: 5.h,
                                  width: 25.w,
                                  child: TextButton(
                                    onPressed: () {
                                      if (promocodedata == "0") {
                                        loader.showErroDialog(
                                            description:
                                                "please enter promocode");
                                      } else {
                                        checkpromocodeAPI();
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: color.Metablue,
                                    ),
                                    child: Text(
                                      LocaleKeys.Apply.tr(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins_semibold',
                                          color: Colors.white,
                                          fontSize: 10.5.sp),
                                    ),
                                  ),
                                ),
                              ] else ...[
                                SizedBox(
                                  height: 5.h,
                                  width: 25.w,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        promocodedata = "0";
                                        discountoffer = "0.00";
                                        ordertotal =
                                            (summarydata!.summery!.orderTotal +
                                                    summarydata!.summery!.tax)
                                                .toString();
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: color.Metablue,
                                    ),
                                    child: Text(
                                      LocaleKeys.Remove.tr(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins_semibold',
                                          color: Colors.white,
                                          fontSize: 10.5.sp),
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          )
                        ])),
                    Container(
                      margin: EdgeInsets.only(
                        top: 2.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.Bill_Details.tr(),
                            style: TextStyle(
                                fontFamily: 'Poppins_semibold',
                                fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.Item_Total.tr(),
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 10.sp),
                              ),
                              Text(
                                currency_position == "1"
                                    ? "$currency${numberFormat.format(double.parse(summarydata!.summery!.orderTotal.toString()))}"
                                    : "${numberFormat.format(double.parse(summarydata!.summery!.orderTotal.toString()))}$currency",
                                style: TextStyle(
                                    fontFamily: 'Poppins_semiBold',
                                    fontSize: 11.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.Tax.tr(),
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 10.sp),
                              ),
                              Text(
                                currency_position == "1"
                                    ? "$currency${numberFormat.format(double.parse(summarydata!.summery!.tax.toString()))}"
                                    : "${numberFormat.format(double.parse(summarydata!.summery!.tax.toString()))}$currency",
                                style: TextStyle(
                                    fontFamily: 'Poppins_semiBold',
                                    fontSize: 11.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.Delivery_Fee.tr(),
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 10.sp),
                              ),
                              Text(
                                currency_position == "1"
                                    ? "$currency${numberFormat.format(double.parse(deliveryfees))}"
                                    : "${numberFormat.format(double.parse(deliveryfees))}$currency",
                                style: TextStyle(
                                    fontFamily: 'Poppins_semiBold',
                                    fontSize: 11.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (discountoffer == "0.00") ...[
                                Text(
                                  LocaleKeys.Discount_Offer.tr(),
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 10.sp),
                                ),
                              ] else ...[
                                Text(
                                  "${LocaleKeys.Discount_Offer} (${promocodedata.toUpperCase()})",
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 10.sp),
                                ),
                              ],
                              if (discountoffer == "0.00") ...[
                                Text(
                                  currency_position == "1"
                                      ? "$currency${numberFormat.format(double.parse(discountoffer))}"
                                      : "${numberFormat.format(double.parse(discountoffer))}$currency",
                                  style: TextStyle(
                                      fontFamily: 'Poppins_semiBold',
                                      fontSize: 11.sp),
                                ),
                              ] else ...[
                                Text(
                                  currency_position == "1"
                                      ? "-$currency${numberFormat.format(double.parse(discountoffer))}"
                                      : "-${numberFormat.format(double.parse(discountoffer))}$currency",
                                  style: TextStyle(
                                      fontFamily: 'Poppins_semiBold',
                                      fontSize: 11.sp),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 2.w, right: 2.w),
                            height: 0.8.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.Total_pay.tr(),
                                style: TextStyle(
                                    fontFamily: 'Poppins_semibold',
                                    color: color.greenbutton,
                                    fontSize: 12.5.sp),
                              ),
                              Text(
                                currency_position == "1"
                                    ? "$currency${numberFormat.format(double.parse(ordertotal))}"
                                    : "${numberFormat.format(double.parse(ordertotal))}$currency",
                                style: TextStyle(
                                    fontFamily: 'Poppins_semiBold',
                                    color: color.greenbutton,
                                    fontSize: 12.5.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          if (widget.ordertype == "1") ...[
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0.5.h,
                                bottom: 1.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.Deliveryaddress.tr(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins_semibold',
                                        fontSize: 13.sp),
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        Addressdata = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Manage_Addresses(1)),
                                        );

                                        if (Addressdata != null) {
                                          double distance = Geolocator
                                                  .distanceBetween(
                                                double.parse(reslat!),
                                                double.parse(reslang!),
                                                double.parse(Addressdata!.lat),
                                                double.parse(Addressdata!.lang),
                                              ) /
                                              1000;
                                          print("as $distance");
                                          deliveryfees = (distance *
                                                  double.parse(deliverycharge!))
                                              .toString();
                                          ordertotal = (double.parse(
                                                      ordertotal) +
                                                  double.parse(deliveryfees))
                                              .toString();
                                          print("charge $deliveryfees");

                                          setState(() {
                                            Addressdata;
                                          });
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 3.5.h,
                                        width: 18.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        child: Text(
                                          LocaleKeys.Select.tr(),
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: color.Metablue,
                                              fontSize: 10.5.sp),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 0.5.h,
                                  ),
                                  child: Image.asset(
                                    'Assets/Icons/address.png',
                                    height: 2.5.h,
                                    color: color.greenbutton,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                if (Addressdata == null) ...[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 0.5.h,
                                    ),
                                    child: Text(
                                      LocaleKeys.Please_select_delivery_address
                                          .tr(),
                                      style: TextStyle(
                                          fontSize: 10.5.sp,
                                          fontFamily: "Poppins"),
                                    ),
                                  ),
                                ] else ...[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      if (Addressdata!.addressType == "1") ...[
                                        Text(
                                          LocaleKeys.Home.tr(),
                                          style: TextStyle(
                                              fontFamily: 'Poppins_semibold',
                                              // color: color.greenbutton,
                                              fontSize: 9.sp),
                                        ),
                                      ] else if (Addressdata!.addressType ==
                                          "2") ...[
                                        Text(
                                          LocaleKeys.Office.tr(),
                                          style: TextStyle(
                                              fontFamily: 'Poppins_semibold',
                                              // color: color.greenbutton,
                                              fontSize: 9.sp),
                                        ),
                                      ] else if (Addressdata!.addressType ==
                                          "3") ...[
                                        Text(
                                          LocaleKeys.Other.tr(),
                                          style: TextStyle(
                                              fontFamily: 'Poppins_semibold',
                                              // color: color.greenbutton,
                                              fontSize: 9.sp),
                                        ),
                                      ],
                                      Text(
                                        "${Addressdata!.address} ${Addressdata!.area}",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 9.sp),
                                      )
                                    ],
                                  )
                                ],
                              ],
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                          ],
                          Text(
                            LocaleKeys.Special_instructions.tr(),
                            style: TextStyle(
                                fontFamily: 'Poppins_semibold',
                                fontSize: 12.5.sp),
                          ),
                          SizedBox(height: 1.5.h),
                          Container(
                            width: double.infinity,
                            height: 14.5.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            child: TextField(
                              controller: Ordernote,
                              maxLines: maxLines,
                              cursorColor: Colors.grey,
                              textAlignVertical: TextAlignVertical.top,
                              // controller: Phoneno,
                              decoration: InputDecoration(
                                  hintText:
                                      LocaleKeys.Write_order_instructions.tr(),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.5.sp,
                                      fontFamily: "Poppins"),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomSheet: Container(
              margin: EdgeInsets.only(
                bottom: 1.h,
                left: 3.5.w,
                right: 3.5.w,
              ),
              height: 6.h,
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  print(minorder_amount);
                  print("x $maxorder_amount");
                  print("x $ordersubtotal");
                  if (int.parse(minorder_amount!) <
                          double.parse(ordersubtotal) ||
                      int.parse(maxorder_amount!) >
                          double.parse(ordersubtotal)) {
                    print("1");
                    loader.showErroDialog(
                      description:
                          "${LocaleKeys.Order_amount_must_be_between.tr()} $minorder_amount ${LocaleKeys.TO.tr()} $maxorder_amount",
                    );
                  } else {
                    isopencloseMODEL? isopendata;

                    loader.showLoading();
                    var map = {
                      "user_id": userid,
                    };
                    print(map);
                    var response = await Dio().post(
                      DefaultApi.appUrl + PostAPI.isopenclose,
                      data: map,
                    );
                    isopendata = isopencloseMODEL.fromJson(response.data);
                    loader.hideLoading();
                    if (isopendata.status == 1) {
                      if (isopendata.isCartEmpty == "0") {
                        if (widget.ordertype == "1") {
                          if (Addressdata == null) {
                            loader.showErroDialog(
                              description: LocaleKeys
                                  .Please_select_delivery_address.tr(),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Paymentoption(
                                        double.parse(ordertotal)
                                            .toStringAsFixed(2)
                                            .toString(),
                                        widget.ordertype,
                                        promocodedata,
                                        discountoffer,
                                        summarydata!.summery!.tax.toString(),
                                        double.parse(deliveryfees)
                                            .toStringAsFixed(2)
                                            .toString(),
                                        //address
                                        Addressdata!.addressType ?? "",
                                        Addressdata!.address ?? "",
                                        Addressdata!.area ?? "",
                                        Addressdata!.houseNo ?? "",
                                        Addressdata!.lang ?? "",
                                        Addressdata!.lat ?? "",
                                        Ordernote.value.text,
                                      )),
                            );
                          }
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Paymentoption(
                                ordertotal,
                                widget.ordertype,
                                promocodedata,
                                discountoffer,
                                summarydata!.summery!.tax.toString(),
                                "0.0",
                                //address
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                Ordernote.value.text,
                              ),
                            ),
                          );
                        }
                      } else {
                        Get.to(() => Homepage(0));
                      }
                    } else {
                      loader.showErroDialog(description: isopendata.message);
                    }
                  }
                },
                style: TextButton.styleFrom(backgroundColor: color.Metablue),
                child: Text(
                  LocaleKeys.Process_to_pay.tr(),
                  style: TextStyle(
                      fontFamily: 'Poppins_semibold',
                      color: Colors.white,
                      fontSize: fontsize.Buttonfontsize),
                ),
              ),
            ),
          );
        },
      ));
    });
  }
}
