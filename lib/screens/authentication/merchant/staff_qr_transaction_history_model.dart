// To parse this JSON data, do
//
//     final staffQrCodeTransactionModel = staffQrCodeTransactionModelFromJson(jsonString);

import 'dart:convert';

StaffQrCodeTransactionModel staffQrCodeTransactionModelFromJson(String str) => StaffQrCodeTransactionModel.fromJson(json.decode(str));


class StaffQrCodeTransactionModel {
    StaffQrCodeTransactionModel({
        this.status,
        this.message,
        this.data,
    });

    int ?status;
    String? message;
    List<StaffTransactionDetail>? data;

    factory StaffQrCodeTransactionModel.fromJson(Map<String, dynamic> json) => StaffQrCodeTransactionModel(
        status: json["status"],
        message: json["message"],
        data: List<StaffTransactionDetail>.from(json["data"].map((x) => StaffTransactionDetail.fromJson(x))),
    );

}

class StaffTransactionDetail {
    StaffTransactionDetail({
        this.id,
        this.staffId,
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
    String? staffId;
    String? customerName;
    String? businessId;
    String? merchantBusinessName;
    String? merchantBusinessLogo;
    String? description;
    String? txRef;
    String? amount;
    DateTime ?dateCreated;
    DateTime ?expire;
    String? status;
    int? customer;
    int? merchant;

    factory StaffTransactionDetail.fromJson(Map<String, dynamic> json) => StaffTransactionDetail(
        id: json["id"],
        staffId: json["staffId"],
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
