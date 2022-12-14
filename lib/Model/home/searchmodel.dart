// ignore_for_file: camel_case_types, prefer_collection_literals

import 'package:ecommerce_user/Model/favoritepage/itemmodel.dart';

class searchmodel {
  dynamic status;
  dynamic message;
  List<itemmodel>? data;

  searchmodel({this.status, this.message, this.data});

  searchmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <itemmodel>[];
      json['data'].forEach((v) {
        data!.add(itemmodel.fromJson(v));
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

class SearchData {
  dynamic id;
  dynamic itemName;
  dynamic itemType;
  dynamic preparationTime;
  dynamic price;
  dynamic isFavorite;
  dynamic isFeatured;
  dynamic isCart;
  dynamic itemQty;
  dynamic tax;
  dynamic imageName;
  dynamic imageUrl;
  dynamic itemDescription;
  CategoryInfo? categoryInfo;
  SubcategoryInfo? subcategoryInfo;
  dynamic hasVariation;
  dynamic attribute;
  List<Variation>? variation;
  List<Addons>? addons;

  SearchData(
      {this.id,
      this.itemName,
      this.itemType,
      this.preparationTime,
      this.price,
      this.isFavorite,
      this.isFeatured,
      this.isCart,
      this.itemQty,
      this.tax,
      this.imageName,
      this.imageUrl,
      this.itemDescription,
      this.categoryInfo,
      this.subcategoryInfo,
      this.hasVariation,
      this.attribute,
      this.variation,
      this.addons});

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    itemType = json['item_type'];
    preparationTime = json['preparation_time'];
    price = json['price'];
    isFavorite = json['is_favorite'];
    isFeatured = json['is_featured'];
    isCart = json['is_cart'];
    itemQty = json['item_qty'];
    tax = json['tax'];
    imageName = json['image_name'];
    imageUrl = json['image_url'];
    itemDescription = json['item_description'];
    categoryInfo = json['category_info'] != null
        ? CategoryInfo.fromJson(json['category_info'])
        : null;
    subcategoryInfo = json['subcategory_info'] != null
        ? SubcategoryInfo.fromJson(json['subcategory_info'])
        : null;
    hasVariation = json['has_variation'];
    attribute = json['attribute'];
    if (json['variation'] != null) {
      variation = <Variation>[];
      json['variation'].forEach((v) {
        variation!.add(Variation.fromJson(v));
      });
    }
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(Addons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['item_name'] = itemName;
    data['item_type'] = itemType;
    data['preparation_time'] = preparationTime;
    data['price'] = price;
    data['is_favorite'] = isFavorite;
    data['is_featured'] = isFeatured;
    data['is_cart'] = isCart;
    data['item_qty'] = itemQty;
    data['tax'] = tax;
    data['image_name'] = imageName;
    data['image_url'] = imageUrl;
    data['item_description'] = itemDescription;
    if (categoryInfo != null) {
      data['category_info'] = categoryInfo!.toJson();
    }
    if (subcategoryInfo != null) {
      data['subcategory_info'] = subcategoryInfo!.toJson();
    }
    data['has_variation'] = hasVariation;
    data['attribute'] = attribute;
    if (variation != null) {
      data['variation'] = variation!.map((v) => v.toJson()).toList();
    }
    if (addons != null) {
      data['addons'] = addons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryInfo {
  dynamic id;
  dynamic categoryName;
  dynamic slug;
  dynamic imageUrl;

  CategoryInfo({this.id, this.categoryName, this.slug, this.imageUrl});

  CategoryInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    slug = json['slug'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['category_name'] = categoryName;
    data['slug'] = slug;
    data['image_url'] = imageUrl;
    return data;
  }
}

class SubcategoryInfo {
  dynamic id;
  dynamic subcategoryName;
  dynamic slug;

  SubcategoryInfo({this.id, this.subcategoryName, this.slug});

  SubcategoryInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcategoryName = json['subcategory_name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['subcategory_name'] = subcategoryName;
    data['slug'] = slug;
    return data;
  }
}

class Variation {
  dynamic id;
  dynamic itemId;
  dynamic variation;
  dynamic productPrice;
  dynamic salePrice;

  Variation(
      {this.id,
      this.itemId,
      this.variation,
      this.productPrice,
      this.salePrice});

  Variation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    variation = json['variation'];
    productPrice = json['product_price'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['item_id'] = itemId;
    data['variation'] = variation;
    data['product_price'] = productPrice;
    data['sale_price'] = salePrice;
    return data;
  }
}

class Addons {
  dynamic id;
  dynamic name;
  dynamic price;

  Addons({this.id, this.name, this.price});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
