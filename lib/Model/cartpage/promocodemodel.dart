// ignore_for_file: camel_case_types, prefer_collection_literals

class promocodemodel {
  int? status;
  String? message;
  List<Data>? data;

  promocodemodel({this.status, this.message, this.data});

  promocodemodel.fromJson(Map<String, dynamic> json) {
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
  String? offerName;
  String? offerCode;
  String? offerType;
  String? offerAmount;
  String? minAmount;
  String? perUser;
  String? usageType;
  String? startDate;
  String? expireDate;
  String? description;

  Data(
      {this.offerName,
      this.offerCode,
      this.offerType,
      this.offerAmount,
      this.minAmount,
      this.perUser,
      this.usageType,
      this.startDate,
      this.expireDate,
      this.description});

  Data.fromJson(Map<String, dynamic> json) {
    offerName = json['offer_name'];
    offerCode = json['offer_code'];
    offerType = json['offer_type'];
    offerAmount = json['offer_amount'];
    minAmount = json['min_amount'];
    perUser = json['per_user'];
    usageType = json['usage_type'];
    startDate = json['start_date'];
    expireDate = json['expire_date'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['offer_name'] = offerName;
    data['offer_code'] = offerCode;
    data['offer_type'] = offerType;
    data['offer_amount'] = offerAmount;
    data['min_amount'] = minAmount;
    data['per_user'] = perUser;
    data['usage_type'] = usageType;
    data['start_date'] = startDate;
    data['expire_date'] = expireDate;
    data['description'] = description;
    return data;
  }
}
