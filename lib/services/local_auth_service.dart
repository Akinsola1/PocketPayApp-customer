import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuth {
  static final auth = LocalAuthentication();
  // SharedPreferences prefs = SharedPreferences.getInstance();

  static Future<bool> _canAuthenticate() async =>
      await auth.canCheckBiometrics || await auth.isDeviceSupported();

  static Future<bool> authenticate({String? accountType}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool biometricEnabled = prefs.getBool("biometricEnabled") ?? false;
    bool merchantBiometricEnabled =
        prefs.getBool("merchantBiometricEnabled") ?? false;

    log("user$biometricEnabled merchant$merchantBiometricEnabled");

    if (accountType == "customer") {
      try {
        if (!await _canAuthenticate() || !biometricEnabled) {
          Get.defaultDialog(
              title: "Biometric",
              titlePadding: const EdgeInsets.only(top: 20),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              backgroundColor: Colors.white,
              titleStyle: txStyle20,
              barrierDismissible: true,
              confirm: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () async {
                    Get.back();
                  },
                  child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      color: appPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      "Ok",
                      style: txStyle14wt,
                    )),
                  ),
                ),
              ),
              radius: 6,
              content: Column(
                children: [
                  Text(
                    "No biometric data found!! Please login with your phone number and password then enable biometric",
                    textAlign: TextAlign.center,
                    style: txStyle14.copyWith(height: 1.5),
                  )
                ],
              ));

          return false;
        }

        return await auth.authenticate(
            options: const AuthenticationOptions(
                useErrorDialogs: true, stickyAuth: true),
            localizedReason: "Use Biometric to proceed");
      } catch (e) {
        log('erroe $e');
        return false;
      }
    } else {
      try {
        if (!await _canAuthenticate() || !merchantBiometricEnabled) {
          Get.defaultDialog(
              title: "Biometric",
              titlePadding: const EdgeInsets.only(top: 20),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              backgroundColor: Colors.white,
              titleStyle: txStyle20,
              barrierDismissible: true,
              confirm: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () async {
                    Get.back();
                  },
                  child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      color: appPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      "Ok",
                      style: txStyle14wt,
                    )),
                  ),
                ),
              ),
              radius: 6,
              content: Column(
                children: [
                  Text(
                    "No biometric data found!! Please login with your phone number and password then enable biometric in profile screen",
                    textAlign: TextAlign.center,
                    style: txStyle14.copyWith(height: 1.5),
                  )
                ],
              ));

          return false;
        }

        return await auth.authenticate(
            options: const AuthenticationOptions(
                useErrorDialogs: true, stickyAuth: true),
            localizedReason: "Use Biometric to proceed");
      } catch (e) {
        log('erroe $e');
        return false;
      }
    }
  }
}
