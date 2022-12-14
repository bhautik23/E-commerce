// ignore_for_file: prefer_collection_literals, camel_case_types

class ourteammodel {
  int? status;
  String? message;
  List<Data>? data;

  ourteammodel({this.status, this.message, this.data});

  ourteammodel.fromJson(Map<String, dynamic> json) {
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
  dynamic title;
  dynamic subtitle;
  dynamic fb;
  dynamic youtube;
  dynamic insta;
  dynamic description;
  dynamic imageUrl;

  Data(
      {this.id,
      this.title,
      this.subtitle,
      this.fb,
      this.youtube,
      this.insta,
      this.description,
      this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    fb = json['fb'];
    youtube = json['youtube'];
    insta = json['insta'];
    description = json['description'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['fb'] = fb;
    data['youtube'] = youtube;
    data['insta'] = insta;
    data['description'] = description;
    data['image_url'] = imageUrl;
    return data;
  }
}
