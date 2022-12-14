// // To parse this JSON data, do
// //
// //     final orderdetailsmodel = orderdetailsmodelFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// Orderdetailsmodel orderdetailsmodelFromJson(String str) =>
//     Orderdetailsmodel.fromJson(json.decode(str));

// String orderdetailsmodelToJson(Orderdetailsmodel data) =>
//     json.encode(data.toJson());

// class Orderdetailsmodel {
//   Orderdetailsmodel({
//     required this.status,
//     required this.message,
//     required this.data,
//     required this.driverInfo,
//     required this.userInfo,
//     required this.summery,
//   });

//   final int status;
//   final String message;
//   final List<Datum> data;
//   final ErInfo driverInfo;
//   final ErInfo userInfo;
//   final Summery summery;

//   factory Orderdetailsmodel.fromJson(Map<String, dynamic> json) =>
//       Orderdetailsmodel(
//         status: json["status"],
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         driverInfo: ErInfo.fromJson(json["driver_info"]),
//         userInfo: ErInfo.fromJson(json["user_info"]),
//         summery: Summery.fromJson(json["summery"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "driver_info": driverInfo.toJson(),
//         "user_info": userInfo.toJson(),
//         "summery": summery.toJson(),
//       };
// }

// class Datum {
//   Datum({
//     required this.id,
//     required this.itemId,
//     required this.itemName,
//     required this.itemType,
//     required this.itemImage,
//     required this.addonsId,
//     required this.addonsName,
//     required this.addonsPrice,
//     required this.addonsTotalPrice,
//     required this.variationId,
//     required this.variation,
//     required this.itemPrice,
//     required this.qty,
//     required this.totalPrice,
//   });

//   final String id;
//   final String itemId;
//   final String itemName;
//   final String itemType;
//   final String itemImage;
//   final String addonsId;
//   final String addonsName;
//   final String addonsPrice;
//   final dynamic addonsTotalPrice;
//   final String variationId;
//   final String variation;
//   final String itemPrice;
//   final String qty;
//   final String totalPrice;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         itemId: json["item_id"],
//         itemName: json["item_name"],
//         itemType: json["item_type"],
//         itemImage: json["item_image"],
//         addonsId: json["addons_id"],
//         addonsName: json["addons_name"],
//         addonsPrice: json["addons_price"],
//         addonsTotalPrice: json["addons_total_price"],
//         variationId: json["variation_id"],
//         variation: json["variation"],
//         itemPrice: json["item_price"],
//         qty: json["qty"],
//         totalPrice: json["total_price"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "item_id": itemId,
//         "item_name": itemName,
//         "item_type": itemType,
//         "item_image": itemImage,
//         "addons_id": addonsId,
//         "addons_name": addonsName,
//         "addons_price": addonsPrice,
//         "addons_total_price": addonsTotalPrice,
//         "variation_id": variationId,
//         "variation": variation,
//         "item_price": itemPrice,
//         "qty": qty,
//         "total_price": totalPrice,
//       };
// }

// class ErInfo {
//   ErInfo({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.mobile,
//     required this.token,
//     required this.profileImage,
//   });

//   final String id;
//   final String name;
//   final String email;
//   final String mobile;
//   final String token;
//   final String profileImage;

//   factory ErInfo.fromJson(Map<String, dynamic> json) => ErInfo(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         mobile: json["mobile"],
//         token: json["token"],
//         profileImage: json["profile_image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "mobile": mobile,
//         "token": token,
//         "profile_image": profileImage,
//       };
// }

// class Summery {
//   Summery({
//     required this.id,
//     required this.orderNumber,
//     required this.status,
//     required this.orderType,
//     required this.addressType,
//     required this.address,
//     required this.houseNo,
//     required this.area,
//     required this.lat,
//     required this.lang,
//     required this.transactionType,
//     required this.transactionId,
//     required this.offerCode,
//     required this.orderNotes,
//     required this.discountAmount,
//     required this.deliveryCharge,
//     required this.date,
//     required this.orderTotal,
//     required this.tax,
//     required this.grandTotal,
//   });

//   final String id;
//   final String orderNumber;
//   final String status;
//   final String orderType;
//   final String addressType;
//   final String address;
//   final String houseNo;
//   final String area;
//   final String lat;
//   final String lang;
//   final String transactionType;
//   final String transactionId;
//   final String offerCode;
//   final String orderNotes;
//   final int discountAmount;
//   final String deliveryCharge;
//   final String date;
//   final int orderTotal;
//   final String tax;
//   final String grandTotal;

//   factory Summery.fromJson(Map<String, dynamic> json) => Summery(
//         id: json["id"],
//         orderNumber: json["order_number"],
//         status: json["status"],
//         orderType: json["order_type"],
//         addressType: json["address_type"],
//         address: json["address"],
//         houseNo: json["house_no"],
//         area: json["area"],
//         lat: json["lat"],
//         lang: json["lang"],
//         transactionType: json["transaction_type"],
//         transactionId: json["transaction_id"],
//         offerCode: json["offer_code"],
//         orderNotes: json["order_notes"],
//         discountAmount: json["discount_amount"],
//         deliveryCharge: json["delivery_charge"],
//         date: json["date"],
//         orderTotal: json["order_total"],
//         tax: json["tax"],
//         grandTotal: json["grand_total"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "order_number": orderNumber,
//         "status": status,
//         "order_type": orderType,
//         "address_type": addressType,
//         "address": address,
//         "house_no": houseNo,
//         "area": area,
//         "lat": lat,
//         "lang": lang,
//         "transaction_type": transactionType,
//         "transaction_id": transactionId,
//         "offer_code": offerCode,
//         "order_notes": orderNotes,
//         "discount_amount": discountAmount,
//         "delivery_charge": deliveryCharge,
//         "date": date,
//         "order_total": orderTotal,
//         "tax": tax,
//         "grand_total": grandTotal,
//       };
// }
