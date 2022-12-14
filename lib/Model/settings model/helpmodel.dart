// ignore_for_file: camel_case_types, prefer_collection_literals

class helpmodel {
  int? status;
  String? message;

  helpmodel({this.status, this.message});

  helpmodel.fromJson(Map<String, dynamic> json) {
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
