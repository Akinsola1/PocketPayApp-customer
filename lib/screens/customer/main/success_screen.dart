import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_pay_app/constant/size.dart';
import 'package:pocket_pay_app/constant/text_style.dart';
import 'package:pocket_pay_app/screens/customer/main/bottom_nav_bar.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';

class SuccessScreen extends StatelessWidget {
  final String content;
  final String buttonText;

  final VoidCallback onTap;
  const SuccessScreen({super.key, required this.content, required this.onTap, this.buttonText = "Go Home"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Lottie.asset("assets/lottie/Anim8_.json",
                height: 200, width: 200, repeat: false),
            vertical20,
            Text(
              content,
              textAlign: TextAlign.center,
              style: txStyle16.copyWith(height: 1.5),
            ),
            Spacer(),
            CustomButton(onTap: onTap, label: buttonText),
            vertical30,
          ],
        ),
      ),
    );
  }
}
