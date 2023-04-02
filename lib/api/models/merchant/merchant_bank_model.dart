// To parse this JSON data, do
//
//     final merchantBanksModel = merchantBanksModelFromJson(jsonString);

import 'dart:convert';

MerchantBanksModel merchantBanksModelFromJson(String str) => MerchantBanksModel.fromJson(json.decode(str));


class MerchantBanksModel {
    MerchantBanksModel({
        this.status,
        this.message,
        this.data,
    });

    int? status;
    String? message;
    List<Datum> ?data;

    factory MerchantBanksModel.fromJson(Map<String, dynamic> json) => MerchantBanksModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

}

class Datum {
    Datum({
        this.id,
        this.bankName,
        this.bankCode,
        this.accNum,
        this.accName,
        this.owner,
    });

    int? id;
    String? bankName;
    String? bankCode;
    String? accNum;
    String? accName;
    int? owner;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        bankName: json["bankName"],
        bankCode: json["bankCode"],
        accNum: json["accNum"],
        accName: json["accName"],
        owner: json["owner"],
    );

  
}
