// ignore_for_file: prefer_collection_literals, camel_case_types

class isnotificationModel {
  int? status;
  String? message;
  String? notificationStatus;
  String? mailStatus;

  isnotificationModel(
      {this.status, this.message, this.notificationStatus, this.mailStatus});

  isnotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    notificationStatus = json['notification_status'];
    mailStatus = json['mail_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['notification_status'] = notificationStatus;
    data['mail_status'] = mailStatus;
    return data;
  }
}
