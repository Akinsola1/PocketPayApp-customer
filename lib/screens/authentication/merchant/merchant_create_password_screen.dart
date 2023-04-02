import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/api/repositories/user_repository.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_create_business_screen.dart';
import 'package:pocket_pay_app/screens/customer/main/home_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button_load.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../widgets/test.dart';
import '../../customer/main/bottom_nav_bar.dart';

class MerchantCreatePasswordScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String otherName;
  final String email;
  final String phone;

  const MerchantCreatePasswordScreen(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.otherName,
      required this.email,
      required this.phone});

  @override
  State<MerchantCreatePasswordScreen> createState() =>
      _MerchantCreatePasswordScreenState();
}

class _MerchantCreatePasswordScreenState
    extends State<MerchantCreatePasswordScreen> {
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    // final authRepository authRep = Get.put(authRepository());
    final merchantProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
        child: ListView(
          children: [
            Text(
              "Create Password",
              style: txStyle27Bold.copyWith(color: appPrimaryColor),
            ),
            Text(
              "Create a secure password for your account 👮‍♀️",
              style: txStyle14,
            ),
            vertical20,
            CustomTextField(
              labelText: "Password",
              hintText: "********",
              controller: _password,
              obscureText: true,
            ),
            vertical10,
            FlutterPwValidator(
                controller: _password,
                minLength: 6,
                uppercaseCharCount: 1,
                numericCharCount: 1,
                specialCharCount: 1,
                width: 350,
                height: 120,
                onSuccess: () {
                  setState(() {
                    hasError = false;
                    log("$hasError");
                  });
                },
                onFail: () {
                  setState(() {
                    hasError = true;
                    log("$hasError");
                  });
                }),
            vertical30,
            CustomButtonLoad(
                userProv: merchantProv.state,
                onTap: () async {
                  bool u = await merchantProv.merchantSignup(
                    firstName: widget.firstName,
                    lastName: widget.lastName,
                    otherName: widget.otherName,
                    email: widget.email,
                    phone: widget.phone,
                    password: _password.text,
                    profilePicture: ""
                  );

                  if (u) {
                    Get.to(MerchantCreateBusinessProfileScreen());
                  }
                },
                label: "Proceed")
          ],
        ),
      ),
    );
  }
}
