// ignore_for_file: camel_case_types, prefer_collection_literals

class gallerymodel {
  int? status;
  String? message;
  List<imageData>? data;

  gallerymodel({this.status, this.message, this.data});

  gallerymodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <imageData>[];
      json['data'].forEach((v) {
        data!.add(imageData.fromJson(v));
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

class imageData {
  String? imageUrl;

  imageData({this.imageUrl});

  imageData.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image_url'] = imageUrl;
    return data;
  }
}
