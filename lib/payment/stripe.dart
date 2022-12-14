// ignore_for_file: avoid_renaming_method_parameters, must_be_immutable, camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, prefer_const_constructors, use_key_in_widget_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/Model/settings%20model/addwalletMODEL.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/pages/Profile/Addmoney.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:ecommerce_user/utils/validator.dart/validator.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class stripe extends StatefulWidget {
  String? amount;
  // const stripe({Key? key}) : super(key: key);

  @override
  State<stripe> createState() => _stripeState();
  stripe([this.amount]);
}

class _stripeState extends State<stripe> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController cardno = TextEditingController();
  TextEditingController MM = TextEditingController();
  TextEditingController YYYY = TextEditingController();
  TextEditingController CVV = TextEditingController();
  addwalletMODEL? addwalletdata;

  Add_wallet_api() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString(UD_user_id);
    loader.showLoading();
    try {
      var map = {
        "user_id": userid,
        "amount": widget.amount,
        "transaction_type": "4",
        "transaction_id": "",
        "card_number": cardno.value.text,
        "card_exp_month": MM.value.text,
        "card_exp_year": YYYY.value.text,
        "card_cvc": CVV.value.text
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
        Navigator.popUntil(context, (route) {
          return count++ == 3;
        });
        // Get.offAll(Wallet());
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (c) => Wallet()), (r) => true);
      } else {
        loader.hideLoading();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (c) => Addmoney()), (r) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          LocaleKeys.Card_information.tr(),
          style: TextStyle(
            fontSize: 12.5.sp,
            fontFamily: 'Poppins_semibold',
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.close),
        ),
        leadingWidth: 40,
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.only(left: 3.w, right: 3.w),
          child: Column(
            children: [
              TextFormField(
                validator: (value) => Validators.validatecardno(value!),
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CardNumberFormatter(),
                ],
                maxLength: 19,
                controller: cardno,
                decoration: InputDecoration(
                    hintText: LocaleKeys.Card_number,
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                        fontSize: 10.5.sp),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: Colors.grey),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 2.h,
                  bottom: 2.h,
                ),
                child: TextFormField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: LocaleKeys.Card_holder_name,
                      hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 10.5.sp),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: Colors.grey),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 30.w,
                    child: TextFormField(
                      validator: (value) =>
                          Validators.validatecardexpirmonth(value!),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: MM,
                      decoration: InputDecoration(
                          hintText: LocaleKeys.MM,
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                              fontSize: 10.5.sp),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: YYYY,
                      validator: (value) =>
                          Validators.validatecardexpiryear(value!),
                      decoration: InputDecoration(
                          hintText: LocaleKeys.YYYY,
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                              fontSize: 10.5.sp),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: TextFormField(
                      validator: (value) => Validators.validatecardcvv(value!),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: CVV,
                      decoration: InputDecoration(
                          hintText: LocaleKeys.CVV,
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                              fontSize: 10.5.sp),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    Add_wallet_api();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: color.blackbutton),
                  margin: EdgeInsets.only(
                    top: 2.h,
                    bottom: 2.h,
                  ),
                  height: 7.h,
                  child: Center(
                    child: Text(
                      LocaleKeys.Submit,
                      style: TextStyle(
                          fontSize: 12.5.sp,
                          fontFamily: 'Poppins_semibold',
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
