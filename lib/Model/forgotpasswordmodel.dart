// ignore_for_file: prefer_collection_literals

class Forgotpasswordmodel {
  int? status;
  String? message;

  Forgotpasswordmodel({this.status, this.message});

  Forgotpasswordmodel.fromJson(Map<String, dynamic> json) {
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
