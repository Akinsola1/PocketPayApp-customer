// To parse this JSON data, do
//
//     final merchantGenerateQrcodeResponseModel = merchantGenerateQrcodeResponseModelFromJson(jsonString);

import 'dart:convert';

MerchantGenerateQrcodeResponseModel merchantGenerateQrcodeResponseModelFromJson(
        String str) =>
    MerchantGenerateQrcodeResponseModel.fromJson(json.decode(str));

class MerchantGenerateQrcodeResponseModel {
  MerchantGenerateQrcodeResponseModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory MerchantGenerateQrcodeResponseModel.fromJson(
          Map<String, dynamic> json) =>
      MerchantGenerateQrcodeResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.businessName,
    this.txRef,
  });

  String? businessName;
  String? txRef;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        businessName: json["businessName"],
        txRef: json["tx_ref"],
      );

  Map<String, dynamic> toJson() => {
        "businessName": businessName,
        "tx_ref": txRef,
      };
}
