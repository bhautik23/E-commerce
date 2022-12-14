// ignore_for_file: file_names, camel_case_types, prefer_collection_literals

class addwalletMODEL {
  int? status;
  String? message;
  double? totalWallet;

  addwalletMODEL({this.status, this.message, this.totalWallet});

  addwalletMODEL.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalWallet = json['total_wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['total_wallet'] = totalWallet;
    return data;
  }
}
