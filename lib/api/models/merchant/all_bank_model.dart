// To parse this JSON data, do
//
//     final allBankModel = allBankModelFromJson(jsonString);

import 'dart:convert';

List<AllBankModel> allBankModelFromJson(String str) => List<AllBankModel>.from(
    json.decode(str).map((x) => AllBankModel.fromJson(x)));

String allBankModelToJson(List<AllBankModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllBankModel {
  AllBankModel({this.id, this.code, this.name});

  int? id;
  String? code;
  String? name;

  factory AllBankModel.fromJson(Map<String, dynamic> json) => AllBankModel(
        id: json["id"],
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
      };
}
