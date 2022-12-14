// ignore_for_file: camel_case_types, prefer_collection_literals

import 'package:ecommerce_user/Model/favoritepage/itemmodel.dart';

class categories_item_model {
  dynamic status;
  dynamic message;
  List<Items>? items;

  categories_item_model({this.status, this.message, this.items});

  categories_item_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  dynamic id;
  dynamic catId;
  dynamic subcategoryName;
  List<itemmodel>? subcategoryItems;

  Items({this.id, this.catId, this.subcategoryName, this.subcategoryItems});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    subcategoryName = json['subcategory_name'];
    if (json['subcategory_items'] != null) {
      subcategoryItems = <itemmodel>[];
      json['subcategory_items'].forEach((v) {
        subcategoryItems!.add(itemmodel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['cat_id'] = catId;
    data['subcategory_name'] = subcategoryName;
    if (subcategoryItems != null) {
      data['subcategory_items'] =
          subcategoryItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
