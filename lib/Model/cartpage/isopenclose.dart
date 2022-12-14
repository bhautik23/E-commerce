// ignore_for_file: camel_case_types, prefer_collection_literals

class isopencloseMODEL {
  int? status;
  String? message;
  dynamic isCartEmpty;

  isopencloseMODEL({this.status, this.message, this.isCartEmpty});

  isopencloseMODEL.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    isCartEmpty = json['is_cart_empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['is_cart_empty'] = isCartEmpty;
    return data;
  }
}
