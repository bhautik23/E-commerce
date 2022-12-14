// ignore_for_file: camel_case_types, prefer_collection_literals

class deleteaddressmodel {
  int? status;
  String? message;

  deleteaddressmodel({this.status, this.message});

  deleteaddressmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
