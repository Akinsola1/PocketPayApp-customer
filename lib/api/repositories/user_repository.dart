import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:pocket_pay_app/api/api_utils/api_route.dart';
import 'package:pocket_pay_app/api/models/customer/fetch_qr_code_data_model.dart';
import 'package:pocket_pay_app/api/models/customer/flw_transaction_model.dart';
import 'package:pocket_pay_app/api/models/customer/generateQrCodeResponsemodel.dart';
import 'package:pocket_pay_app/api/models/customer/qr_code_transaction_model.dart';
import 'package:pocket_pay_app/api/models/customer/user_profile_model.dart';
import 'package:pocket_pay_app/api/responsiveState/base_view_model.dart';
import 'package:pocket_pay_app/api/responsiveState/view_state.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/validators.dart';
import '../api_utils/api_helper.dart';

class UserProvider extends BaseNotifier with Validators {
  Map<String, String> get header => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        //'Authorization': 'Bearer ${locator<UserInfoCache>().token}',
      };

  Future<Map<String, String>> headerWithToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;

    Map<String, String> headerToken = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    };
    return headerToken;
  }

  bool biometricEnabled = false;
  UserProfileModel userProfile = UserProfileModel();
  QRcodeTransactionModel qrCodeTransaction = QRcodeTransactionModel();
  GenerateQrcodeResponse generateQrcodeResponse = GenerateQrcodeResponse();
  FetchQrcodeDataModel fetchQrcodeDataModel = FetchQrcodeDataModel();
  FlwTransactionModel flwTransactionModel = FlwTransactionModel();

  checkBiometric() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool biometric = await prefs.getBool("biometricEnabled") ?? false;

    if (biometric) {
      biometricEnabled = true;
    } else {
      biometricEnabled = false;
    }
    notifyListeners();
  }

  toggleBiometric() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!biometricEnabled) {
      prefs.setBool("biometricEnabled", true);
      biometricEnabled = true;
    } else {
      prefs.setBool("biometricEnabled", false);
      biometricEnabled = false;
    }
    notifyListeners();
  }

  Future<bool> login({
    String? phone,
    String? password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(ViewState.Busy);
    try {
      Map val = {
        "phone": phone,
        "password": password,
      };
      var responsebody =
          await API().post(apiRoute.login, header, jsonEncode(val));
      var response = jsonDecode(responsebody);

      print(response["token"]);
      prefs.setString("token", response["token"]);
      print(responsebody);
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> signup({
    String? firstName,
    String? lastName,
    String? otherName,
    String? email,
    String? phone,
    String? password,
    String? profilePicture,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(ViewState.Busy);

    try {
      Map<String, dynamic> val = {
        "firstName": firstName,
        "lastName": lastName,
        "otherName": otherName,
        "email": email,
        "phone": phone,
        "password": password,
      };
    FormData formData;
      MultipartFile userPicture;
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, dynamic> noMediaReq = {}..addAll(val);

      if (profilePicture!.isNotEmpty) {
        userPicture = await MultipartFile.fromFile(
          profilePicture,
          filename: '$id/${profilePicture}',
        );
        formData =
            FormData.fromMap(val..addAll({"profilePicture": userPicture}));
        var responsebody = await API().post(
            apiRoute.signUp, header, noMediaReq,
            multimediaRequest: formData);

        var response = jsonDecode(responsebody);
        prefs.setString("token", response["token"]);
        print(responsebody);
        setState(ViewState.Idle);

        return true;
      } else {
        Map<String, dynamic> val = {
          "firstName": firstName,
          "lastName": lastName,
          "otherName": otherName,
          "email": email,
          "phone": phone,
          "password": password,
          "profilePicture": profilePicture,
        };
        var responsebody = await API().post(
          apiRoute.signUp,
          header,
          jsonEncode(val),
        );
        var response = jsonDecode(responsebody);
        prefs.setString("token", response["token"]);
        print(responsebody);
        setState(ViewState.Idle);
        return true;
      }
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> fetchCustomerProfile() async {
    setState(ViewState.Busy);

    try {
      var responsebody = await API()
          .get(apiRoute.fetchCustomerProfile, await headerWithToken());
      userProfile = userProfileModelFromJson(responsebody);
      log("user profile || $responsebody");
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> fetchQrCodeTransactions() async {
    setState(ViewState.Busy);

    try {
      var responsebody = await API()
          .get(apiRoute.fetchQRCodeTransaction, await headerWithToken());
      qrCodeTransaction = qRcodeTransactionModelFromJson(responsebody);
      log("fetch Qr Code Transactions || $responsebody");
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> setPin(String pin) async {
    setState(ViewState.Busy);

    try {
      Map val = {
        "pin": pin,
      };
      var responsebody = await API().post(
          apiRoute.saveCustomerPin, await headerWithToken(), jsonEncode(val));
      log("set customer pin|| $responsebody");
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> validateUserPin(String pin) async {
    setState(ViewState.Busy);

    try {
      Map val = {
        "pin": pin,
      };
      var responsebody = await API().post(apiRoute.validateCustomerPin,
          await headerWithToken(), jsonEncode(val));
      log("set customer pin|| $responsebody");
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> setContactDetails(String contactName, String contactPhone,
      String contactRelationship) async {
    setState(ViewState.Busy);
    try {
      Map val = {
        "contactPersonName": contactName,
        "contactPersonPhone": contactPhone,
        "contactPersonRelationship": contactRelationship,
      };
      var responsebody = await API().post(
          apiRoute.addContactDetails, await headerWithToken(), jsonEncode(val));
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> generateQrCode(String amount, String description) async {
    setState(ViewState.Busy);

    try {
      Map val = {
        "amount": amount,
        "description": description,
      };
      var responsebody = await API().post(
          apiRoute.generateQRCode, await headerWithToken(), jsonEncode(val));
      generateQrcodeResponse = generateQrcodeResponseFromJson(responsebody);
      log("generate qr code || $responsebody");
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> fetchQrCodeData(String tx_ref) async {
    log("${tx_ref}");
    setState(ViewState.Busy);
    try {
      Map val = {
        "tx_ref": tx_ref,
      };
      var responsebody = await API().post(
          apiRoute.fetchQrCodeData, await headerWithToken(), jsonEncode(val));
      fetchQrcodeDataModel = fetchQrcodeDataModelFromJson(responsebody);
      log("fetch qr code data || $responsebody");
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> completeScanQrCode(String tx_ref) async {
    setState(ViewState.Busy);
    try {
      Map val = {
        "tx_ref": tx_ref,
      };
      var responsebody = await API().post(apiRoute.scanMerchantQrCode,
          await headerWithToken(), jsonEncode(val));
      log("complete scan merchant qr code || $responsebody");
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> fundWallet(String amount) async {
    setState(ViewState.Busy);
    try {
      Map val = {
        "amount": amount,
      };
      var responsebody = await API().post(
          apiRoute.tempFundingMethod, await headerWithToken(), jsonEncode(val));
      log("fund wallet || $responsebody");
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> fetchFlwTransactions() async {
    setState(ViewState.Busy);
    try {
      var responsebody = await API()
          .get(apiRoute.fetchFlwTransactions, await headerWithToken());
      flwTransactionModel = flwTransactionModelFromJson(responsebody);
      log("flw transactions || $responsebody");
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  displayError({required String title, required String message}) {
    getx.Get.showSnackbar(
      getx.GetSnackBar(
        title: title,
        message: message,
        duration: const Duration(seconds: 3),
        backgroundColor: appPrimaryColor,
      ),
    );
  }
}
