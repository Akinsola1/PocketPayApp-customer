// To parse this JSON data, do
//
//     final merchantBusinessModel = merchantBusinessModelFromJson(jsonString);

import 'dart:convert';

MerchantBusinessModel merchantBusinessModelFromJson(String str) => MerchantBusinessModel.fromJson(json.decode(str));


class MerchantBusinessModel {
    MerchantBusinessModel({
        this.status,
        this.message,
        this.data,
    });

    int?  status;
    String? message;
    List<Datum>? data;

    factory MerchantBusinessModel.fromJson(Map<String, dynamic> json) => MerchantBusinessModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

   
}

class Datum {
    Datum({
        this.id,
        this.businessCeoName,
        this.businessName,
        this.businessEmail,
        this.businessPhone,
        this.businessLogo,
        this.businessRegNumber,
        this.businessDescription,
        this.businessWalletBalance,
        this.owner,
        this.businessId
    });

    int? id;
    String? businessCeoName;
    String? businessId;

    String? businessName;
    String? businessEmail;
    String? businessPhone;
    String? businessLogo;
    String? businessRegNumber;
    String? businessDescription;
    String? businessWalletBalance;
    int? owner;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        businessCeoName: json["businessCeoName"],
        businessId: json["businessId"],

        businessName: json["businessName"],
        businessEmail: json["businessEmail"],
        businessPhone: json["businessPhone"],
        businessLogo: json["businessLogo"],
        businessRegNumber: json["businessRegNumber"],
        businessDescription: json["businessDescription"],
        businessWalletBalance: json["businessWalletBalance"],
        owner: json["owner"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "businessCeoName": businessCeoName,
        "businessName": businessName,
        "businessEmail": businessEmail,
        "businessPhone": businessPhone,
        "businessLogo": businessLogo,
        "businessRegNumber": businessRegNumber,
        "businessDescription": businessDescription,
        "businessWalletBalance": businessWalletBalance,
        "owner": owner,
    };
}
