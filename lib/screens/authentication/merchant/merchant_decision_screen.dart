import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_login_screen.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/staff_login_screen.dart';
import 'package:pocket_pay_app/services/local_storage.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';

class MerchantDecisionScreen extends StatefulWidget {
  const MerchantDecisionScreen({super.key});

  @override
  State<MerchantDecisionScreen> createState() => _MerchantDecisionScreenState();
}

class _MerchantDecisionScreenState extends State<MerchantDecisionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(5)),
        child: Column(
          children: [
            Text(
              "Continue as",
              style: txStyle16,
            ),
            vertical20,
            InkWell(
              onTap: () {
                Get.off(MerchantLoginScreen());
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: appPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appPrimaryColor),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Admin",
                        style: txStyle20Bold,
                      ),
                      vertical10,
                      Text(
                        "The creator of an organization",
                        style: txStyle14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            vertical20,
            InkWell(
              onTap: () {
                Get.off(StaffLoginScreen());
                // localStorage.clear();
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: appPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appPrimaryColor),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Staff",
                        style: txStyle20Bold,
                      ),
                      vertical10,
                      Text(
                        "Users created by the admin",
                        style: txStyle14,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
