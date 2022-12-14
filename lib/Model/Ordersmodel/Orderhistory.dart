// ignore_for_file: file_names, camel_case_types, prefer_collection_literals

class orderhistorymodel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  orderhistorymodel({this.status, this.message, this.data});

  orderhistorymodel.fromJson(Map<String, dynamic> json) {
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
  dynamic orderType;
  dynamic orderNumber;
  dynamic grandTotal;
  dynamic status;
  dynamic transactionType;
  dynamic qty;
  dynamic date;

  Data(
      {this.id,
      this.orderType,
      this.orderNumber,
      this.grandTotal,
      this.status,
      this.transactionType,
      this.qty,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderType = json['order_type'];
    orderNumber = json['order_number'];
    grandTotal = json['grand_total'];
    status = json['status'];
    transactionType = json['transaction_type'];
    qty = json['qty'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['order_type'] = orderType;
    data['order_number'] = orderNumber;
    data['grand_total'] = grandTotal;
    data['status'] = status;
    data['transaction_type'] = transactionType;
    data['qty'] = qty;
    data['date'] = date;
    return data;
  }
}
