// ignore_for_file: camel_case_types, prefer_collection_literals

class wallettransactionmodel {
  int? status;
  String? message;
  List<Transactions>? transactions;

  wallettransactionmodel({this.status, this.message, this.transactions});

  wallettransactionmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  int? id;
  String? userId;
  String? orderId;
  String? orderNumber;
  String? amount;
  String? transactionId;
  String? transactionType;
  String? username;
  String? date;

  Transactions(
      {this.id,
      this.userId,
      this.orderId,
      this.orderNumber,
      this.amount,
      this.transactionId,
      this.transactionType,
      this.username,
      this.date});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    orderNumber = json['order_number'];
    amount = json['amount'];
    transactionId = json['transaction_id'];
    transactionType = json['transaction_type'];
    username = json['username'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['order_id'] = orderId;
    data['order_number'] = orderNumber;
    data['amount'] = amount;
    data['transaction_id'] = transactionId;
    data['transaction_type'] = transactionType;
    data['username'] = username;
    data['date'] = date;
    return data;
  }
}
