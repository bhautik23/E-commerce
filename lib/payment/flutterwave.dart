// ignore_for_file: use_build_context_synchronously, must_be_immutable, camel_case_types, non_constant_identifier_names, use_key_in_widget_constructors, unnecessary_null_comparison, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/Model/settings%20model/addwalletMODEL.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';

class flutterwavepayment extends StatefulWidget {
  String? publickey;
  String? secretkey;
  String? encryption_key;
  String? amount;
  String? currency;
  // const flutterwavepayment({Key? key}) : super(key: key);
  flutterwavepayment([
    this.publickey,
    this.secretkey,
    this.encryption_key,
    this.amount,
    this.currency,
  ]);
  @override
  State<flutterwavepayment> createState() => _flutterwavepaymentState();
}

class _flutterwavepaymentState extends State<flutterwavepayment> {
  __handlePaymentInitialization() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString(UD_user_id)!;
    String name = prefs.getString(UD_user_name)!;
    String email = prefs.getString(UD_user_email)!;
    String mobile = prefs.getString(UD_user_mobile)!;
    final Customer customer = Customer(
      email: email,
      name: name,
      phoneNumber: mobile,
    );
    final Flutterwave flutterwave = Flutterwave(
      context: context,
      publicKey: widget.publickey!,
      currency: widget.currency,
      redirectUrl: "https://google.com",
      txRef: DateTime.now().toString(),
      amount: widget.amount!,
      customer: customer,
      paymentOptions: "card, payattitude, barter",
      customization: Customization(title: "Test Payment"),
      isTestMode: false,
    );
    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      print("as ${response.transactionId} as");
      print("Done");
      loader.showLoading();

      var map = {
        "user_id": userid,
        "amount": widget.amount,
        "transaction_type": "5",
        "transaction_id": response.transactionId,
        "card_number": "",
        "card_exp_month": "",
        "card_exp_year": "",
        "card_cvc": ""
      };
      print(map);

      var finaldata =
          await Dio().post(DefaultApi.appUrl + PostAPI.addwallet, data: map);
      addwalletdata = addwalletMODEL.fromJson(finaldata.data);
      if (addwalletdata!.status == 1) {
        loader.hideLoading();
        prefs.setString(UD_user_wallet, addwalletdata!.totalWallet.toString());

        int count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 3;
        });
      } else {
        loader.showErroDialog(description: addwalletdata!.message);
      }
    }
  }

  getpublickey() {
    if (isTestMode) {
      return widget.publickey;
    }
    return widget.encryption_key;
  }

  final publickeycontroller = TextEditingController();
  bool isTestMode = true;
  addwalletMODEL? addwalletdata;

  @override
  void initState() {
    super.initState();
    __handlePaymentInitialization();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(child: Scaffold());
  }
}
