import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';

import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/authentication/customer/login_screen.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_signup_screen.dart';
import 'package:pocket_pay_app/screens/customer/main/bottom_nav_bar.dart';
import 'package:pocket_pay_app/screens/customer/main/home_screen.dart';
import 'package:pocket_pay_app/screens/merchant/home/merchant_bottom_nav.dart';
import 'package:pocket_pay_app/screens/onboarding/signup_decision_screen.dart';
import 'package:pocket_pay_app/screens/staff/staff_home_screen.dart';
import 'package:pocket_pay_app/services/local_auth_service.dart';
import 'package:pocket_pay_app/services/local_storage.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button_load.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';

class StaffLoginScreen extends StatefulWidget {
  const StaffLoginScreen({super.key});
  @override
  State<StaffLoginScreen> createState() => _StaffLoginScreenState();
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
  final _loginkey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final AuthProv authProv = Get.put(UserProvider());
    final authProv = Provider.of<MerchantProvider>(context);

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
                  "Hello staff 👋.",
                  style: txStyle27Bold.copyWith(color: appPrimaryColor),
                ),
                vertical20,
                CustomTextField(
                  labelText: "Phone number",
                  hintText: "+234*********",
                  controller: _phoneController,
                  textInputType: TextInputType.number,
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
                      bool response = await authProv.staffLogin(
                          phone: _phoneController.text.trim(),
                          password: _passwordcontroller.text.trim());

                      if (response) {
                        localStorage.setString("appUse", "staff");

                        // authProv.fetchMerchantProfile();
                        // authProv.fetchMerchantBusiness();
                        // authProv.fetchMerchantQrCodeTransaction();
                        // authProv.fetchMerchantFlwTransactions();
                        // authProv.fetchMerchantBank();
                        // authProv.fetchBanks();
                        authProv.fetchStaffProfile();

                        Future.delayed(Duration(seconds: 1), () {
                          authProv.fetchStaffQrCodeHistory();
                          Get.to(() => StaffHomeScreen());
                        });
                      }
                    },
                    label: "LOG IN"),
                vertical10,
                IconButton(
                    onPressed: () async {
                      // bool res =
                      //     await LocalAuth.authenticate(accountType: "merchant");
                      // if (res) {
                      //   Future.delayed(Duration(seconds: 1), () {
                      //     Get.to(() => MerchantBottomNav());
                      //   });
                      //   // authProv.fetchMerchantProfile();
                      //   // authProv.fetchMerchantBusiness();
                      //   // authProv.fetchMerchantQrCodeTransaction();
                      //   // authProv.fetchMerchantFlwTransactions();
                      //   // authProv.fetchMerchantBank();
                      //   // authProv.fetchBanks();
                      //   Future.delayed(Duration(seconds: 1), () {
                      //     Get.to(() => MerchantBottomNav());
                      //   });
                      // }
                    },
                    icon: Icon(
                      Icons.fingerprint_rounded,
                      size: 40,
                    )),
                vertical20,
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(MerchantSignupScreen());
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Are you a new merchant? ',
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
                      Get.to(LoginScreen());
                    },
                    child: Text(
                      "Continue as a customer",
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
