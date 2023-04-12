import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/authentication/customer/login_screen.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_decision_screen.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_login_screen.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/staff_login_screen.dart';
import 'package:pocket_pay_app/screens/onboarding/signup_decision_screen.dart';
import 'package:pocket_pay_app/services/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/sizeconfig.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () async {
      String appUse = await localStorage.getString("appUse");
      print(appUse);
      if (appUse.isEmpty) {
        Get.offAll(SignUpDecisionFlow());
      }
      if (appUse == "customer") {
        Get.offAll(LoginScreen());
      }
      if (appUse == "merchant") {
        Get.offAll(MerchantDecisionScreen());
      }
      if (appUse == "staff") {
        Get.offAll(StaffLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "POCKET-PAY",
              style: txStyle27Boldwt,
            ),
          )
        ],
      ),
    );
  }
}
