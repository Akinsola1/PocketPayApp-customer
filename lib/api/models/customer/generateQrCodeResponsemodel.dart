// To parse this JSON data, do
//
//     final generateQrcodeResponse = generateQrcodeResponseFromJson(jsonString);

import 'dart:convert';

GenerateQrcodeResponse generateQrcodeResponseFromJson(String str) =>
    GenerateQrcodeResponse.fromJson(json.decode(str));

class GenerateQrcodeResponse {
  GenerateQrcodeResponse({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory GenerateQrcodeResponse.fromJson(Map<String, dynamic> json) =>
      GenerateQrcodeResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.txRef,
  });

  String? txRef;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        txRef: json["tx_ref"],
      );

  Map<String, dynamic> toJson() => {
        "tx_ref": txRef,
      };
}
