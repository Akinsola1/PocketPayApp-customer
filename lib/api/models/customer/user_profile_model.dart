// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    UserProfileModel({
        this.status,
        this.message,
        this.data,
    });

    int? status;
    String ?message;
    Data ?data;

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
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
        this.id,
        this.firstName,
        this.otherName,
        this.lastName,
        this.nin,
        this.bvn,
        this.email,
        this.phone,
        this.gender,
        this.walletBalance,
        this.pin,
        this.contactPersonName,
        this.contactPersonPhone,
        this.contactPersonRelationship,
        this.setPin,
        this.setBiometric,
        this.addCard,
        this.setContactDetails,
        this.setKycDocument,
        this.kycVerified,
        this.owner,
        this.profilePicture
    });

    int? id;
    String? firstName;
    String? otherName;
    String? lastName;
    String? nin;
    String? bvn;
    String? email;
    String? phone;
    String? gender;
    String? profilePicture;
    String? walletBalance;
    String? pin;
    String? contactPersonName;
    String? contactPersonPhone;
    String? contactPersonRelationship;
    bool? setPin;
    bool? setBiometric;
    bool? addCard;
    bool? setContactDetails;
    bool? setKycDocument;
    bool? kycVerified;
    int ? owner;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["firstName"],
        otherName: json["otherName"],
        lastName: json["lastName"],
        nin: json["nin"],
        bvn: json["bvn"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        profilePicture: json["profilePicture"],

        walletBalance: json["walletBalance"],
        pin: json["pin"],
        contactPersonName: json["contactPersonName"],
        contactPersonPhone: json["contactPersonPhone"],
        contactPersonRelationship: json["contactPersonRelationship"],
        setPin: json["setPin"],
        setBiometric: json["setBiometric"],
        addCard: json["addCard"],
        setContactDetails: json["setContactDetails"],
        setKycDocument: json["setKycDocument"],
        kycVerified: json["kycVerified"],
        owner: json["owner"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "otherName": otherName,
        "lastName": lastName,
        "nin": nin,
        "bvn": bvn,
        "email": email,
        "phone": phone,
        "gender": gender,
        "walletBalance": walletBalance,
        "pin": pin,
        "contactPersonName": contactPersonName,
        "contactPersonPhone": contactPersonPhone,
        "contactPersonRelationship": contactPersonRelationship,
        "setPin": setPin,
        "setBiometric": setBiometric,
        "addCard": addCard,
        "setContactDetails": setContactDetails,
        "setKycDocument": setKycDocument,
        "kycVerified": kycVerified,
        "owner": owner,
    };
}
