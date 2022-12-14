// ignore_for_file: camel_case_types, prefer_collection_literals

class getaddressmodel {
  int? status;
  String? message;
  List<addData>? data;

  getaddressmodel({this.status, this.message, this.data});

  getaddressmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <addData>[];
      json['data'].forEach((v) {
        data!.add(addData.fromJson(v));
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

class addData {
  dynamic id;
  dynamic userId;
  dynamic addressType;
  dynamic address;
  dynamic lat;
  dynamic lang;
  dynamic area;
  dynamic houseNo;

  addData(
      {this.id,
      this.userId,
      this.addressType,
      this.address,
      this.lat,
      this.lang,
      this.area,
      this.houseNo});

  addData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressType = json['address_type'];
    address = json['address'] ?? "";
    lat = json['lat'];
    lang = json['lang'];
    area = json['area'] ?? "";
    houseNo = json['house_no'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['address_type'] = addressType;
    data['address'] = address;
    data['lat'] = lat;
    data['lang'] = lang;
    data['area'] = area;
    data['house_no'] = houseNo;
    return data;
  }
}
