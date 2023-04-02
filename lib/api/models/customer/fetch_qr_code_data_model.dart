// To parse this JSON data, do
//
//     final fetchQrcodeDataModel = fetchQrcodeDataModelFromJson(jsonString);

import 'dart:convert';

FetchQrcodeDataModel fetchQrcodeDataModelFromJson(String str) => FetchQrcodeDataModel.fromJson(json.decode(str));

String fetchQrcodeDataModelToJson(FetchQrcodeDataModel data) => json.encode(data.toJson());

class FetchQrcodeDataModel {
    FetchQrcodeDataModel({
        this.status,
        this.message,
        this.data,
    });

    int ?status;
    String? message;
    Data ?data;

    factory FetchQrcodeDataModel.fromJson(Map<String, dynamic> json) => FetchQrcodeDataModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.merchantBusinessName,
        this.merchantBusinessLogo,
        this.amount,
        this.dateCreated,
    });

    String? merchantBusinessName;
    String? merchantBusinessLogo;
    String? amount;
    DateTime ?dateCreated;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        merchantBusinessName: json["merchantBusinessName"],
        merchantBusinessLogo: json["merchantBusinessLogo"],
        amount: json["amount"],
        dateCreated: DateTime.parse(json["dateCreated"]),
    );

    Map<String, dynamic> toJson() => {
        "merchantBusinessName": merchantBusinessName,
        "merchantBusinessLogo": merchantBusinessLogo,
        "amount": amount,
        "dateCreated": dateCreated?.toIso8601String(),
    };
}
