// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, file_names, camel_case_types, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_user/Model/settings%20model/wallettransactionmodel.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/Allformater.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class Transaction_history extends StatefulWidget {
  const Transaction_history({Key? key}) : super(key: key);

  @override
  State<Transaction_history> createState() => _Transaction_historyState();
}

class _Transaction_historyState extends State<Transaction_history> {
  wallettransactionmodel? transactiondata;

  @override
  void initState() {
    super.initState();
    transactionAPI();
  }

  String? currency;
  String? currency_position;

  transactionAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = (prefs.getString(UD_user_id) ?? "null");
    currency = (prefs.getString(APPcurrency) ?? "");
    currency_position = (prefs.getString(APPcurrency_position) ?? "");
    try {
      var map = {"user_id": userid};
      var response = await Dio()
          .post(DefaultApi.appUrl + PostAPI.Wallettransactions, data: map);
      var finallist = await response.data;
      transactiondata = wallettransactionmodel.fromJson(finallist);
      return transactiondata!.transactions;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            LocaleKeys.Transaction_History.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: transactionAPI(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount: transactiondata!.transactions!.length,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(top: 1.5.h, left: 3.w, right: 1.w),
                    width: double.infinity,
                    height: 10.h,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              if (transactiondata!
                                      .transactions![index].transactionType ==
                                  "1") ...[
                                Container(
                                  height: 7.5.h,
                                  width: 7.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: color.redbutton.withOpacity(0.2)),
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: color.redbutton,
                                    size: 25,
                                  ),
                                )
                              ] else if (transactiondata!
                                      .transactions![index].transactionType ==
                                  "2") ...[
                                Container(
                                  height: 7.5.h,
                                  width: 7.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xffD9E7CC)),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Color(0xff82B457),
                                    size: 25,
                                  ),
                                )
                              ] else if (transactiondata!
                                      .transactions![index].transactionType ==
                                  "3") ...[
                                Container(
                                  height: 7.5.h,
                                  width: 7.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xffD9E7CC)),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Color(0xff82B457),
                                    size: 25,
                                  ),
                                )
                              ] else if (transactiondata!
                                      .transactions![index].transactionType ==
                                  "4") ...[
                                Container(
                                  height: 7.5.h,
                                  width: 7.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xffD9E7CC)),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Color(0xff82B457),
                                    size: 25,
                                  ),
                                )
                              ] else if (transactiondata!
                                      .transactions![index].transactionType ==
                                  "5") ...[
                                Container(
                                  height: 7.5.h,
                                  width: 7.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xffD9E7CC)),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Color(0xff82B457),
                                    size: 25,
                                  ),
                                )
                              ] else if (transactiondata!
                                      .transactions![index].transactionType ==
                                  "6") ...[
                                Container(
                                  height: 7.5.h,
                                  width: 7.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xffD9E7CC)),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Color(0xff82B457),
                                    size: 25,
                                  ),
                                )
                              ] else if (transactiondata!
                                      .transactions![index].transactionType ==
                                  "7") ...[
                                Container(
                                  height: 7.5.h,
                                  width: 7.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xffD9E7CC)),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Color(0xff82B457),
                                    size: 25,
                                  ),
                                )
                              ] else if (transactiondata!
                                      .transactions![index].transactionType ==
                                  "8") ...[
                                Container(
                                  height: 7.5.h,
                                  width: 7.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xffD9E7CC)),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Color(0xff82B457),
                                    size: 25,
                                  ),
                                )
                              ] else if (transactiondata!
                                      .transactions![index].transactionType ==
                                  "9") ...[
                                Container(
                                  height: 7.5.h,
                                  width: 7.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: color.redbutton.withOpacity(0.2)),
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: color.redbutton,
                                    size: 25,
                                  ),
                                )
                              ] else ...[
                                Container(
                                  height: 7.5.h,
                                  width: 7.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xffD9E7CC)),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Color(0xff82B457),
                                    size: 25,
                                  ),
                                )
                              ]
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 3.w, right: 3.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (transactiondata!.transactions![index]
                                          .transactionType ==
                                      "1") ...[
                                    Text(
                                      LocaleKeys.Wallet_Order.tr(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                    )
                                  ] else if (transactiondata!
                                          .transactions![index]
                                          .transactionType ==
                                      "2") ...[
                                    Text(
                                      LocaleKeys.Order_Cancel.tr(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                    )
                                  ] else if (transactiondata!
                                          .transactions![index]
                                          .transactionType ==
                                      "3") ...[
                                    Text(
                                      LocaleKeys.Wallet_Recharge.tr(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                    )
                                  ] else if (transactiondata!
                                          .transactions![index]
                                          .transactionType ==
                                      "4") ...[
                                    Text(
                                      LocaleKeys.Wallet_Recharge.tr(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                    )
                                  ] else if (transactiondata!
                                          .transactions![index]
                                          .transactionType ==
                                      "5") ...[
                                    Text(
                                      LocaleKeys.Wallet_Recharge.tr(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                    )
                                  ] else if (transactiondata!
                                          .transactions![index]
                                          .transactionType ==
                                      "6") ...[
                                    Text(
                                      LocaleKeys.Referral_Amount.tr(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                    )
                                  ] else if (transactiondata!
                                          .transactions![index]
                                          .transactionType ==
                                      "7") ...[
                                    Text(
                                      LocaleKeys.Wallet_Recharge.tr(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                    )
                                  ] else if (transactiondata!
                                          .transactions![index]
                                          .transactionType ==
                                      "8") ...[
                                    Text(
                                      LocaleKeys.Wallet_Recharge.tr(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                    )
                                  ] else if (transactiondata!
                                          .transactions![index]
                                          .transactionType ==
                                      "9") ...[
                                    Text(
                                      LocaleKeys.Wallet_Recharge.tr(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                    )
                                  ] else ...[
                                    Text(
                                      transactiondata!
                                          .transactions![index].transactionType
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                    )
                                  ],
                                  Row(
                                    children: [
                                      if (transactiondata!.transactions![index]
                                              .transactionType ==
                                          "1") ...[
                                        Text(
                                          "${LocaleKeys.Order_Id.tr()} : ${transactiondata!.transactions![index].orderNumber}",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10),
                                        )
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "2") ...[
                                        Text(
                                          "${LocaleKeys.Order_Id.tr()} : ${transactiondata!.transactions![index].orderNumber}",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10),
                                        )
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "3") ...[
                                        Text(
                                          "${LocaleKeys.Paymenttype.tr()} : ${LocaleKeys.RazorPay}",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10),
                                        )
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "4") ...[
                                        Text(
                                          "${LocaleKeys.Paymenttype.tr()} : ${LocaleKeys.Stripepay}",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10),
                                        )
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "5") ...[
                                        Text(
                                          "${LocaleKeys.Paymenttype.tr()} : ${LocaleKeys.Flutterwave}",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10),
                                        )
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "6") ...[
                                        Text(
                                          "${LocaleKeys.Paymenttype.tr()} : ${LocaleKeys.Paystack.tr()}",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10),
                                        )
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "7") ...[
                                        Text(
                                          "${LocaleKeys.Referral_Amount.tr()} ",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10),
                                        )
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "8") ...[
                                        Text(
                                          "${LocaleKeys.Paymenttype.tr()} : ${LocaleKeys.Cash.tr()}",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10),
                                        )
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "9") ...[
                                        Text(
                                          "${LocaleKeys.Paymenttype.tr()} : ${LocaleKeys.Cash.tr()}",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10),
                                        )
                                      ],
                                      Spacer(),
                                      if (transactiondata!.transactions![index]
                                              .transactionType ==
                                          "1") ...[
                                        Text(
                                          currency_position == "1"
                                              ? '$currency${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}'
                                              : '${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}$currency',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: color.redbutton,
                                              fontFamily: 'Poppins_Semibold',
                                              fontSize: 16),
                                        ),
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "2") ...[
                                        Text(
                                          currency_position == "1"
                                              ? '$currency${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}'
                                              : '${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}$currency',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Color(0xff35C759),
                                              fontFamily: 'Poppins_Semibold',
                                              fontSize: 16),
                                        ),
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "3") ...[
                                        Text(
                                          currency_position == "1"
                                              ? '$currency${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}'
                                              : '${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}$currency',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Color(0xff35C759),
                                              fontFamily: 'Poppins_Semibold',
                                              fontSize: 16),
                                        ),
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "4") ...[
                                        Text(
                                          currency_position == "1"
                                              ? '$currency${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}'
                                              : '${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}$currency',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Color(0xff35C759),
                                              fontFamily: 'Poppins_Semibold',
                                              fontSize: 16),
                                        ),
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "5") ...[
                                        Text(
                                          currency_position == "1"
                                              ? '$currency${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}'
                                              : '${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}$currency',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Color(0xff35C759),
                                              fontFamily: 'Poppins_Semibold',
                                              fontSize: 16),
                                        ),
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "6") ...[
                                        Text(
                                          currency_position == "1"
                                              ? '$currency${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}'
                                              : '${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}$currency',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Color(0xff35C759),
                                              fontFamily: 'Poppins_Semibold',
                                              fontSize: 16),
                                        ),
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "7") ...[
                                        Text(
                                          currency_position == "1"
                                              ? '$currency${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}'
                                              : '${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}$currency',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Color(0xff35C759),
                                              fontFamily: 'Poppins_Semibold',
                                              fontSize: 16),
                                        ),
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "8") ...[
                                        Text(
                                          currency_position == "1"
                                              ? '$currency${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}'
                                              : '${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}$currency',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontFamily: 'Poppins_Semibold',
                                              fontSize: 16),
                                        ),
                                      ] else if (transactiondata!
                                              .transactions![index]
                                              .transactionType ==
                                          "9") ...[
                                        Text(
                                          currency_position == "1"
                                              ? '$currency${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}'
                                              : '${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}$currency',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontFamily: 'Poppins_Semibold',
                                              fontSize: 16),
                                        ),
                                      ] else ...[
                                        Text(
                                          currency_position == "1"
                                              ? '$currency${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}'
                                              : '${numberFormat.format(double.parse(transactiondata!.transactions![index].amount.toString()))}$currency',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontFamily: 'Poppins_Semibold',
                                              fontSize: 16),
                                        ),
                                      ]
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        FormatedDate(transactiondata!
                                            .transactions![index].date
                                            .toString()),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                  separatorBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height / 95,
                        right: MediaQuery.of(context).size.height / 95),
                    color: Colors.grey,
                    height: 1,
                    width: MediaQuery.of(context).size.width / 1.05,
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: color.Metablue,
                ),
              );
            }));
  }
}
