// ignore_for_file: file_names

import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_user/common%20class/prefs_name.dart';
import 'package:ecommerce_user/translation/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({Key? key}) : super(key: key);

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  void initState() {
    super.initState();
    data();
  }

  data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      aboutus = prefs.getString(about_us);
    });
  }

  late WebViewController _controller;
  String? aboutus;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                  )),
              title: Text(
                LocaleKeys.About_Us.tr(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontFamily: 'Poppins_semibold', fontSize: 12.sp),
              ),
              leadingWidth: 40,
              centerTitle: true,
            ),
            body: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              zoomEnabled: true,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                _loadHtmlFromAssets();
              },
            )));
  }

  _loadHtmlFromAssets() async {
    // String fileText = await rootBundle.loadString('assets/help.html');
    _controller.loadUrl(Uri.dataFromString(aboutus!,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
