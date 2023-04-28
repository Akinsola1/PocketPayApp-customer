import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:intl/intl.dart';
import 'package:pocket_pay_app/api/api_utils/api_route.dart';
import 'package:pocket_pay_app/api/models/merchant/all_bank_model.dart';
import 'package:pocket_pay_app/api/models/merchant/business_staff_model.dart';
import 'package:pocket_pay_app/api/models/merchant/merchant_bank_model.dart';
import 'package:pocket_pay_app/api/models/merchant/merchant_business_model.dart';
import 'package:pocket_pay_app/api/models/merchant/merchant_fetch_QRCode_data.dart';
import 'package:pocket_pay_app/api/models/merchant/merchant_generate_qrcode_res_model.dart';
import 'package:pocket_pay_app/api/models/merchant/merchant_profile_model.dart';
import 'package:pocket_pay_app/api/models/merchant/merchant_qr_code_histoty_model.dart';
import 'package:pocket_pay_app/api/models/merchant/resolved_bank_model.dart';
import 'package:pocket_pay_app/api/models/staff/staff_profile_model.dart';
import 'package:pocket_pay_app/api/responsiveState/base_view_model.dart';
import 'package:pocket_pay_app/constant/colors.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/staff_qr_transaction_history_model.dart';
import 'package:pocket_pay_app/screens/merchant/business/merchant_business_screen.dart';
import 'package:pocket_pay_app/services/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/merchant/business/business_analytics_screen.dart';
import '../../utils/validators.dart';
import '../api_utils/api_helper.dart';
import '../models/customer/flw_transaction_model.dart';
import '../responsiveState/view_state.dart';

