import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/authentication/customer/login_screen.dart';
import 'package:pocket_pay_app/screens/authentication/customer/signup_screen.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_decision_screen.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_login_screen.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_signup_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpDecisionFlow extends StatefulWidget {
  const SignUpDecisionFlow({super.key});

  @override
  State<SignUpDecisionFlow> createState() => _SignUpDecisionFlowState();
}

class _SignUpDecisionFlowState extends State<SignUpDecisionFlow> {
  bool option1 = false;
  bool option2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vertical20,
              Text(
                "Hello there 👋",
                style: txStyle27Bold.copyWith(color: appPrimaryColor),
              ),
              Text(
                "Select how you want to use PocketPay 😎",
                style: txStyle14,
              ),
              vertical20,
              InkWell(
                onTap: () {
                  setState(() {
                    option1 = true;
                    option2 = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: option1
                          ? appPrimaryColor.withOpacity(.1)
                          : Colors.transparent,
                      border: Border.all(
                        color: appPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: appPrimaryColor),
                          ),
                          child: Lottie.asset(
                              "assets/lottie/48876-user-outlined.json",
                              fit: BoxFit.contain,
                              repeat: false),
                        ),
                        horizontalx10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "AS A CUSTOMER",
                              style: txStyle14.copyWith(color: appPrimaryColor),
                            ),
                            vertical5,
                            Text(
                              "• Make payment seamlessly ⏩",
                              style: txStyle13,
                            ),
                            vertical5,
                            Text(
                              "• Detailed spending details 📊",
                              style: txStyle13,
                            ),
                            vertical5,
                            Text(
                              "• something random",
                              style: txStyle13,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              vertical20,
              InkWell(
                onTap: () {
                  setState(() {
                    option2 = true;
                    option1 = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: option2
                          ? appPrimaryColor.withOpacity(.1)
                          : Colors.transparent,
                      border: Border.all(
                        color: appPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: appPrimaryColor),
                          ),
                          child: Lottie.asset("assets/lottie/43. Store.json",
                              fit: BoxFit.contain, repeat: false),
                        ),
                        horizontalx10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "AS A MERCHANT",
                              style: txStyle14.copyWith(color: appPrimaryColor),
                            ),
                            vertical5,
                            Text(
                              "• Receive Payment is seconds 💰",
                              style: txStyle13,
                            ),
                            vertical5,
                            Text(
                              "• Monitor multiple businesses 🧐",
                              style: txStyle13,
                            ),
                            vertical5,
                            Text(
                              "• Manage business finance 📊",
                              style: txStyle13,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              CustomButton(
                  onTap: () async {
                    print("$option1 $option2");
                    if (option1 == false && option2 == false) return;

                    if (option1) {
                      Get.to(LoginScreen());
                      // prefs.setString("appUse", "customer");
                    }
                    if (option2) {
                      Get.to(MerchantDecisionScreen());
                      // prefs.setString("appUse", "merchant");
                    }
                  },
                  label: "Proceed"),
              // SizedBox(
              //   height: SizeConfig.heightOf(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
