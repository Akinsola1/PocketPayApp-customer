// To parse this JSON data, do
//
//     final merchantProfileModel = merchantProfileModelFromJson(jsonString);

import 'dart:convert';

MerchantProfileModel merchantProfileModelFromJson(String str) =>
    MerchantProfileModel.fromJson(json.decode(str));

class MerchantProfileModel {
  MerchantProfileModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory MerchantProfileModel.fromJson(Map<String, dynamic> json) =>
      MerchantProfileModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.id,
    this.firstName,
    this.otherNames,
    this.lastName,
    this.merchantId,
    this.nin,
    this.bvn,
    this.email,
    this.phone,
    this.profilePicture,
    this.walletBalance,
    this.pin,
    this.secretQuestion,
    this.secretAnswer,
    this.contactPersonName,
    this.contactPersonPhone,
    this.contactPersonRelationship,
    this.phoneVerified,
    this.setPin,
    this.addBank,
    this.contactPersonAdded,
    this.kycVerified,
    this.owner,
  });

  int? id;
  String? firstName;
  String? otherNames;
  String? lastName;
  String? merchantId;
  String? nin;
  String? bvn;
  String? email;
  String? phone;
  String? profilePicture;
  String? walletBalance;
  String? pin;
  String? secretQuestion;
  String? secretAnswer;
  String? contactPersonName;
  String? contactPersonPhone;
  String? contactPersonRelationship;
  bool? setPin;
  bool? phoneVerified;
  bool? addBank;
  bool? contactPersonAdded;
  bool? kycVerified;
  int? owner;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["firstName"],
        otherNames: json["otherNames"],
        lastName: json["lastName"],
        merchantId: json["merchantId"],

        nin: json["nin"],
        bvn: json["bvn"],
        email: json["email"],
        phone: json["phone"],
        profilePicture: json["profilePicture"],
        walletBalance: json["walletBalance"],
        pin: json["pin"],
        secretQuestion: json["secretQuestion"],
        secretAnswer: json["secretAnswer"],
        contactPersonName: json["contactPersonName"],
        contactPersonPhone: json["contactPersonPhone"],
        contactPersonRelationship: json["contactPersonRelationship"],
        setPin: json["setPin"],
        addBank: json["addBank"],
        phoneVerified: json["phoneVerified"],
        contactPersonAdded: json["contactPersonAdded"],
        kycVerified: json["kycVerified"],
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "otherNames": otherNames,
        "lastName": lastName,
        "nin": nin,
        "bvn": bvn,
        "email": email,
        "phone": phone,
        "profilePicture": profilePicture,
        "walletBalance": walletBalance,
        "pin": pin,
        "secretQuestion": secretQuestion,
        "secretAnswer": secretAnswer,
        "contactPersonName": contactPersonName,
        "contactPersonPhone": contactPersonPhone,
        "contactPersonRelationship": contactPersonRelationship,
        "setPin": setPin,
        "addBank": addBank,
        "contactPersonAdded": contactPersonAdded,
        "kycVerified": kycVerified,
        "owner": owner,
      };
}
