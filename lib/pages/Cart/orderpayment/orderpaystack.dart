// ignore_for_file: must_be_immutable, camel_case_types, non_constant_identifier_names, unused_field, prefer_final_fields, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_local_variable, use_build_context_synchronously

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/Model/settings%20model/addwalletMODEL.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/pages/Cart/ordersucess.dart';
import 'package:sizer/sizer.dart';

String backendUrl = '{YOUR_BACKEND_URL}';
// Set this to a public key that matches the secret key you supplied while creating the heroku instance

const String appName = 'Paystack Example';

addwalletMODEL? add_money;

class order_paystack extends StatefulWidget {
  String? ordertotal;
  String? ordertype;
  String? offercode;
  String? discountamount;
  String? taxamount;
  String? delivery_charge;
  //
  String? addresstype;
  String? address;
  String? area;
  String? houseno;
  String? lang;
  String? lat;
  //
  String? ordernote;
  //
  String? publickey;
  String? secretkey;
  String? encryption_key;
  String? currency;

  @override
  _order_paystackState createState() => _order_paystackState();
  order_paystack([
    this.ordertotal,
    this.ordertype,
    this.offercode,
    this.taxamount,
    this.discountamount,
    this.delivery_charge,
    //
    this.addresstype,
    this.address,
    this.area,
    this.houseno,
    this.lang,
    this.lat,
    //
    this.ordernote,
    //
    this.publickey,
    this.secretkey,
    this.encryption_key,
    this.currency,
  ]);
}

class _order_paystackState extends State<order_paystack> {
  final _formKey = GlobalKey<FormState>();

  final _horizontalSizeBox = const SizedBox(width: 10.0);
  final plugin = PaystackPlugin();
  int _radioValue = 0;
  CheckoutMethod _method = CheckoutMethod.card;
  bool _inProgress = false;
  String? _cardNumber;
  String? paykey;
  String? paymasg;
  String? _cvv;
  int? _expiryMonth;
  int? _expiryYear;

