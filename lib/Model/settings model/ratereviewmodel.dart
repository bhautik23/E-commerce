// ignore_for_file: prefer_collection_literals

class Ratereviewmodel {
  int? status;
  String? message;
  List<Data>? data;

  Ratereviewmodel({this.status, this.message, this.data});

  Ratereviewmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic ratting;
  dynamic comment;
  dynamic date;
  dynamic userId;
  dynamic name;
  dynamic profileImage;

  Data(
      {this.id,
      this.ratting,
      this.comment,
      this.date,
      this.userId,
      this.name,
      this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ratting = json['ratting'];
    comment = json['comment'];
    date = json['date'];
    userId = json['user_id'];
    name = json['name'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['ratting'] = ratting;
    data['comment'] = comment;
    data['date'] = date;
    data['user_id'] = userId;
    data['name'] = name;
    data['profile_image'] = profileImage;
    return data;
  }
}
