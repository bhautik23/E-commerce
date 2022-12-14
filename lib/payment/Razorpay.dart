// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, must_be_immutable, camel_case_types, use_key_in_widget_constructors, file_names, non_constant_identifier_names, avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/Model/settings%20model/addwalletMODEL.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/pages/Profile/Addmoney.dart';

class razor_pay extends StatefulWidget {
  String? publickey;
  String? secretkey;
  String? amount;
  String? currency;

  // const razor_pay({Key? key}) : super(key: key);

  @override
  State<razor_pay> createState() => _razor_payState();
  razor_pay([
    this.publickey,
    this.secretkey,
    this.amount,
    this.currency,
  ]);
}

class _razor_payState extends State<razor_pay> {
  String? payment_keys;
  String? pay_message;
  late Razorpay razorpay;
  String? userid;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openchekout();
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("succes");
    print("maaaa${response.paymentId}");
    payment_keys = response.paymentId;
    pay_message = "sucscess"; // Do
    // loader.showErroDialog(description: "$pay_message $payment_keys");

    Add_wallet_api(payment_keys); // something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    Get.back();
    loader.showErroDialog(description: "payment failed");
    //  Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    loader.showErroDialog(description: response.toString());
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  openchekout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString(UD_user_id);
    var options = {
      'key': widget.publickey,
      'amount': (double.parse(widget.amount!) * 100).toInt(),
      'name': prefs.getString(UD_user_name),
      'currecy': widget.currency,
      'description': "Service Provider",
      'prefill': {
        'contact': prefs.getString(UD_user_mobile),
        'email': prefs.getString(UD_user_email),
      }
    };
    print("option $options");
    try {
      razorpay.open(options);
    } catch (e) {
      print("error $e");
    }
  }

  addwalletMODEL? addwalletdata;
  Add_wallet_api(paymentid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString(UD_user_id);
    loader.showLoading();
    try {
      var map = {
        "user_id": userid,
        "amount": widget.amount,
        "transaction_type": "3",
        "transaction_id": paymentid,
        "card_number": "",
        "card_exp_month": "",
        "card_exp_year": "",
        "card_cvc": ""
      };
      print(map);
      var response =
          await Dio().post(DefaultApi.appUrl + PostAPI.addwallet, data: map);
      addwalletdata = addwalletMODEL.fromJson(response.data);
      print(response);
      if (addwalletdata!.status == 1) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // Navigator.of(context).popUntil((route) => true);
        prefs.setString(UD_user_wallet, addwalletdata!.totalWallet.toString());
        loader.hideLoading();
        // Navigator.pushReplacement(context, MaterialPageRoute(
        //   builder: (context) {
        //     return Wallet();
        //   },
        // ));
        int count = 0;
        Navigator.popUntil(
          context,
          (route) {
            return count++ == 3;
          },
        );
        // Get.offAll(Wallet());
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (c) => Wallet()), (r) => true);
      } else {
        loader.hideLoading();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (c) => Addmoney(),
            ),
            (r) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
