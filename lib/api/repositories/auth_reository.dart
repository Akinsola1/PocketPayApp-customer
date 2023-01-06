import 'dart:convert';

import 'package:get/get.dart';
import 'package:pocket_pay_app/api/api_utils/api_route.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';

import '../../utils/validators.dart';
import '../api_utils/api_helper.dart';

class authRepository extends GetxController with StateMixin, Validators {
  Map<String, String> get header => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        //'Authorization': 'Bearer ${locator<UserInfoCache>().token}',
      };

  Map<String, String> get headerAuth => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Token d8abe442d1e7827f0007c616b4f5e739bc8c884a',
      };

  var loading = false.obs;


  Future<bool> login({
    String? phone,
    String? password,
  }) async {
    loading.value = true;

    try {
      Map val = {
        "phone": phone,
        "password": password,
      };
      var responsebody =
          await API().post(apiRoute.login, header, jsonEncode(val));
      // ApiResponse response = ApiResponse.fromJson(responsebody);
      print(responsebody);
      loading.value = false;
      return true;
    } catch (e) {
      displayError(title: "Error", message: e.toString());
      print(e);
      loading.value = false;
      return false;
    }
  }


  displayError({required String title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        duration: const Duration(seconds: 3),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}