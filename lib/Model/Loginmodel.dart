// ignore_for_file: file_names, prefer_collection_literals

class Loginmodel {
  int? status;
  String? message;
  Data? data;

  Loginmodel({this.status, this.message, this.data});

  Loginmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? loginType;
  String? wallet;
  String? isNotification;
  String? isMail;
  String? referralCode;
  String? profileImage;

  Data(
      {this.id,
      this.name,
      this.mobile,
      this.email,
      this.loginType,
      this.wallet,
      this.isNotification,
      this.isMail,
      this.referralCode,
      this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    loginType = json['login_type'];
    wallet = json['wallet'];
    isNotification = json['is_notification'];
    isMail = json['is_mail'];
    referralCode = json['referral_code'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['login_type'] = loginType;
    data['wallet'] = wallet;
    data['is_notification'] = isNotification;
    data['is_mail'] = isMail;
    data['referral_code'] = referralCode;
    data['profile_image'] = profileImage;
    return data;
  }
}
