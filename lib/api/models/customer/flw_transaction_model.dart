// To parse this JSON data, do
//
//     final flwTransactionModel = flwTransactionModelFromJson(jsonString);

import 'dart:convert';

FlwTransactionModel flwTransactionModelFromJson(String str) => FlwTransactionModel.fromJson(json.decode(str));

String flwTransactionModelToJson(FlwTransactionModel data) => json.encode(data.toJson());

class FlwTransactionModel {
    int? status;
    String? message;
    List<Datum>? data;

    FlwTransactionModel({
        this.status,
        this.message,
        this.data,
    });

    factory FlwTransactionModel.fromJson(Map<String, dynamic> json) => FlwTransactionModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? txRef;
    String? amount;
    String? accountNumber;
    String? bankName;
    String? bankOwner;
    DateTime? dateCreated;
    String? flwRef;
    String? paymentMethod;
    String? status;
    int? owner;

    Datum({
        this.txRef,
        this.amount,
        this.accountNumber,
        this.bankName,
        this.bankOwner,
        this.dateCreated,
        this.flwRef,
        this.paymentMethod,
        this.status,
        this.owner,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        txRef: json["txRef"],
        amount: json["amount"],
        accountNumber: json["accountNumber"],
        bankName: json["bankName"],
        bankOwner: json["bankOwner"],
        dateCreated: json["dateCreated"] == null ? null : DateTime.parse(json["dateCreated"]),
        flwRef: json["flwRef"],
        paymentMethod: json["paymentMethod"],
        status: json["status"],
        owner: json["owner"],
    );

    Map<String, dynamic> toJson() => {
        "txRef": txRef,
        "amount": amount,
        "accountNumber": accountNumber,
        "bankName": bankName,
        "bankOwner": bankOwner,
        "dateCreated": dateCreated?.toIso8601String(),
        "flwRef": flwRef,
        "paymentMethod": paymentMethod,
        "status": status,
        "owner": owner,
    };
}
