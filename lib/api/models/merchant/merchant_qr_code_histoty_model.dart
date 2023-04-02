// To parse this JSON data, do
//
//     final merchantQrcodeHistory = merchantQrcodeHistoryFromJson(jsonString);

import 'dart:convert';

MerchantQrcodeHistory merchantQrcodeHistoryFromJson(String str) => MerchantQrcodeHistory.fromJson(json.decode(str));


class MerchantQrcodeHistory {
    MerchantQrcodeHistory({
        this.status,
        this.message,
        this.data,
    });

    int ?status;
    String? message;
    List<Datum>? data;

    factory MerchantQrcodeHistory.fromJson(Map<String, dynamic> json) => MerchantQrcodeHistory(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

}

class Datum {
    Datum({
        this.id,
        this.customerName,
        this.businessId,
        this.merchantBusinessName,
        this.merchantBusinessLogo,
        this.description,
        this.txRef,
        this.amount,
        this.dateCreated,
        this.expire,
        this.status,
        this.customer,
        this.merchant,
    });

    int? id;
    String? customerName;
    String? businessId;
    String? merchantBusinessName;
    String? merchantBusinessLogo;
    String? description;
    String? txRef;
    String? amount;
    DateTime? dateCreated;
    DateTime? expire;
    String? status;
    int? customer;
    int? merchant;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        customerName: json["customerName"],
        businessId: json["businessId"],
        merchantBusinessName: json["merchantBusinessName"],
        merchantBusinessLogo: json["merchantBusinessLogo"],
        description: json["description"],
        txRef: json["txRef"],
        amount: json["amount"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        expire: DateTime.parse(json["expire"]),
        status: json["status"],
        customer: json["customer"],
        merchant: json["merchant"],
    );

}
