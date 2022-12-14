// ignore_for_file: must_be_immutable, camel_case_types, non_constant_identifier_names, use_key_in_widget_constructors, avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/Model/cartpage/orderplaceMODEL.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/pages/Cart/ordersucess.dart';
import 'package:ecommerce_user/payment/stripe.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:ecommerce_user/utils/validator.dart/validator.dart';
import 'package:sizer/sizer.dart';

class orderstripe extends StatefulWidget {
  String? ordertotal;
  String? ordertype;
  String? offercode;
  String? discount_amount;
  String? tax_amount;
  String? delivery_charge;
  //address

  String? addresstype;
  String? address;
  String? area;
  String? houseno;
  String? lang;
  String? lat;
  //extra
  String? ordernote;

  // const orderstripe({Key? key}) : super(key: key);

  @override
  State<orderstripe> createState() => _orderstripeState();
  orderstripe([
    this.ordertotal,
    this.ordertype,
    this.offercode,
    this.discount_amount,
    this.tax_amount,
    this.delivery_charge,
    //address
    this.addresstype,
    this.address,
    this.area,
    this.houseno,
    this.lang,
    this.lat,
    //extra
    this.ordernote,
  ]);
}

class _orderstripeState extends State<orderstripe> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController cardno = TextEditingController();
  TextEditingController MM = TextEditingController();
  TextEditingController YYYY = TextEditingController();
  TextEditingController CVV = TextEditingController();
  String? userid;

  placeorder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString(UD_user_id);
    loader.showLoading();
    var map = {
      "user_id": userid,
      "grand_total": widget.ordertotal,
      "transaction_type": "4",
      "transaction_id": "",
      "order_type": widget.ordertype,
      "address_type": widget.addresstype,
      "address": widget.address, // (Required if order_type == 1)
      "area": widget.area,
      "house_no": widget.houseno,
      "lang": widget.lang,
      "lat": widget.lat,
      "offer_code": widget.offercode == "0" ? "" : widget.offercode,
      "discount_amount": widget.discount_amount,
      "tax_amount": double.parse(widget.tax_amount.toString()),
      "delivery_charge": widget.delivery_charge,
      "order_notes": widget.ordernote,
      "order_from": "flutter",
      "card_number": cardno.value.text.toString(),
      "card_exp_month": MM.value.text.toString(),
      "card_exp_year": YYYY.value.text.toString(),
      "card_cvc": CVV.value.text.toString(),
    };
    print(map);
    var response =
        await Dio().post(DefaultApi.appUrl + PostAPI.Order, data: map);
    orderplaceMODEL placedorederdata = orderplaceMODEL.fromJson(response.data);
    if (placedorederdata.status == 1) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Ordersucesspage()));
    } else {
      loader.showErroDialog(description: placedorederdata.message);
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
                    hintText: LocaleKeys.Card_number.tr(),
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
                      hintText: LocaleKeys.Card_holder_name.tr(),
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
                          hintText: LocaleKeys.MM.tr(),
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
                          hintText: LocaleKeys.YYYY.tr(),
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
                          hintText: LocaleKeys.CVV.tr(),
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
                    placeorder();
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
                      LocaleKeys.Submit.tr(),
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
