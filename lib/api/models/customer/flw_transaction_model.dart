// To parse this JSON data, do
//
//     final flwTransactionModel = flwTransactionModelFromJson(jsonString);

import 'dart:convert';

FlwTransactionModel flwTransactionModelFromJson(String str) =>
    FlwTransactionModel.fromJson(json.decode(str));

class FlwTransactionModel {
  FlwTransactionModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Datum>? data;

  factory FlwTransactionModel.fromJson(Map<String, dynamic> json) =>
      FlwTransactionModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    this.id,
    this.amount,
    this.dateCreated,
    this.flwRef,
    this.paymentMethod,
    this.status,
    this.owner,
  });

  String? id;
  String? amount;
  DateTime? dateCreated;
  String? flwRef;
  String? paymentMethod;
  String? status;
  int? owner;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        amount: json["amount"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        flwRef: json["flwRef"],
        paymentMethod: json["paymentMethod"],
        status: json["status"],
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "dateCreated": dateCreated?.toIso8601String(),
        "flwRef": flwRef,
        "paymentMethod": paymentMethod,
        "status": status,
        "owner": owner,
      };
}
