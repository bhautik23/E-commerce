// ignore_for_file: camel_case_types, prefer_collection_literals

import 'package:ecommerce_user/Model/favoritepage/itemmodel.dart';

class homescreenmodel {
  dynamic status;
  dynamic message;
  List<itemmodel>? trendingitems;
  List<itemmodel>? todayspecial;
  List<itemmodel>? recommendeditems;
  dynamic checkaddons;
  Appdata? appdata;
  Getprofile? getprofile;
  Cartdata? cartdata;
  Banners? banners;
  List<Categories>? categories;
  List<Testimonials>? testimonials;

  homescreenmodel(
      {this.status,
      this.message,
      this.trendingitems,
      this.todayspecial,
      this.recommendeditems,
      this.checkaddons,
      this.appdata,
      this.getprofile,
      this.cartdata,
      this.banners,
      this.categories,
      this.testimonials});

  homescreenmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['trendingitems'] != null) {
      trendingitems = <itemmodel>[];
      json['trendingitems'].forEach((v) {
        trendingitems!.add(itemmodel.fromJson(v));
      });
    }
    if (json['todayspecial'] != null) {
      todayspecial = <itemmodel>[];
      json['todayspecial'].forEach((v) {
        todayspecial!.add(itemmodel.fromJson(v));
      });
    }
    if (json['recommendeditems'] != null) {
      recommendeditems = <itemmodel>[];
      json['recommendeditems'].forEach((v) {
        recommendeditems!.add(itemmodel.fromJson(v));
      });
    }
    checkaddons = json['checkaddons'];
    appdata =
        json['appdata'] != null ? Appdata.fromJson(json['appdata']) : null;
    getprofile = json['getprofile'] != null
        ? Getprofile.fromJson(json['getprofile'])
        : null;
    cartdata =
        json['cartdata'] != null ? Cartdata.fromJson(json['cartdata']) : null;
    banners =
        json['banners'] != null ? Banners.fromJson(json['banners']) : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['testimonials'] != null) {
      testimonials = <Testimonials>[];
      json['testimonials'].forEach((v) {
        testimonials!.add(Testimonials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (trendingitems != null) {
      data['trendingitems'] = trendingitems!.map((v) => v.toJson()).toList();
    }
    if (todayspecial != null) {
      data['todayspecial'] = todayspecial!.map((v) => v.toJson()).toList();
    }
    if (recommendeditems != null) {
      data['recommendeditems'] =
          recommendeditems!.map((v) => v.toJson()).toList();
    }
    data['checkaddons'] = checkaddons;
    if (appdata != null) {
      data['appdata'] = appdata!.toJson();
    }
    if (getprofile != null) {
      data['getprofile'] = getprofile!.toJson();
    }
    if (cartdata != null) {
      data['cartdata'] = cartdata!.toJson();
    }
    if (banners != null) {
      data['banners'] = banners!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (testimonials != null) {
      data['testimonials'] = testimonials!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Trendingitems {
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

  Trendingitems(
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

  Trendingitems.fromJson(Map<String, dynamic> json) {
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

class Todayspecial {
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

  Todayspecial(
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

  Todayspecial.fromJson(Map<String, dynamic> json) {
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

class Appdata {
  dynamic id;
  dynamic aboutContent;
  dynamic fb;
  dynamic youtube;
  dynamic insta;
  dynamic android;
  dynamic ios;
  dynamic appBottomImage;
  dynamic mobileAppImage;
  dynamic mobileAppTitle;
  dynamic mobileAppDescription;
  dynamic copyright;
  dynamic title;
  dynamic shortTitle;
  dynamic ogTitle;
  dynamic ogDescription;
  dynamic mobile;
  dynamic email;
  dynamic address;
  dynamic currency;
  dynamic currencyPosition;
  dynamic maxOrderQty;
  dynamic minOrderAmount;
  dynamic maxOrderAmount;
  dynamic deliveryCharge;
  dynamic map;
  dynamic firebase;
  dynamic referralAmount;
  dynamic timezone;
  dynamic lat;
  dynamic lang;
  dynamic image;
  dynamic logo;
  dynamic footerLogo;
  dynamic favicon;
  dynamic ogImage;
  dynamic verification;
  dynamic currentVersion;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic appBottomImageUrl;
  dynamic isAppBottomImage;

  Appdata(
      {this.id,
      this.aboutContent,
      this.fb,
      this.youtube,
      this.insta,
      this.android,
      this.ios,
      this.appBottomImage,
      this.mobileAppImage,
      this.mobileAppTitle,
      this.mobileAppDescription,
      this.copyright,
      this.title,
      this.shortTitle,
      this.ogTitle,
      this.ogDescription,
      this.mobile,
      this.email,
      this.address,
      this.currency,
      this.currencyPosition,
      this.maxOrderQty,
      this.minOrderAmount,
      this.maxOrderAmount,
      this.deliveryCharge,
      this.map,
      this.firebase,
      this.referralAmount,
      this.timezone,
      this.lat,
      this.lang,
      this.image,
      this.logo,
      this.footerLogo,
      this.favicon,
      this.ogImage,
      this.verification,
      this.currentVersion,
      this.createdAt,
      this.updatedAt,
      this.appBottomImageUrl,
      this.isAppBottomImage});

  Appdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aboutContent = json['about_content'];
    fb = json['fb'];
    youtube = json['youtube'];
    insta = json['insta'];
    android = json['android'];
    ios = json['ios'];
    appBottomImage = json['app_bottom_image'];
    mobileAppImage = json['mobile_app_image'];
    mobileAppTitle = json['mobile_app_title'];
    mobileAppDescription = json['mobile_app_description'];
    copyright = json['copyright'];
    title = json['title'];
    shortTitle = json['short_title'];
    ogTitle = json['og_title'];
    ogDescription = json['og_description'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    currency = json['currency'];
    currencyPosition = json['currency_position'];
    maxOrderQty = json['max_order_qty'];
    minOrderAmount = json['min_order_amount'];
    maxOrderAmount = json['max_order_amount'];
    deliveryCharge = json['delivery_charge'];
    map = json['map'];
    firebase = json['firebase'];
    referralAmount = json['referral_amount'];
    timezone = json['timezone'];
    lat = json['lat'];
    lang = json['lang'];
    image = json['image'];
    logo = json['logo'];
    footerLogo = json['footer_logo'];
    favicon = json['favicon'];
    ogImage = json['og_image'];
    verification = json['verification'];
    currentVersion = json['current_version'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    appBottomImageUrl = json['app_bottom_image_url'];
    isAppBottomImage = json['is_app_bottom_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['about_content'] = aboutContent;
    data['fb'] = fb;
    data['youtube'] = youtube;
    data['insta'] = insta;
    data['android'] = android;
    data['ios'] = ios;
    data['app_bottom_image'] = appBottomImage;
    data['mobile_app_image'] = mobileAppImage;
    data['mobile_app_title'] = mobileAppTitle;
    data['mobile_app_description'] = mobileAppDescription;
    data['copyright'] = copyright;
    data['title'] = title;
    data['short_title'] = shortTitle;
    data['og_title'] = ogTitle;
    data['og_description'] = ogDescription;
    data['mobile'] = mobile;
    data['email'] = email;
    data['address'] = address;
    data['currency'] = currency;
    data['currency_position'] = currencyPosition;
    data['max_order_qty'] = maxOrderQty;
    data['min_order_amount'] = minOrderAmount;
    data['max_order_amount'] = maxOrderAmount;
    data['delivery_charge'] = deliveryCharge;
    data['map'] = map;
    data['firebase'] = firebase;
    data['referral_amount'] = referralAmount;
    data['timezone'] = timezone;
    data['lat'] = lat;
    data['lang'] = lang;
    data['image'] = image;
    data['logo'] = logo;
    data['footer_logo'] = footerLogo;
    data['favicon'] = favicon;
    data['og_image'] = ogImage;
    data['verification'] = verification;
    data['current_version'] = currentVersion;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['app_bottom_image_url'] = appBottomImageUrl;
    data['is_app_bottom_image'] = isAppBottomImage;
    return data;
  }
}

class Getprofile {
  dynamic id;
  dynamic name;
  dynamic mobile;
  dynamic email;
  dynamic loginType;
  dynamic wallet;
  dynamic isNotification;
  dynamic isMail;
  dynamic referralCode;
  dynamic profileImage;

  Getprofile(
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

  Getprofile.fromJson(Map<String, dynamic> json) {
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

class Cartdata {
  dynamic totalCount;
  dynamic subTotal;

  Cartdata({this.totalCount, this.subTotal});

  Cartdata.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    subTotal = json['sub_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total_count'] = totalCount;
    data['sub_total'] = subTotal;
    return data;
  }
}

class Banners {
  List<Bannersection1>? bannersection3;
  List<Topbanners>? topbanners;
  List<Bannersection1>? bannersection1;
  List<Bannersection1>? bannersection2;

  Banners(
      {this.bannersection3,
      this.topbanners,
      this.bannersection1,
      this.bannersection2});

  Banners.fromJson(Map<String, dynamic> json) {
    if (json['bannersection3'] != null) {
      bannersection3 = <Bannersection1>[];
      json['bannersection3'].forEach((v) {
        bannersection3!.add(Bannersection1.fromJson(v));
      });
    }
    if (json['topbanners'] != null) {
      topbanners = <Topbanners>[];
      json['topbanners'].forEach((v) {
        topbanners!.add(Topbanners.fromJson(v));
      });
    }
    if (json['bannersection1'] != null) {
      bannersection1 = <Bannersection1>[];
      json['bannersection1'].forEach((v) {
        bannersection1!.add(Bannersection1.fromJson(v));
      });
    }
    if (json['bannersection2'] != null) {
      bannersection2 = <Bannersection1>[];
      json['bannersection2'].forEach((v) {
        bannersection2!.add(Bannersection1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (bannersection3 != null) {
      data['bannersection3'] = bannersection3!.map((v) => v.toJson()).toList();
    }
    if (topbanners != null) {
      data['topbanners'] = topbanners!.map((v) => v.toJson()).toList();
    }
    if (bannersection1 != null) {
      data['bannersection1'] = bannersection1!.map((v) => v.toJson()).toList();
    }
    if (bannersection2 != null) {
      data['bannersection2'] = bannersection2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bannersection1 {
  dynamic id;
  dynamic type;
  dynamic itemId;
  dynamic catId;
  dynamic image;
  ItemInfo? itemInfo;
  CategoryInfo? categoryInfo;

  Bannersection1(
      {this.id,
      this.type,
      this.itemId,
      this.catId,
      this.image,
      this.itemInfo,
      this.categoryInfo});

  Bannersection1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    itemId = json['item_id'];
    catId = json['cat_id'];
    image = json['image'];
    itemInfo =
        json['item_info'] != null ? ItemInfo.fromJson(json['item_info']) : null;
    categoryInfo = json['category_info'] != null
        ? CategoryInfo.fromJson(json['category_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['item_id'] = itemId;
    data['cat_id'] = catId;
    data['image'] = image;
    data['item_info'] = itemInfo;
    if (categoryInfo != null) {
      data['category_info'] = categoryInfo!.toJson();
    }
    return data;
  }
}

class Topbanners {
  dynamic id;
  dynamic type;
  dynamic itemId;
  dynamic catId;
  dynamic image;
  ItemInfo? itemInfo;
  CategoryInfo? categoryInfo;

  Topbanners(
      {this.id,
      this.type,
      this.itemId,
      this.catId,
      this.image,
      this.itemInfo,
      this.categoryInfo});

  Topbanners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    itemId = json['item_id'];
    catId = json['cat_id'];
    image = json['image'];
    itemInfo =
        json['item_info'] != null ? ItemInfo.fromJson(json['item_info']) : null;
    categoryInfo = json['category_info'] != null
        ? CategoryInfo.fromJson(json['category_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['item_id'] = itemId;
    data['cat_id'] = catId;
    data['image'] = image;
    if (itemInfo != null) {
      data['item_info'] = itemInfo!.toJson();
    }
    if (categoryInfo != null) {
      data['category_info'] = categoryInfo!.toJson();
    }
    return data;
  }
}

class ItemInfo {
  dynamic id;
  dynamic itemName;
  dynamic slug;

  ItemInfo({this.id, this.itemName, this.slug});

  ItemInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['item_name'] = itemName;
    data['slug'] = slug;
    return data;
  }
}

class Categories {
  dynamic id;
  dynamic categoryName;
  dynamic image;

  Categories({this.id, this.categoryName, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['category_name'] = categoryName;
    data['image'] = image;
    return data;
  }
}

class Testimonials {
  dynamic id;
  dynamic ratting;
  dynamic comment;
  dynamic date;
  dynamic userId;
  dynamic name;
  dynamic profileImage;

  Testimonials(
      {this.id,
      this.ratting,
      this.comment,
      this.date,
      this.userId,
      this.name,
      this.profileImage});

  Testimonials.fromJson(Map<String, dynamic> json) {
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
