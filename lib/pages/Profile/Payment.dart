// ignore_for_file: prefer_const_constructors, must_be_immutable, camel_case_types, use_key_in_widget_constructors, non_constant_identifier_names, file_names, avoid_print

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/Model/settings%20model/paymentoptionmodel.dart';
import 'package:ecommerce_user/Widgets/loader.dart';
import 'package:ecommerce_user/common%20class/color.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/config/API/API.dart';
import 'package:ecommerce_user/payment/Razorpay.dart';
import 'package:ecommerce_user/payment/flutterwave.dart';
import 'package:ecommerce_user/payment/paystack.dart';
import 'package:ecommerce_user/payment/stripe.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'Addmoney.dart';

class selectpayment extends GetxController {
  RxInt? selectedindex = 0.obs;
}

class Payment extends StatefulWidget {
  String? amount;
  // const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
  Payment([this.amount]);
}

class _PaymentState extends State<Payment> {
  int? selectedindex;
  paymentoptionModel? paymentlist;
  String? userid;
  String? walletamount;
  String? payment_name;
  String? currency;
  String? public_key;
  String? secret_key;
  String? encryption_key;
  bool iscome = true;

  // selectpayment select = Get.put(selectpayment());
  paymentoptionAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString(UD_user_id);
    walletamount = prefs.getString(UD_user_wallet);
    var map = {
      "user_id": userid,
      "type": "wallet",
    };
    print(map);
    var response = await Dio()
        .post(DefaultApi.appUrl + PostAPI.Paymentmethodlist, data: map);
    var finalist = await response.data;
    paymentlist = paymentoptionModel.fromJson(finalist);
    iscome = false;
    return paymentlist;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => Addmoney()),
                );
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
              )),
          title: Text(
            LocaleKeys.Payment.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 12.sp),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: iscome == true ? paymentoptionAPI() : null,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                itemCount: paymentlist!.paymentmethods!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          print(index);

                          setState(() {
                            selectedindex = index;
                            payment_name =
                                paymentlist!.paymentmethods![index].paymentName;
                            currency =
                                paymentlist!.paymentmethods![index].currency;
                            encryption_key = paymentlist!
                                .paymentmethods![index].encryptionKey;
                            if (paymentlist!
                                    .paymentmethods![index].environment ==
                                "1") {
                              public_key = paymentlist!
                                  .paymentmethods![index].testPublicKey;
                              secret_key = paymentlist!
                                  .paymentmethods![index].testSecretKey;
                            } else if (paymentlist!
                                    .paymentmethods![index].environment ==
                                "2") {
                              public_key = paymentlist!
                                  .paymentmethods![index].livePublicKey;
                              secret_key = paymentlist!
                                  .paymentmethods![index].liveSecretKey;
                            }
                          });
                        },
                        child: SizedBox(
                          height: 7.h,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 13.w,
                                child: Image.network(
                                  paymentlist!.paymentmethods![index].image!,
                                  height: 4.h,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 1.w,
                                ),
                                child: Text(
                                  paymentlist!
                                      .paymentmethods![index].paymentName
                                      .toString(),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 3.3.h,
                                width: 3.3.h,
                                decoration: BoxDecoration(
                                  color: selectedindex == index
                                      ? color.greenbutton
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(Icons.done,
                                    color: selectedindex == index
                                        ? Colors.white
                                        : Colors.transparent,
                                    size: 13.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: 1.h, bottom: 2.5.w),
                        color: Colors.grey,
                        height: 0.8.sp,
                      ),
                    ],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: color.Metablue,
              ),
            );
          },
        ),
        bottomSheet: InkWell(
          onTap: () {
            if (selectedindex == null) {
              loader.showErroDialog(
                description: LocaleKeys.Please_select_payment_option.tr(),
              );
            } else {
              print(payment_name);
              if (payment_name == "RazorPay") {
                Get.to(
                  () => razor_pay(
                    public_key,
                    secret_key,
                    widget.amount.toString(),
                    currency,
                  ),
                );
              } else if (payment_name == "Stripe") {
                Get.to(() => stripe(widget.amount.toString()));
              } else if (payment_name == "Flutterwave") {
                Get.to(
                  () => flutterwavepayment(
                    public_key,
                    secret_key,
                    encryption_key,
                    widget.amount.toString(),
                    currency,
                  ),
                );
              } else if (payment_name == "Paystack") {
                Get.to(() => paystack_method(
                      public_key,
                      secret_key,
                      widget.amount,
                      encryption_key,
                      currency,
                    ));
              }
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 1.h, left: 4.w, right: 4.w),
            height: 6.5.h,
            width: double.infinity,
            decoration: BoxDecoration(color: color.Metablue),
            child: Center(
              child: Text(
                LocaleKeys.Process_to_pay.tr(),
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.sp),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