  @override
  void initState() {
    plugin.initialize(publicKey: widget.publickey!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50.h, left: 12, right: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: DropdownButtonHideUnderline(
                    child: InputDecorator(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          hintText: 'Checkout method',
                          hintStyle: TextStyle(fontFamily: "Poppins")),
                      child: DropdownButton<CheckoutMethod>(
                        value: _method,
                        isDense: true,
                        onChanged: (CheckoutMethod? value) {
                          if (value != null) {
                            setState(() => _method = value);
                          }
                        },
                        items: banks.map((String value) {
                          return DropdownMenuItem<CheckoutMethod>(
                            value: _parseStringToMethod(value),
                            child: Text(
                              value,
                              style: TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 48,
                  width: 35.w,
                  child: _getPlatformButton(
                    'Checkout',
                    () => _handleCheckout(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _handleCheckout(BuildContext context) async {
    _formKey.currentState?.save();
    Charge charge = Charge()
      ..currency = widget.currency
      ..amount = (double.parse(widget.ordertotal!) * 100).toInt()
      ..email = 'customer@email.com'
      ..card = _getCardFromUI();
    print("sdscsc${widget.publickey!}");
    if (!_isLocal) {
      var accessCode = await _fetchAccessCodeFrmServer(_getReference());
      charge.accessCode = accessCode;
    } else {
      charge.reference = _getReference();
    }
    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: false,
        logo: MyLogo(),
      );
      print('Response = $response');
      print('Response = ${response.message}');
      print('Response = ${response.status}');
      print('Response = ${response.message}');
      if (response.status == true) {
        paykey = response.reference;
        paymasg = response.message;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String userid = prefs.getString(UD_user_id)!;
        try {
          loader.showLoading();
          var map = {
            "user_id": userid,
            "grand_total": widget.ordertotal,
            "transaction_type": "6",
            "transaction_id": paykey,
            "order_type": widget.ordertype,
            "address_type": widget.addresstype,
            "address": widget.address, // (Required if order_type == 1)
            "area": widget.area,
            "house_no": widget.houseno,
            "lang": widget.lang,
            "lat": widget.lat,
            "offer_code": widget.offercode == "0" ? "" : widget.offercode,
            "discount_amount": widget.discountamount,
            "tax_amount": widget.taxamount,

            "delivery_charge": widget.delivery_charge,
            "order_notes": widget.ordernote,
            "order_from": "flutter",

            "card_number": "",
            "card_exp_month": "",
            "card_exp_year": "",
            "card_cvc": "",
          };
          print(map);
          var finalAPI =
              await Dio().post(DefaultApi.appUrl + PostAPI.Order, data: map);
          print(finalAPI.data);
          print("aqwers /****** $map");
          var finallist = await finalAPI.data;
          add_money = addwalletMODEL.fromJson(finallist);

          if (add_money!.status == 1) {
            loader.hideLoading();
            prefs.setString(UD_user_wallet, add_money!.totalWallet.toString());
            int count = 0;

            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Ordersucesspage();
              },
            ));
          } else {
            loader.hideLoading();
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 2;
            });
            // Navigator.pushReplacement(context, MaterialPageRoute(
            //   builder: (context) {
            //     return select_paym_method(paymasg);
            //   },
            // ));
          }
          return add_money;
        } catch (e) {
          loader.hideLoading();
          loader.showErroDialog(description: "No Data Found");
          print("error");
        }
      } else {
        loader.showErroDialog(description: response.message);
        // Fluttertoast.showToast(
        //   msg: "${response.message}",
        //   toastLength: Toast.LENGTH_SHORT,
        // );
      }
    } catch (e) {
      loader.showErroDialog(description: "Select payment type");
      // Fluttertoast.showToast(
      //   msg: "Select payment type",
      //   toastLength: Toast.LENGTH_SHORT,
      // );

      rethrow;
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
        number: _cardNumber,
        cvc: _cvv,
        expiryMonth: _expiryMonth,
        expiryYear: _expiryYear,
        name: "mehul pandya");

    // Using Cascade notation (similar to Java's builder pattern)
//    return PaymentCard(
//        number: cardNumber,
//        cvc: cvv,
//        expiryMonth: expiryMonth,
//        expiryYear: expiryYear)
//      ..name = 'Segun Chukwuma Adamu'
//      ..country = 'Nigeria'
//      ..addressLine1 = 'Ikeja, Lagos'
//      ..addressPostalCode = '100001';

    // Using optional parameters
//    return PaymentCard(
//        number: cardNumber,
//        cvc: cvv,
//        expiryMonth: expiryMonth,
//        expiryYear: expiryYear,
//        name: 'Ismail Adebola Emeka',
//        addressCountry: 'Nigeria',
//        addressLine1: '90, Nnebisi Road, Asaba, Deleta State');
  }

  Widget _getPlatformButton(String string, Function() function) {
    // is still in progress
    Widget widget;
    if (Platform.isIOS) {
      widget = CupertinoButton(
        onPressed: function,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: CupertinoColors.activeBlue,
        child: Text(
          string,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontFamily: "Poppins"),
        ),
      );
    } else {
      widget = ElevatedButton(
        onPressed: function,
        child: Text(
          string.toUpperCase(),
          style: const TextStyle(fontSize: 17.0, fontFamily: "Poppins"),
        ),
      );
    }
    return widget;
  }

  Future<String?> _fetchAccessCodeFrmServer(String reference) async {
    String url = '$backendUrl/new-access-code';
    String? accessCode;
    try {
      print("Access code url = $url");
      http.Response response = await http.get(Uri.parse(url));
      accessCode = response.body;
      print('Response for access code = $accessCode');
    } catch (e) {
      setState(() => _inProgress = false);
    }

    return accessCode;
  }

  bool get _isLocal => _radioValue == 0;
}

var banks = ['Selectable', 'Bank', 'Card'];

CheckoutMethod _parseStringToMethod(String string) {
  CheckoutMethod method = CheckoutMethod.selectable;
  switch (string) {
    case 'Bank':
      method = CheckoutMethod.bank;
      break;
    case 'Card':
      method = CheckoutMethod.card;
      break;
  }
  return method;
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        "CO",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}

const Color green = Color(0xFF3db76d);
const Color lightBlue = Color(0xFF34a5db);
const Color navyBlue = Color(0xFF031b33);
