// ignore_for_file: camel_case_types, prefer_collection_literals

class cartlistmodel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  cartlistmodel({this.status, this.message, this.data});

  cartlistmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  dynamic id;
  dynamic userId;
  dynamic itemId;
  dynamic itemName;
  dynamic itemType;
  dynamic tax;
  dynamic qty;
  dynamic itemPrice;
  dynamic addonsName;
  dynamic addonsPrice;
  dynamic addonsTotalPrice;
  dynamic variation;
  dynamic itemImage;

  Data(
      {this.id,
      this.userId,
      this.itemId,
      this.itemName,
      this.itemType,
      this.tax,
      this.qty,
      this.itemPrice,
      this.addonsName,
      this.addonsPrice,
      this.addonsTotalPrice,
      this.variation,
      this.itemImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    itemType = json['item_type'];
    tax = json['tax'];
    qty = json['qty'];
    itemPrice = json['item_price'];
    addonsName = json['addons_name'];
    addonsPrice = json['addons_price'];
    addonsTotalPrice = json['addons_total_price'];
    variation = json['variation'];
    itemImage = json['item_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['item_id'] = itemId;
    data['item_name'] = itemName;
    data['item_type'] = itemType;
    data['tax'] = tax;
    data['qty'] = qty;
    data['item_price'] = itemPrice;
    data['addons_name'] = addonsName;
    data['addons_price'] = addonsPrice;
    data['addons_total_price'] = addonsTotalPrice;
    data['variation'] = variation;
    data['item_image'] = itemImage;
    return data;
  }
}
