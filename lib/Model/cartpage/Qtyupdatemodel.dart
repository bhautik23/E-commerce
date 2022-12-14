// ignore_for_file: file_names, prefer_collection_literals

class QTYupdatemodel {
  int? status;
  String? message;

  QTYupdatemodel({this.status, this.message});

  QTYupdatemodel.fromJson(Map<String, dynamic> json) {
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
