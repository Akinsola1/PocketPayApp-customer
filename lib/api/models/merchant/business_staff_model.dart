// To parse this JSON data, do
//
//     final businessStaffModel = businessStaffModelFromJson(jsonString);

import 'dart:convert';

BusinessStaffModel businessStaffModelFromJson(String str) => BusinessStaffModel.fromJson(json.decode(str));


class BusinessStaffModel {
    BusinessStaffModel({
        this.status,
        this.message,
        this.data,
    });

    int ?status;
    String? message;
    List<Datum>? data;

    factory BusinessStaffModel.fromJson(Map<String, dynamic> json) => BusinessStaffModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    
}

class Datum {
    Datum({
        this.id,
        this.staffId,
        this.firstName,
        this.otherNames,
        this.lastName,
        this.email,
        this.phone,
        this.profilePicture,
        this.merchantId,
        this.businessId,
        this.role,
        this.owner,
    });

    int? id;
    String? staffId;
    String? firstName;
    String? otherNames;
    String? lastName;
    String? email;
    String? phone;
    String? profilePicture;
    String? merchantId;
    String? businessId;
    String? role;
    int? owner;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        staffId: json["staffId"],
        firstName: json["firstName"],
        otherNames: json["otherNames"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        profilePicture: json["profilePicture"],
        merchantId: json["merchantId"],
        businessId: json["businessId"],
        role: json["role"],
        owner: json["owner"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "staffId": staffId,
        "firstName": firstName,
        "otherNames": otherNames,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "profilePicture": profilePicture,
        "merchantId": merchantId,
        "businessId": businessId,
        "role": role,
        "owner": owner,
    };
}
