import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_switch.dart';
import 'package:unicons/unicons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool enableBiometrics = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: Center(
            child: Column(
              children: [
                vertical20,
                Container(
                  height: SizeConfig.heightOf(10),
                  width: SizeConfig.heightOf(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kPrimaryColor, width: 1),
                  ),
                  child: Center(
                      child: Icon(
                    UniconsLine.user_exclamation,
                    size: SizeConfig.heightOf(3),
                  )),
                ),
                vertical20,
                Text(
                  "Akinsola Faruq",
                  style: txStyle16Bold,
                ),
                Text(
                  "Akinsola1",
                  style: txStyle14,
                ),
                vertical10,
                Text(
                  "Edit",
                  style: txStyle12.copyWith(color: kPrimaryColor),
                ),
                vertical30,
                SwitchToggle(
                  serviceToggle: enableBiometrics,
                  service: "Enable Finger print/Face ID",
                  function: (val) {
                    setState(() {
                      enableBiometrics = val;
                    });
                  },
                ),
                vertical10,
                SwitchToggle(
                  serviceToggle: enableBiometrics,
                  service: "Dark/Light Theme",
                  function: (val) {
                    setState(() {
                      enableBiometrics = val;
                    });
                  },
                ),
                vertical10,
                SwitchToggle(
                  serviceToggle: enableBiometrics,
                  service: "Enable Notification",
                  function: (val) {
                    setState(() {
                      enableBiometrics = val;
                    });
                  },
                ),
                vertical10,
                settingItems(
                    title: "Account Setting",
                    icons: UniconsLine.user,
                    onTap: () async {}),
                    vertical10,
                settingItems(
                    title: "Update KYC",
                    icons: UniconsLine.archive_alt,
                    onTap: () async {}),
                vertical10,
                settingItems(
                    title: "Contact us",
                    icons: UniconsLine.phone,
                    onTap: () async {}),
                vertical10,
                settingItems(
                    title: "Logout",
                    icons: UniconsLine.signout,
                    onTap: () async {})
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
          Divider(
            height: SizeConfig.heightOf(3),
          )
        ],
      ),
    );
  }
}
