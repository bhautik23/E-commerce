// ignore_for_file: camel_case_types, prefer_collection_literals

import 'package:ecommerce_user/Model/favoritepage/itemmodel.dart';

class favoritelistmodel {
  int? status;
  String? message;
  List<itemmodel>? data;

  favoritelistmodel({this.status, this.message, this.data});

  favoritelistmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <itemmodel>[];
      json['data'].forEach((v) {
        data!.add(itemmodel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
