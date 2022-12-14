// ignore_for_file: camel_case_types, prefer_collection_literals

import 'package:ecommerce_user/Model/favoritepage/itemmodel.dart';

class itemdetailsmodel {
  dynamic status;
  dynamic message;
  Data? data;
  List<itemmodel>? relateditems;

  itemdetailsmodel({this.status, this.message, this.data, this.relateditems});

  itemdetailsmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['relateditems'] != null) {
      relateditems = <itemmodel>[];
      json['relateditems'].forEach((v) {
        relateditems!.add(itemmodel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (relateditems != null) {
      data['relateditems'] = relateditems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic itemName;
  dynamic itemType;
  dynamic preparationTime;
  dynamic price;
  dynamic availableQty;
  dynamic isFavorite;
  dynamic isCart;
  dynamic itemQty;
  dynamic tax;
  List<ItemImages>? itemImages;
  dynamic itemDescription;
  CategoryInfo? categoryInfo;
  SubcategoryInfo? subcategoryInfo;
  dynamic hasVariation;
  dynamic attribute;
  List<Variation>? variation;
  List<Addons>? addons;

  Data(
      {this.id,
      this.itemName,
      this.itemType,
      this.preparationTime,
      this.price,
      this.availableQty,
      this.isFavorite,
      this.isCart,
      this.itemQty,
      this.tax,
      this.itemImages,
      this.itemDescription,
      this.categoryInfo,
      this.subcategoryInfo,
      this.hasVariation,
      this.attribute,
      this.variation,
      this.addons});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    itemType = json['item_type'];
    preparationTime = json['preparation_time'];
    price = json['price'];
    availableQty = json['available_qty'];
    isFavorite = json['is_favorite'];
    isCart = json['is_cart'];
    itemQty = json['item_qty'];
    tax = json['tax'];
    if (json['item_images'] != null) {
      itemImages = <ItemImages>[];
      json['item_images'].forEach((v) {
        itemImages!.add(ItemImages.fromJson(v));
      });
    }
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
    data['available_qty'] = availableQty;
    data['is_favorite'] = isFavorite;
    data['is_cart'] = isCart;
    data['item_qty'] = itemQty;
    data['tax'] = tax;
    if (itemImages != null) {
      data['item_images'] = itemImages!.map((v) => v.toJson()).toList();
    }
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

class ItemImages {
  dynamic id;
  dynamic imageName;
  dynamic itemId;
  dynamic imageUrl;

  ItemImages({this.id, this.imageName, this.itemId, this.imageUrl});

  ItemImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageName = json['image_name'];
    itemId = json['item_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['image_name'] = imageName;
    data['item_id'] = itemId;
    data['image_url'] = imageUrl;
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
  String? availableQty;

  Variation(
      {this.id,
      this.itemId,
      this.variation,
      this.productPrice,
      this.salePrice,
      this.availableQty});

  Variation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    variation = json['variation'];
    productPrice = json['product_price'];
    salePrice = json['sale_price'];
    availableQty = json['available_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['item_id'] = itemId;
    data['variation'] = variation;
    data['product_price'] = productPrice;
    data['sale_price'] = salePrice;
    data['available_qty'] = availableQty;
    return data;
  }
}

class Addons {
  dynamic id;
  dynamic name;
  dynamic price;
  dynamic isselected;

  Addons({this.id, this.name, this.price});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    isselected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['isselected'] = isselected;
    return data;
  }
}

class Relateditems {
  dynamic id;
  dynamic itemName;
  dynamic itemType;
  dynamic preparationTime;
  dynamic price;
  dynamic isFavorite;
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

  Relateditems(
      {this.id,
      this.itemName,
      this.itemType,
      this.preparationTime,
      this.price,
      this.isFavorite,
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

  Relateditems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    itemType = json['item_type'];
    preparationTime = json['preparation_time'];
    price = json['price'];
    isFavorite = json['is_favorite'];
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
