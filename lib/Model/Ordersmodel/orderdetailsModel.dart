// ignore_for_file: file_names, prefer_collection_literals

class Orderdetailsmodel {
  dynamic status;
  dynamic message;
  List<Data>? data;
  DriverInfo? driverInfo;
  UserInfo? userInfo;
  Summery? summery;

  Orderdetailsmodel(
      {this.status,
      this.message,
      this.data,
      this.driverInfo,
      this.userInfo,
      this.summery});

  Orderdetailsmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    driverInfo = json['driver_info'] != null
        ? DriverInfo.fromJson(json['driver_info'])
        : null;
    userInfo =
        json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
    summery =
        json['summery'] != null ? Summery.fromJson(json['summery']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (driverInfo != null) {
      data['driver_info'] = driverInfo!.toJson();
    }
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    if (summery != null) {
      data['summery'] = summery!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic itemId;
  dynamic itemName;
  dynamic itemType;
  dynamic itemImage;
  dynamic addonsId;
  dynamic addonsName;
  dynamic addonsPrice;
  dynamic addonsTotalPrice;
  dynamic variationId;
  dynamic variation;
  dynamic itemPrice;
  dynamic qty;
  dynamic totalPrice;

  Data(
      {this.id,
      this.itemId,
      this.itemName,
      this.itemType,
      this.itemImage,
      this.addonsId,
      this.addonsName,
      this.addonsPrice,
      this.addonsTotalPrice,
      this.variationId,
      this.variation,
      this.itemPrice,
      this.qty,
      this.totalPrice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    itemType = json['item_type'];
    itemImage = json['item_image'];
    addonsId = json['addons_id'];
    addonsName = json['addons_name'];
    addonsPrice = json['addons_price'];
    addonsTotalPrice = json['addons_total_price'];
    variationId = json['variation_id'];
    variation = json['variation'];
    itemPrice = json['item_price'];
    qty = json['qty'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['item_id'] = itemId;
    data['item_name'] = itemName;
    data['item_type'] = itemType;
    data['item_image'] = itemImage;
    data['addons_id'] = addonsId;
    data['addons_name'] = addonsName;
    data['addons_price'] = addonsPrice;
    data['addons_total_price'] = addonsTotalPrice;
    data['variation_id'] = variationId;
    data['variation'] = variation;
    data['item_price'] = itemPrice;
    data['qty'] = qty;
    data['total_price'] = totalPrice;
    return data;
  }
}

class DriverInfo {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic mobile;
  dynamic token;
  dynamic profileImage;

  DriverInfo(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.token,
      this.profileImage});

  DriverInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    token = json['token'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['token'] = token;
    data['profile_image'] = profileImage;
    return data;
  }
}

class UserInfo {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic mobile;
  dynamic token;
  dynamic profileImage;

  UserInfo(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.token,
      this.profileImage});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    token = json['token'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['token'] = token;
    data['profile_image'] = profileImage;
    return data;
  }
}

class Summery {
  dynamic id;
  dynamic orderNumber;
  dynamic status;
  dynamic orderType;
  dynamic addressType;
  dynamic address;
  dynamic houseNo;
  dynamic area;
  dynamic lat;
  dynamic lang;
  dynamic transactionType;
  dynamic transactionId;
  dynamic offerCode;
  dynamic orderNotes;
  dynamic discountAmount;
  dynamic deliveryCharge;
  dynamic date;
  dynamic orderTotal;
  dynamic tax;
  dynamic grandTotal;

  Summery(
      {this.id,
      this.orderNumber,
      this.status,
      this.orderType,
      this.addressType,
      this.address,
      this.houseNo,
      this.area,
      this.lat,
      this.lang,
      this.transactionType,
      this.transactionId,
      this.offerCode,
      this.orderNotes,
      this.discountAmount,
      this.deliveryCharge,
      this.date,
      this.orderTotal,
      this.tax,
      this.grandTotal});

  Summery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    status = json['status'];
    orderType = json['order_type'];
    addressType = json['address_type'];
    address = json['address'];
    houseNo = json['house_no'];
    area = json['area'];
    lat = json['lat'];
    lang = json['lang'];
    transactionType = json['transaction_type'];
    transactionId = json['transaction_id'];
    offerCode = json['offer_code'];
    orderNotes = json['order_notes'];
    discountAmount = json['discount_amount'];
    deliveryCharge = json['delivery_charge'];
    date = json['date'];
    orderTotal = json['order_total'];
    tax = json['tax'];
    grandTotal = json['grand_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['order_number'] = orderNumber;
    data['status'] = status;
    data['order_type'] = orderType;
    data['address_type'] = addressType;
    data['address'] = address;
    data['house_no'] = houseNo;
    data['area'] = area;
    data['lat'] = lat;
    data['lang'] = lang;
    data['transaction_type'] = transactionType;
    data['transaction_id'] = transactionId;
    data['offer_code'] = offerCode;
    data['order_notes'] = orderNotes;
    data['discount_amount'] = discountAmount;
    data['delivery_charge'] = deliveryCharge;
    data['date'] = date;
    data['order_total'] = orderTotal;
    data['tax'] = tax;
    data['grand_total'] = grandTotal;
    return data;
  }
}
