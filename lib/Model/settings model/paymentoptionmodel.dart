// ignore_for_file: prefer_collection_literals, camel_case_types

class paymentoptionModel {
  int? status;
  String? message;
  String? totalWallet;
  List<Paymentmethods>? paymentmethods;

  paymentoptionModel(
      {this.status, this.message, this.totalWallet, this.paymentmethods});

  paymentoptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalWallet = json['total_wallet'];
    if (json['paymentmethods'] != null) {
      paymentmethods = <Paymentmethods>[];
      json['paymentmethods'].forEach((v) {
        paymentmethods!.add(Paymentmethods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['total_wallet'] = totalWallet;
    if (paymentmethods != null) {
      data['paymentmethods'] = paymentmethods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Paymentmethods {
  int? id;
  String? environment;
  String? paymentName;
  String? currency;
  String? testPublicKey;
  String? testSecretKey;
  String? livePublicKey;
  String? liveSecretKey;
  String? encryptionKey;
  String? image;

  Paymentmethods(
      {this.id,
      this.environment,
      this.paymentName,
      this.currency,
      this.testPublicKey,
      this.testSecretKey,
      this.livePublicKey,
      this.liveSecretKey,
      this.encryptionKey,
      this.image});

  Paymentmethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    environment = json['environment'];
    paymentName = json['payment_name'];
    currency = json['currency'];
    testPublicKey = json['test_public_key'];
    testSecretKey = json['test_secret_key'];
    livePublicKey = json['live_public_key'];
    liveSecretKey = json['live_secret_key'];
    encryptionKey = json['encryption_key'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['environment'] = environment;
    data['payment_name'] = paymentName;
    data['currency'] = currency;
    data['test_public_key'] = testPublicKey;
    data['test_secret_key'] = testSecretKey;
    data['live_public_key'] = livePublicKey;
    data['live_secret_key'] = liveSecretKey;
    data['encryption_key'] = encryptionKey;
    return data;
  }
}
