// ignore_for_file: file_names, camel_case_types, prefer_collection_literals

class checkpromocodemodel {
  int? status;
  String? message;
  Data? data;

  checkpromocodemodel({this.status, this.message, this.data});

  checkpromocodemodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
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
  String? isAvailable;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.offerName,
      this.offerCode,
      this.offerType,
      this.offerAmount,
      this.minAmount,
      this.perUser,
      this.usageType,
      this.startDate,
      this.expireDate,
      this.description,
      this.isAvailable,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    isAvailable = json['is_available'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
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
    data['is_available'] = isAvailable;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