class MerchantProvider extends BaseNotifier with Validators {
  Map<String, String> get header => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        //'Authorization': 'Bearer ${locator<UserInfoCache>().token}',
      };

  Future<Map<String, String>> headerWithToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("Mtoken")!;

    Map<String, String> headerToken = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    };
    return headerToken;
  }

  Future<Map<String, String>> headerWithToken1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("SToken")!;

    Map<String, String> headerToken = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    };
    return headerToken;
  }

  MerchantProfileModel merchantProfileModel = MerchantProfileModel();
  MerchantBusinessModel merchantBusinessModel = MerchantBusinessModel();
  MerchantQrcodeHistory merchantQrcodeHistory = MerchantQrcodeHistory();
  MerchantQrcodeHistory businessQrCodeHistory = MerchantQrcodeHistory();
  ResolvedBankModel resolvedBankModel = ResolvedBankModel();
  FlwTransactionModel flwTransactionModel = FlwTransactionModel();
  MerchantBanksModel merchantBanksModel = MerchantBanksModel();
  StaffProfileModel staffProfileModel = StaffProfileModel();
  BusinessStaffModel businessStaffModel = BusinessStaffModel();

  StaffQrCodeTransactionModel staffQrCodeTransactionModel =
      StaffQrCodeTransactionModel();

  List<AllBankModel> allBankModel = [];
  List<BusinessData> businessDataList = [];
  List<BusinessSalesData> individualBusinessData = [];

  MerchantFetchQRcodeDataModel merchantFetchQrCodeData =
      MerchantFetchQRcodeDataModel();

  MerchantGenerateQrcodeResponseModel merchantGenerateQrcodeResponseModel =
      MerchantGenerateQrcodeResponseModel();

  String tempNinPicture = "";
  // String? driverImageFilePath;
  File? driverImage = null;

  AllBankModel selectedBank = AllBankModel();
  String accountOwner = "";
  bool merchantBiometricEnabled = false;

  setBank(AllBankModel bank) {
    selectedBank = bank;
    notifyListeners();
  }

  setResolvedBank() {
    accountOwner = resolvedBankModel.data!.accountName!;
    notifyListeners();
  }

  clearBank() {
    accountOwner = "";
    selectedBank = AllBankModel();
    notifyListeners();
  }

  setImage(File selectedImage) {
    driverImage = File(selectedImage.path);
    tempNinPicture = selectedImage.path;
    notifyListeners();
  }

  clearImage() {
    driverImage = null;
    tempNinPicture = "";
    notifyListeners();
  }

  toggleBiometric() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!merchantBiometricEnabled) {
      prefs.setBool("merchantBiometricEnabled", true);
      merchantBiometricEnabled = true;
    } else {
      prefs.setBool("merchantBiometricEnabled", false);
      merchantBiometricEnabled = false;
    }
    notifyListeners();
  }

  sortBusinessData() {
    businessDataList.clear();
    for (var i = 0; i < merchantBusinessModel.data!.length; i++) {
      businessDataList.insert(
          0,
          BusinessData(
              "${merchantBusinessModel.data?.elementAt(i).businessName}",
              double.tryParse(
                  "${merchantBusinessModel.data?.elementAt(i).businessWalletBalance}")!));
    }
  }

  sortBusinessDataToday() {
    individualBusinessData.clear();
    for (var i = 0; i < businessQrCodeHistory.data!.length; i++) {
      individualBusinessData.insert(
          0,
          BusinessSalesData(
              // "${businessQrCodeHistory.data?.elementAt(i).dateCreated}",
              DateTime.parse(
                  "${businessQrCodeHistory.data?.elementAt(i).dateCreated}"),
              double.tryParse(
                  "${businessQrCodeHistory.data?.elementAt(i).amount}")!));
    }
    log("${individualBusinessData.length}");
  }

  Future<bool> merchantLogin({
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
          await API().post(apiRoute.merchantLogin, header, jsonEncode(val));
      var response = jsonDecode(responsebody);

      print(response["token"]);
      prefs.setString("Mtoken", response["token"]);
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

  Future<bool> merchantSignup({
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
            apiRoute.merchantSignUp, header, noMediaReq,
            multimediaRequest: formData);

        var response = jsonDecode(responsebody);
        prefs.setString("Mtoken", response["token"]);
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
          apiRoute.merchantSignUp,
          header,
          jsonEncode(val),
        );
        var response = jsonDecode(responsebody);
        prefs.setString("Mtoken", response["token"]);
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

  Future<bool> createBusinessProfile({
    String? businessName,
    String? businessDescription,
    String? businessEmail,
    String? businessPhone,
    String? businessRegNo,
    String? businessLogo,
  }) async {
    setState(ViewState.Busy);

    try {
      Map<String, dynamic> val = {
        "businessName": businessName,
        "businessEmail": businessEmail,
        "businessPhone": businessPhone,
        "businessRegNumber": businessRegNo,
        "businessDescription": businessDescription,
      };
      FormData formData;
      MultipartFile businessImage;
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, dynamic> noMediaReq = {}..addAll(val);

      if (businessLogo!.isNotEmpty) {
        businessImage = await MultipartFile.fromFile(
          businessLogo,
          filename: '$id/$businessLogo',
        );
        formData =
            FormData.fromMap(val..addAll({"businessLogo": businessImage}));
        var responsebody = await API().post(
            apiRoute.merchantCreateBusinessProfile,
            await headerWithToken(),
            noMediaReq,
            multimediaRequest: formData);

        var response = jsonDecode(responsebody);
        print(responsebody);
        setState(ViewState.Idle);

        return true;
      } else {
        Map<String, dynamic> val = {
          "businessName": businessName,
          "businessEmail": businessEmail,
          "businessPhone": businessPhone,
          "businessRegNumber": businessRegNo,
          "businessDescription": businessDescription,
          "businessLogo": businessLogo,
        };
        var responsebody = await API().post(
          apiRoute.merchantCreateBusinessProfile,
          await headerWithToken(),
          jsonEncode(val),
        );
        var response = jsonDecode(responsebody);
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

  Future<bool> fetchMerchantProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(ViewState.Busy);

    try {
      var responsebody = await API()
          .get(apiRoute.fetchMerchantProfile, await headerWithToken());

      merchantProfileModel = merchantProfileModelFromJson(responsebody);
      // ApiResponse response = ApiResponse.fromJson(responsebody);
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

  Future<bool> fetchMerchantBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(ViewState.Busy);

    try {
      var responsebody = await API()
          .get(apiRoute.fetchMerchantBusiness, await headerWithToken());
      merchantBusinessModel = merchantBusinessModelFromJson(responsebody);
      sortBusinessData();

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

  Future<bool> fetchMerchantQrCodeTransaction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(ViewState.Busy);

    try {
      var responsebody = await API().get(
          apiRoute.fetchMerchantQrCodeTransaction, await headerWithToken());
      merchantQrcodeHistory = merchantQrcodeHistoryFromJson(responsebody);
      // ApiResponse response = ApiResponse.fromJson(responsebody);
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

  Future<bool> generateQrCode(
      String amount, String description, String businessId) async {
    setState(ViewState.Busy);

    try {
      Map val = {
        "amount": amount,
        "description": description,
        "businessId": businessId,
      };
      var responsebody = await API().post(apiRoute.merchantGenerateQrCode,
          await headerWithToken(), jsonEncode(val));
      merchantGenerateQrcodeResponseModel =
          merchantGenerateQrcodeResponseModelFromJson(responsebody);
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

  Future<bool> fetchBusinessQrCodeTransaction(String businessId) async {
    setState(ViewState.Busy);

    try {
      var responsebody = await API().get(
          "${apiRoute.fetchBusinessQrCodeTransaction}/$businessId",
          await headerWithToken());
      businessQrCodeHistory = merchantQrcodeHistoryFromJson(responsebody);
      sortBusinessDataToday();
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
      var responsebody = await API().post(apiRoute.merchantFetchQrCodeData,
          await headerWithToken(), jsonEncode(val));
      merchantFetchQrCodeData =
          merchantFetchQRcodeDataModelFromJson(responsebody);
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

  Future<bool> completeScanQrCode(String tx_ref, String businessId) async {
    setState(ViewState.Busy);
    try {
      Map val = {"tx_ref": tx_ref, "businessId": businessId};
      var responsebody = await API().post(apiRoute.merchantScanQrCode,
          await headerWithToken(), jsonEncode(val));
      log("complete scan customer qr code || $responsebody");
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> createMerchantPin(String pin) async {
    setState(ViewState.Busy);
    try {
      Map val = {
        "pin": pin,
      };
      var responsebody = await API().post(
          apiRoute.createMerchantPin, await headerWithToken(), jsonEncode(val));
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> setMerchantContact(String contactName, String contactPhone,
      String contactRelationship) async {
    setState(ViewState.Busy);
    try {
      Map val = {
        "contactPersonName": contactName,
        "contactPersonPhone": contactPhone,
        "contactPersonRelationship": contactRelationship,
      };
      var responsebody = await API().post(
          apiRoute.setMerchantContactInformation,
          await headerWithToken(),
          jsonEncode(val));
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> verifyBank(String accountNum, String bankCode) async {
    setState(ViewState.Busy);
    try {
      Map val = {
        "bankCode": bankCode,
        "accountNum": accountNum,
      };
      log("$val");
      var responsebody = await API().post(apiRoute.merchantVerifyBank,
          await headerWithToken(), jsonEncode(val));
      resolvedBankModel = resolvedBankModelFromJson(responsebody);
      setResolvedBank();
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> fetchBanks() async {
    setState(ViewState.Busy);
    try {
      var responsebody = await API().get(
        apiRoute.fetchAllBank,
        await headerWithToken(),
      );
      allBankModel = allBankModelFromJson(responsebody);

      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> addBank(String accountNum, String bankCode, String accountName,
      String bankName) async {
    setState(ViewState.Busy);
    try {
      Map val = {
        "bankCode": bankCode,
        "accountNum": accountNum,
        "accountName": accountName,
        'bankName': bankName
      };
      var responsebody = await API().post(
          apiRoute.merchantAddBank, await headerWithToken(), jsonEncode(val));
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> setMerchantNin(String nin, String ninImage) async {
    setState(ViewState.Busy);
    try {
      Map<String, dynamic> val = {
        "nin": pin,
      };
      FormData formData;
      MultipartFile ninPicture;
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, dynamic> noMediaReq = {}..addAll(val);

      ninPicture = await MultipartFile.fromFile(
        ninImage,
        filename: '$id/$ninImage',
      );
      formData = FormData.fromMap(val..addAll({"ninImage": ninPicture}));
      var responsebody = await API().post(
          apiRoute.setMerchantSetNin, await headerWithToken(), noMediaReq,
          multimediaRequest: formData);

      var response = jsonDecode(responsebody);
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

  Future<bool> tempWithdrawMethod(
      String amount, String accountNum, String bankCode) async {
    setState(ViewState.Busy);
    Map val = {
      "amount": amount,
      "bankCode": bankCode,
      "accountNumber": accountNum
    };
    log(val.toString());
    try {
      var responsebody = await API().post(
          apiRoute.merchantWithdraw, await headerWithToken(), jsonEncode(val));

      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> fetchMerchantFlwTransactions() async {
    setState(ViewState.Busy);
    try {
      var responsebody = await API()
          .get(apiRoute.merchantFlwTransactions, await headerWithToken());
      flwTransactionModel = flwTransactionModelFromJson(responsebody);

      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> validateMerchantPIN(String pin) async {
    setState(ViewState.Busy);
    Map val = {"pin": pin};

    try {
      var responsebody = await API().post(apiRoute.validateMerchantPin,
          await headerWithToken(), jsonEncode(val));

      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> fetchMerchantBank() async {
    setState(ViewState.Busy);

    try {
      var responsebody =
          await API().get(apiRoute.fetchMerchantBank, await headerWithToken());
      merchantBanksModel = merchantBanksModelFromJson(responsebody);

      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> sendOTP() async {
    setState(ViewState.Busy);
    Map val = {"phone": merchantProfileModel.data?.phone};

    try {
      var responsebody = await API()
          .post(apiRoute.sendOTP, await headerWithToken(), jsonEncode(val));

      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> validateOTP(String OTP) async {
    setState(ViewState.Busy);
    Map val = {"phone": merchantProfileModel.data?.phone, "OTP": OTP};

    try {
      var responsebody = await API()
          .post(apiRoute.validateOTP, await headerWithToken(), jsonEncode(val));

      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  // staff

  Future<bool> fetchBusinessStaffs({String? businessId}) async {
    setState(ViewState.Busy);

    try {
      var responsebody = await API().get(
          "${apiRoute.fetchMerchantStaffs}/$businessId",
          await headerWithToken());
      print(responsebody);
      businessStaffModel = businessStaffModelFromJson(responsebody);
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> staffLogin({
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
          await API().post(apiRoute.staffLogin, header, jsonEncode(val));
      var response = jsonDecode(responsebody);
      localStorage.setString("SToken", response["token"]);
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

  Future<bool> fetchStaffProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(ViewState.Busy);
    try {
      var responsebody =
          await API().get(apiRoute.fetchStaffProfile, await headerWithToken1());
      staffProfileModel = staffProfileModelFromJson(responsebody);
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

  Future<bool> staffGenerateQrCode({
    String? amount,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(ViewState.Busy);
    try {
      Map val = {
        "amount": amount,
        "businessId": staffProfileModel.data!.businessId,
        "merchantId": staffProfileModel.data!.merchantId,
        "staffId": staffProfileModel.data!.staffId,
      };

      var responsebody = await API().post(apiRoute.staffGenerateQrCode,
          await headerWithToken1(), jsonEncode(val));
      var response = jsonDecode(responsebody);

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

  Future<bool> staffScanQrCOde(String tx_ref) async {
    setState(ViewState.Busy);
    try {
      Map val = {
        "tx_ref": tx_ref,
      };
      var responsebody = await API().post(
          apiRoute.staffScanQrCode, await headerWithToken1(), jsonEncode(val));
      log("complete scan customer qr code || $responsebody");
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> fetchStaffQrCodeHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log("${staffProfileModel.data?.staffId}");
    setState(ViewState.Busy);
    try {
      var responsebody = await API().get(
          "${apiRoute.fetchStaffQrCodeHistory}/${staffProfileModel.data?.staffId}",
          await headerWithToken1());

      staffQrCodeTransactionModel =
          staffQrCodeTransactionModelFromJson(responsebody);

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

  Future<bool> registerStaff({
    String? firstName,
    String? lastName,
    String? otherName,
    String? email,
    String? phone,
    String? businessId,
    String? profilePicture,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(ViewState.Busy);

    try {
      if (profilePicture!.isNotEmpty) {
        Map<String, dynamic> val = {
          "firstName": firstName,
          "lastName": lastName,
          "otherName": otherName,
          "email": email,
          "phone": phone,
          "businessId": businessId,
          "merchantId": merchantProfileModel.data?.merchantId
        };

        log("${val}");
        FormData formData;
        MultipartFile userPicture;
        String id = DateTime.now().millisecondsSinceEpoch.toString();
        Map<String, dynamic> noMediaReq = {}..addAll(val);
        userPicture = await MultipartFile.fromFile(
          profilePicture,
          filename: '$id/${profilePicture}',
        );
        formData =
            FormData.fromMap(val..addAll({"profilePicture": userPicture}));
        var responsebody = await API().post(
            apiRoute.registerStaff, await headerWithToken(), noMediaReq,
            multimediaRequest: formData);

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
          "businessId": businessId,
          "merchantId": merchantProfileModel.data?.merchantId,
          "profilePicture": profilePicture,
        };
        log("${val}");

        var responsebody = await API().post(
          apiRoute.registerStaff,
          await headerWithToken(),
          jsonEncode(val),
        );

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
