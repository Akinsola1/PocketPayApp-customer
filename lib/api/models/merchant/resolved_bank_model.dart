// To parse this JSON data, do
//
//     final resolvedBankModel = resolvedBankModelFromJson(jsonString);

import 'dart:convert';

ResolvedBankModel resolvedBankModelFromJson(String str) => ResolvedBankModel.fromJson(json.decode(str));


class ResolvedBankModel {
    ResolvedBankModel({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    Data? data;

    factory ResolvedBankModel.fromJson(Map<String, dynamic> json) => ResolvedBankModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

}

class Data {
    Data({
        this.accountNumber,
        this.accountName,
    });

    String? accountNumber;
    String? accountName;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        accountNumber: json["account_number"],
        accountName: json["account_name"],
    );

  
}
