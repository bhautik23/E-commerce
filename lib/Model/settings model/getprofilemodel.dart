// class getprofilemodel {
//   int? status;
//   String? message;
//   Data? data;
//   Admin? admin;

//   getprofilemodel({this.status, this.message, this.data, this.admin});

//   getprofilemodel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     if (this.admin != null) {
//       data['admin'] = this.admin!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? name;
//   String? mobile;
//   String? email;
//   String? loginType;
//   String? wallet;
//   String? isNotification;
//   String? isMail;
//   String? profileImage;

//   Data(
//       {this.id,
//       this.name,
//       this.mobile,
//       this.email,
//       this.loginType,
//       this.wallet,
//       this.isNotification,
//       this.isMail,
//       this.profileImage});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     mobile = json['mobile'];
//     email = json['email'];
//     loginType = json['login_type'];
//     wallet = json['wallet'];
//     isNotification = json['is_notification'];
//     isMail = json['is_mail'];
//     profileImage = json['profile_image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['mobile'] = this.mobile;
//     data['email'] = this.email;
//     data['login_type'] = this.loginType;
//     data['wallet'] = this.wallet;
//     data['is_notification'] = this.isNotification;
//     data['is_mail'] = this.isMail;
//     data['profile_image'] = this.profileImage;
//     return data;
//   }
// }

// class Admin {
//   String? email;
//   String? mobile;
//   String? address;
//   String? fb;
//   String? twitter;
//   String? insta;

//   Admin(
//       {this.email,
//       this.mobile,
//       this.address,
//       this.fb,
//       this.twitter,
//       this.insta});

//   Admin.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//     mobile = json['mobile'];
//     address = json['address'];
//     fb = json['fb'];
//     twitter = json['twitter'];
//     insta = json['insta'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['email'] = this.email;
//     data['mobile'] = this.mobile;
//     data['address'] = this.address;
//     data['fb'] = this.fb;
//     data['twitter'] = this.twitter;
//     data['insta'] = this.insta;
//     return data;
//   }
// }
