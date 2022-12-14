// ignore_for_file: file_names, camel_case_types, prefer_collection_literals

class orderplaceMODEL {
  int? status;
  String? message;
  int? orderId;

  orderplaceMODEL({this.status, this.message, this.orderId});

  orderplaceMODEL.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['order_id'] = orderId;
    return data;
  }
}
