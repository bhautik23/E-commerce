// ignore_for_file: prefer_collection_literals, camel_case_types

class cmsMODEL {
  int? status;
  String? message;
  String? privacypolicy;
  String? termscondition;

  cmsMODEL(
      {this.status, this.message, this.privacypolicy, this.termscondition});

  cmsMODEL.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    privacypolicy = json['privacypolicy'];
    termscondition = json['termscondition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['privacypolicy'] = privacypolicy;
    data['termscondition'] = termscondition;
    return data;
  }
}
