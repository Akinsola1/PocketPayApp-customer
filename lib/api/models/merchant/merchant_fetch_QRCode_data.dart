// To parse this JSON data, do
//
//     final merchantFetchQRcodeDataModel = merchantFetchQRcodeDataModelFromJson(jsonString);

import 'dart:convert';

MerchantFetchQRcodeDataModel merchantFetchQRcodeDataModelFromJson(String str) => MerchantFetchQRcodeDataModel.fromJson(json.decode(str));


class MerchantFetchQRcodeDataModel {
    MerchantFetchQRcodeDataModel({
        this.status,
        this.message,
        this.data,
    });

    int ?status;
    String? message;
    Data ?data;

    factory MerchantFetchQRcodeDataModel.fromJson(Map<String, dynamic> json) => MerchantFetchQRcodeDataModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );


}

class Data {
    Data({
        this.customerName,
        this.amount,
        this.dateCreated,
    });

    String ?customerName;
    String ?amount;
    DateTime? dateCreated;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        customerName: json["customerName"],
        amount: json["amount"],
        dateCreated: DateTime.parse(json["dateCreated"]),
    );

}
