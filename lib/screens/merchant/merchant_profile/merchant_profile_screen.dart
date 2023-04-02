import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/authentication/customer/login_screen.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_login_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/utils/utils.dart';
import 'package:pocket_pay_app/widgets/custom_imaga.dart';
import 'package:pocket_pay_app/widgets/custom_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

import '../../../api/repositories/user_repository.dart';

class MerchantProfileScreen extends StatefulWidget {
  const MerchantProfileScreen({super.key});

  @override
  State<MerchantProfileScreen> createState() => _MerchantProfileScreenState();
}

class _MerchantProfileScreenState extends State<MerchantProfileScreen> {
  bool enableBiometrics = false;
  bool enableNotifications = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: Center(
            child: Column(
              children: [
                vertical20,
                CustomNetworkImage(
                  imageUrl:
                      "${userProv.merchantProfileModel.data?.profilePicture}",
                  radius: 100,
                ),
                vertical10,
                Text(
                  capitalizeFirstText(
                    "${userProv.merchantProfileModel.data?.firstName}"
                    " ${userProv.merchantProfileModel.data?.lastName}",
                  ),
                  style: txStyle16Bold,
                ),
                vertical5,
                Text(
                  "${userProv.merchantProfileModel.data?.email}",
                  style: txStyle12.copyWith(color: Colors.grey),
                ),
                vertical20,
                
                vertical30,
                SwitchToggle(
                  serviceToggle: userProv.merchantBiometricEnabled,
                  service: "Enable Finger print/Face ID",
                  function: (val) async {
                    userProv.toggleBiometric();
                  },
                ),
                vertical30,
                SwitchToggle(
                  serviceToggle: enableNotifications,
                  service: "Enable Notification",
                  function: (val) {
                    setState(() {
                      enableNotifications = val;
                    });
                  },
                ),
                vertical20,
                settingItems(
                    title: "Account Setting",
                    icons: UniconsLine.user,
                    onTap: () async {}),
                Divider(),
                vertical20,
                settingItems(
                    title: "Update KYC",
                    icons: UniconsLine.archive_alt,
                    onTap: () async {}),
                Divider(),
                vertical20,
                settingItems(
                    title: "Contact us",
                    icons: UniconsLine.phone,
                    onTap: () async {}),
                Divider(),
                vertical20,
                settingItems(
                    title: "Logout",
                    icons: UniconsLine.signout,
                    onTap: () async {
                      // SharedPreferences prefs =
                      //     await SharedPreferences.getInstance();
                      // prefs.clear();
                      Get.offAll(MerchantLoginScreen());
                    }),
                Divider(),
                vertical20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class settingItems extends StatelessWidget {
  final String title;
  final IconData icons;
  final VoidCallback onTap;
  const settingItems({
    Key? key,
    required this.title,
    required this.icons,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Icon(icons),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: txStyle14,
              )
            ],
          ),
        ],
      ),
    );
  }
}
