// To parse this JSON data, do
//
//     final qRcodeTransactionModel = qRcodeTransactionModelFromJson(jsonString);

import 'dart:convert';

QRcodeTransactionModel qRcodeTransactionModelFromJson(String str) => QRcodeTransactionModel.fromJson(json.decode(str));


class QRcodeTransactionModel {
    QRcodeTransactionModel({
        this.status,
        this.message,
        this.data,
    });

    int? status;
    String ?message;
    List<Datum>? data;

    factory QRcodeTransactionModel.fromJson(Map<String, dynamic> json) => QRcodeTransactionModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

 
}

class Datum {
    Datum({
        this.id,
        this.customerName,
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
    String ?customerName;
    String ?merchantBusinessName;
    String ?merchantBusinessLogo;
    String ?description;
    String ?txRef;
    String ?amount;
    DateTime? dateCreated;
    DateTime ?expire;
    String ?status;
    int ?customer;
    int ?merchant;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        customerName: json["customerName"],
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
