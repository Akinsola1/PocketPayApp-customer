import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: Column(
            children: [
              Text("Wallet",style: txStyle27Bold.copyWith(color: kPrimaryColor),)
            ],
          ),
        ),
      ),
    );
  }
}