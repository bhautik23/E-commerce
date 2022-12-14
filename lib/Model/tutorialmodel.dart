// ignore_for_file: camel_case_types, prefer_collection_literals

class tutorialMODEL {
  dynamic status;
  dynamic message;
  List<Data>? data;

  tutorialMODEL({this.status, this.message, this.data});

  tutorialMODEL.fromJson(Map<String, dynamic> json) {
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
  dynamic description;
  dynamic imageUrl;

  Data({this.id, this.title, this.description, this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image_url'] = imageUrl;
    return data;
  }
}
