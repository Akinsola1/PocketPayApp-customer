// To parse this JSON data, do
//
//     final fundWalletBankTransferModel = fundWalletBankTransferModelFromJson(jsonString);

import 'dart:convert';

FundWalletBankTransferModel fundWalletBankTransferModelFromJson(String str) => FundWalletBankTransferModel.fromJson(json.decode(str));


class FundWalletBankTransferModel {
    FundWalletBankTransferModel({
        this.status,
        this.message,
        this.response,
    });

    int ?status;
    String? message;
    Response? response;

    factory FundWalletBankTransferModel.fromJson(Map<String, dynamic> json) => FundWalletBankTransferModel(
        status: json["status"],
        message: json["message"],
        response: Response.fromJson(json["response"]),
    );

  
}

class Response {
    Response({
        this.status,
        this.message,
        this.meta,
    });

    String? status;
    String? message;
    Meta?  meta;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        status: json["status"],
        message: json["message"],
        meta: Meta.fromJson(json["meta"]),
    );

    
}

class Meta {
    Meta({
        this.authorization,
    });

    Authorization? authorization;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        authorization: Authorization.fromJson(json["authorization"]),
    );

  
}

class Authorization {
    Authorization({
        this.transferReference,
        this.transferAccount,
        this.transferBank,
        this.accountExpiration,
        this.transferNote,
        this.transferAmount,
        this.mode,
    });

    String? transferReference;
    String? transferAccount;
    String? transferBank;
    int ?accountExpiration;
    String? transferNote;
    String? transferAmount;
    String? mode;

    factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
        transferReference: json["transfer_reference"],
        transferAccount: json["transfer_account"],
        transferBank: json["transfer_bank"],
        accountExpiration: json["account_expiration"],
        transferNote: json["transfer_note"],
        transferAmount: json["transfer_amount"],
        mode: json["mode"],
    );

    Map<String, dynamic> toJson() => {
        "transfer_reference": transferReference,
        "transfer_account": transferAccount,
        "transfer_bank": transferBank,
        "account_expiration": accountExpiration,
        "transfer_note": transferNote,
        "transfer_amount": transferAmount,
        "mode": mode,
    };
}
