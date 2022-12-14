// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_string_interpolations, must_be_immutable, use_key_in_widget_constructors, body_might_complete_normally_nullable, avoid_print, unrelated_type_equality_checks, unused_local_variable, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/Model/cartpage/Qtyupdatemodel.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/Allformater.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../Model/Ordersmodel/orderdetailsModel.dart';
import '../Cart/cartpage.dart';

class Orderdetails extends StatefulWidget {
  String? Orderid;

  @override
  State<Orderdetails> createState() => _OrderdetailsState();
  Orderdetails([this.Orderid]);
}

class _OrderdetailsState extends State<Orderdetails> {
  Orderdetailsmodel? Orderdetailsdata;
  dynamic alldata;
  String? currency;
  String? currency_position;

  Future<Orderdetailsmodel?> OrderdetailsAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString(UD_user_id)!;
    currency = (prefs.getString('currency') ?? "");
    currency_position = (prefs.getString('currency_position') ?? "");

    try {
      var map = {
        "order_id": widget.Orderid,
      };
      print(map);
      var response = await Dio()
          .post(DefaultApi.appUrl + PostAPI.Getorderdetails, data: map);

      var finalist = await response.data;
      // alldata = jsonDecode(finalist.toString());
      // print(alldata.data);
      print(finalist);
      Orderdetailsdata = Orderdetailsmodel.fromJson(finalist);

      return Orderdetailsdata;
    } catch (e) {
      print(e);
    }
  }

  cancelorder() async {
    try {
      var map = {"order_id": widget.Orderid};
      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.ordercancel, data: map);
      var finaldata = QTYupdatemodel.fromJson(response.data);
      if (finaldata.status == 1) {
        Navigator.of(context).pop();
      } else {
        loader.showErroDialog(description: finaldata.message);
      }
    } catch (e) {
      loader.showErroDialog(description: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: OrderdetailsAPI(),
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
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => Viewcart()),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 20,
                    )),
                title: Text(
                  LocaleKeys.Order_Details.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins_semibold', fontSize: 12.sp),
                ),
                centerTitle: true,
              ),
              body: Container(
                margin: EdgeInsets.only(
                  top: 2.h,
                  left: 3.w,
                  right: 3.w,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(1.h),
                          width: double.infinity,
                          height: 16.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(6)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "#${Orderdetailsdata?.summery!.orderNumber}",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'Poppins_bold'),
                                    ),
                                    Spacer(),
                                    if (Orderdetailsdata?.summery!.status ==
                                        "1") ...[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: color.greybutton,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(7),
                                        height: 4.5.h,
                                        child: Center(
                                          child: Text(
                                            LocaleKeys.Placed.tr(),
                                            style: TextStyle(
                                              fontSize: 9.5.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ] else if (Orderdetailsdata
                                            ?.summery!.status ==
                                        "2") ...[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: color.orange,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(7),
                                        height: 4.5.h,
                                        child: Center(
                                          child: Text(LocaleKeys.Preparing.tr(),
                                              style: TextStyle(
                                                  fontSize: 9.5.sp,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white)),
                                        ),
                                      )
                                    ] else if (Orderdetailsdata
                                            ?.summery!.status ==
                                        "3") ...[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: color.skyblue,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(7),
                                        height: 4.5.h,
                                        child: Center(
                                          child: Text(LocaleKeys.Ready.tr(),
                                              style: TextStyle(
                                                  fontSize: 9.5.sp,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white)),
                                        ),
                                      )
                                    ] else if (Orderdetailsdata
                                            ?.summery!.status ==
                                        "4") ...[
                                      if (Orderdetailsdata
                                              ?.summery!.orderType ==
                                          "1") ...[
                                        Container(
                                          decoration: BoxDecoration(
                                              color: color.blue,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          padding: EdgeInsets.all(7),
                                          height: 4.5.h,
                                          child: Center(
                                            child: Text(
                                                LocaleKeys.On_the_way.tr(),
                                                style: TextStyle(
                                                    fontSize: 9.5.sp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white)),
                                          ),
                                        )
                                      ] else if (Orderdetailsdata
                                              ?.summery!.status ==
                                          "2") ...[
                                        Container(
                                          decoration: BoxDecoration(
                                              color: color.blue,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          padding: EdgeInsets.all(7),
                                          height: 4.5.h,
                                          child: Center(
                                            child: Text(
                                                LocaleKeys.Waiting_for_pickup
                                                    .tr(),
                                                style: TextStyle(
                                                    fontSize: 9.5.sp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white)),
                                          ),
                                        )
                                      ]
                                    ] else if (Orderdetailsdata
                                            ?.summery!.status ==
                                        "5") ...[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: color.greenbutton,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(7),
                                        height: 4.5.h,
                                        child: Center(
                                          child: Text(
                                            LocaleKeys.Completed.tr(),
                                            style: TextStyle(
                                              fontSize: 9.5.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ] else if (Orderdetailsdata
                                            ?.summery!.status ==
                                        "6") ...[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xffFF3B30),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(7),
                                        height: 4.5.h,
                                        child: Center(
                                          child: Text(LocaleKeys.Cancelled.tr(),
                                              style: TextStyle(
                                                  fontSize: 9.5.sp,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white)),
                                        ),
                                      )
                                    ] else if (Orderdetailsdata
                                            ?.summery!.status ==
                                        "7") ...[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: color.darkred,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(7),
                                        height: 4.5.h,
                                        child: Center(
                                          child: Text(
                                            LocaleKeys.Cancelled.tr(),
                                            style: TextStyle(
                                              fontSize: 9.5.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ],
                                ),
                                Container(
                                  height: 0.8.sp,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    Text(LocaleKeys.Paymenttype.tr(),
                                        style: TextStyle(
                                            fontSize: 8.8.sp,
                                            fontFamily: 'Poppins',
                                            color: Colors.grey)),
                                    if (Orderdetailsdata
                                            ?.summery!.transactionType ==
                                        "1") ...[
                                      Text(LocaleKeys.Cash.tr(),
                                          style: TextStyle(
                                              fontSize: 8.5.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.grey)),
                                    ] else if (Orderdetailsdata
                                            ?.summery!.transactionType ==
                                        "2") ...[
                                      Text(LocaleKeys.Wallet.tr(),
                                          style: TextStyle(
                                              fontSize: 8.5.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.grey)),
                                    ] else if (Orderdetailsdata
                                            ?.summery!.transactionType ==
                                        "3") ...[
                                      Text(LocaleKeys.RazorPay.tr(),
                                          style: TextStyle(
                                              fontSize: 8.5.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.grey)),
                                    ] else if (Orderdetailsdata
                                            ?.summery!.transactionType ==
                                        "4") ...[
                                      Text(LocaleKeys.Stripepay.tr(),
                                          style: TextStyle(
                                              fontSize: 8.5.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.grey)),
                                    ] else if (Orderdetailsdata
                                            ?.summery!.transactionType ==
                                        "6") ...[
                                      Text(LocaleKeys.Paystack.tr(),
                                          style: TextStyle(
                                              fontSize: 8.5.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.grey)),
                                    ] else if (Orderdetailsdata
                                            ?.summery!.transactionType ==
                                        "7") ...[
                                      Text(LocaleKeys.Paystack.tr(),
                                          style: TextStyle(
                                              fontSize: 8.5.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.grey)),
                                    ],
                                    Spacer(),
                                    if (Orderdetailsdata?.summery!.orderType ==
                                        "1") ...[
                                      Text(LocaleKeys.Delivery.tr(),
                                          style: TextStyle(
                                              fontSize: 8.5.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.grey)),
                                    ] else if (Orderdetailsdata
                                            ?.summery!.orderType ==
                                        "2") ...[
                                      Text(LocaleKeys.Take_away.tr(),
                                          style: TextStyle(
                                              fontSize: 8.5.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.grey)),
                                    ],
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        FormatedDate(
                                            Orderdetailsdata?.summery!.date),
                                        style: TextStyle(
                                          fontSize: 10.5.sp,
                                          fontFamily: 'Poppins',
                                        )),
                                    Text(
                                        currency_position == "1"
                                            ? "$currency${numberFormat.format(double.parse(Orderdetailsdata!.summery!.orderTotal.toString()))}"
                                            : "${numberFormat.format(double.parse(Orderdetailsdata!.summery!.orderTotal.toString()))}$currency",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'Poppins_semibold',
                                        )),
                                  ],
                                )
                              ])),
                      SizedBox(
                        height: Orderdetailsdata!.data!.length * 16.2.h,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: Orderdetailsdata!.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                  top: 2.h,
                                ),
                                padding: EdgeInsets.all(1.h),
                                width: double.infinity,
                                height: 14.h,
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
                                              Orderdetailsdata!
                                                  .data![index].itemName
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontFamily: 'Poppins'),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            Orderdetailsdata!
                                                .data![index].addonsName
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 8.8.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                '${LocaleKeys.Qty.tr()} ${Orderdetailsdata!.data![index].qty}',
                                                style: TextStyle(
                                                  fontSize: 9.sp,
                                                  fontFamily:
                                                      'Poppins_semibold',
                                                )),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(top: 1.h),
                                            child: Text(
                                                currency_position == "1"
                                                    ? '$currency${numberFormat.format(double.parse(Orderdetailsdata!.data![index].itemPrice))}'
                                                    : "${numberFormat.format(double.parse(Orderdetailsdata!.data![index].itemPrice))}$currency",
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
                            }),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: 2.5.h, left: 1.w, right: 1.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.Bill_Details.tr(),
                              style: TextStyle(
                                  fontFamily: 'Poppins_semibold',
                                  fontSize: 12.sp),
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
                                      ? '$currency${numberFormat.format(double.parse(Orderdetailsdata!.summery!.orderTotal.toString()))}'
                                      : '${numberFormat.format(double.parse(Orderdetailsdata!.summery!.orderTotal.toString()))}$currency',
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
                                      ? '$currency${numberFormat.format(double.parse(Orderdetailsdata!.summery!.tax))}'
                                      : '${numberFormat.format(double.parse(Orderdetailsdata!.summery!.tax))}$currency',
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
                                      ? '$currency${numberFormat.format(double.parse(Orderdetailsdata!.summery!.deliveryCharge.toString()))}'
                                      : '${numberFormat.format(double.parse(Orderdetailsdata!.summery!.deliveryCharge.toString()))}$currency',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_semiBold',
                                      fontSize: 11.sp),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.Discount_Offer.tr(),
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 10.sp),
                                ),
                                Text(
                                  currency_position == "1"
                                      ? '$currency${numberFormat.format(double.parse(Orderdetailsdata!.summery!.discountAmount.toString()))}'
                                      : '${numberFormat.format(double.parse(Orderdetailsdata!.summery!.discountAmount.toString()))}$currency',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_semiBold',
                                      fontSize: 11.sp),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              height: 0.8.sp,
                              color: color.greybutton,
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
                                      ? '$currency${numberFormat.format(double.parse(Orderdetailsdata!.summery!.grandTotal.toString()))}'
                                      : '${numberFormat.format(double.parse(Orderdetailsdata!.summery!.grandTotal.toString()))}$currency',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_semiBold',
                                      color: color.greenbutton,
                                      fontSize: 12.5.sp),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            if ((Orderdetailsdata?.summery!.orderType == '1') &&
                                (Orderdetailsdata?.summery!.status == "4" ||
                                    Orderdetailsdata?.summery!.status ==
                                        "5")) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.Driver_information.tr(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins_semibold',
                                        fontSize: 11.5.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  ClipOval(
                                    child: CircleAvatar(
                                      child: Image.network(
                                        Orderdetailsdata!
                                            .driverInfo!.profileImage,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.5.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Orderdetailsdata!.driverInfo!.name,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 10.5.sp),
                                      ),
                                      Text(
                                        Orderdetailsdata!.driverInfo!.email,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 9.sp),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () async {
                                        FlutterPhoneDirectCaller.callNumber(
                                            Orderdetailsdata!
                                                .driverInfo!.mobile);
                                      },
                                      icon: Icon(Icons.phone))
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                            if (Orderdetailsdata?.summery!.orderType ==
                                '1') ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.Deliveryaddress.tr(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins_semibold',
                                        fontSize: 12.5.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 3.h,
                                    width: 4.w,
                                    child: Image.asset(
                                      'Assets/Icons/address.png',
                                      height: 2.5.h,
                                      color: color.greenbutton,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: 10,
                                      left: 10,
                                    ),
                                    width: 82.w,
                                    child: Text(
                                      '${Orderdetailsdata!.summery!.address}${Orderdetailsdata!.summery!.houseNo}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            if (Orderdetailsdata!.summery!.status == "1") ...[
                              SizedBox(
                                height: 8.5.h,
                              )
                            ]
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
              bottomSheet: Orderdetailsdata!.summery!.status == "1"
                  ? InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  LocaleKeys.Restaurant_User.tr(),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins_semibold',
                                  ),
                                ),
                                content: Text(
                                  LocaleKeys
                                          .Are_you_sure_to_cancel_this_order_If_yes_then_order_amount_Online_payment_OR_Wallet_payment_will_be_transferred_to_your_wallet
                                      .tr(),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      LocaleKeys.Yes.tr(),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      cancelorder();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      LocaleKeys.No.tr(),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 1.h, left: 3.w, right: 3.w, bottom: 1.h),
                        height: 6.5.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: color.greenbutton,
                            ),
                            borderRadius: BorderRadius.circular(6.5)),
                        child: Center(
                          child: Text(
                            LocaleKeys.Cancel_Order.tr(),
                            style: TextStyle(
                                fontFamily: 'Poppins_semibold',
                                fontSize: 11.5.sp,
                                color: color.redbutton),
                          ),
                        ),
                      ),
                    )
                  : null);
        },
      ),
    );
  }
}
