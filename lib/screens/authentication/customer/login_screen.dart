import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/authentication/customer/signup_screen.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_decision_screen.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_login_screen.dart';
import 'package:pocket_pay_app/screens/customer/main/bottom_nav_bar.dart';
import 'package:pocket_pay_app/screens/customer/main/home_screen.dart';
import 'package:pocket_pay_app/screens/onboarding/signup_decision_screen.dart';
import 'package:pocket_pay_app/services/local_auth_service.dart';
import 'package:pocket_pay_app/services/local_storage.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button_load.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/repositories/user_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  final _loginkey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final AuthProv authProv = Get.put(UserProvider());
    final authProv = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Form(
        key: _loginkey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
            child: ListView(
              children: [
                vertical120,
                Text(
                  "Hello customer 👋.",
                  style: txStyle27Bold.copyWith(color: appPrimaryColor),
                ),
                vertical20,
                CustomTextField(
                  labelText: "Phone number",
                  hintText: "+234*********",
                  controller: _phoneController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => authProv.validatePhoneNumber(value!),
                ),
                vertical10,
                CustomTextField(
                  labelText: "Password",
                  hintText: "********",
                  controller: _passwordcontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => authProv.validatePassword(value!),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: txStyle12.copyWith(color: appPrimaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightOf(4),
                ),
                CustomButtonLoad(
                    userProv: authProv.state,
                    onTap: () async {

                      if (!_loginkey.currentState!.validate()) return;
                      bool response = await authProv.login(
                          phone: _phoneController.text.trim(),
                          password: _passwordcontroller.text.trim());

                      if (response) {
                        localStorage.setString("appUse", "customer");

                        authProv.fetchCustomerProfile();
                        authProv.fetchQrCodeTransactions();
                        authProv.fetchFlwTransactions();

                        Future.delayed(Duration(seconds: 1), () {
                          Get.to(() => BottomNav());
                        });
                      }
                    },
                    label: "LOG IN"),
                vertical10,
                IconButton(
                    onPressed: () async {
                      bool res =
                          await LocalAuth.authenticate(accountType: "customer");
                      if (res) {
                        authProv.fetchCustomerProfile();
                        authProv.fetchQrCodeTransactions();
                        authProv.fetchFlwTransactions();
                        Future.delayed(Duration(seconds: 1), () {
                          Get.to(() => BottomNav());
                        });
                      }
                    },
                    icon: Icon(
                      Icons.fingerprint_rounded,
                      size: 40,
                    )),
                vertical20,
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(SignupScreen());
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'New to Pocket Pay? ',
                        style: txStyle14,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Join us',
                              style: txStyle14Bold.copyWith(
                                  color: appPrimaryColor))
                        ],
                      ),
                    ),
                  ),
                ),
                vertical10,
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.off(MerchantDecisionScreen());
                    },
                    child: Text(
                      "Continue as a merchant",
                      style: txStyle14.copyWith(color: appPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
