import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/user_repository.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/main/home_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button_load.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../customer/main/bottom_nav_bar.dart';

class CreatePasswordScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String otherName;
  final String email;
  final String phone;
  final String ProfilePicture;

  const CreatePasswordScreen(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.otherName,
      required this.email,
      required this.phone,
      required this.ProfilePicture});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    // final authRepository authRep = Get.put(authRepository());
    final authProv = Provider.of<UserProvider>(context);

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
                userProv: authProv.state,
                onTap: () async {
                  bool u = await authProv.signup(
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      otherName: widget.otherName,
                      email: widget.email,
                      phone: widget.phone,
                      password: _password.text,
                      profilePicture: widget.ProfilePicture);

                  if (u) {
                    authProv.fetchCustomerProfile();
                    authProv.fetchQrCodeTransactions();
                    authProv.fetchFlwTransactions();
                    Get.to(BottomNav());
                  }
                },
                label: "Finish")
          ],
        ),
      ),
    );
  }
}
