// To parse this JSON data, do
//
//     final staffProfileModel = staffProfileModelFromJson(jsonString);

import 'dart:convert';

StaffProfileModel staffProfileModelFromJson(String str) => StaffProfileModel.fromJson(json.decode(str));


class StaffProfileModel {
    StaffProfileModel({
        this.status,
        this.message,
        this.data,
    });

    int ?status;
    String? message;
    Data ?data;

    factory StaffProfileModel.fromJson(Map<String, dynamic> json) => StaffProfileModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );


}

class Data {
    Data({
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
