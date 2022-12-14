// ignore_for_file: prefer_collection_literals, camel_case_types

class categoriesmodel {
  int? status;
  String? message;
  List<Data>? data;

  categoriesmodel({this.status, this.message, this.data});

  categoriesmodel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? categoryName;
  String? imageUrl;

  Data({this.id, this.categoryName, this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['category_name'] = categoryName;
    data['image_url'] = imageUrl;
    return data;
  }
}
