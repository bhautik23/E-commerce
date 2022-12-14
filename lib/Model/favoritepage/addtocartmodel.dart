// ignore_for_file: prefer_collection_literals, camel_case_types

class addtocartmodel {
  int? status;
  String? message;
  int? cartCount;

  addtocartmodel({this.status, this.message, this.cartCount});

  addtocartmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cartCount = json['cart_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['cart_count'] = cartCount;
    return data;
  }
}
