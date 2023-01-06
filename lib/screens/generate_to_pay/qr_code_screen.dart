import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:get/get.dart';

import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/main/bottom_nav_bar.dart';
import 'package:pocket_pay_app/screens/main/home_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 180;
  bool hasExpired = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Make Payment",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.heightOf(4),
            vertical: SizeConfig.heightOf(2)),
        child: Center(
          child: Column(
            children: [
              Text(
                "Provide QR code for merchant to scan",
                style: txStyle14,
              ),
              Spacer(),
              Column(
                children: [
                  PrettyQr(
                    // image: AssetImage('images/twitter.png'),
                    typeNumber: 3,
                    size: SizeConfig.heightOf(30),
                    data: 'https://www.google.ru',
                    errorCorrectLevel: QrErrorCorrectLevel.H,
                    roundEdges: true,
                  ),
                  vertical20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hasExpired ? "Qr code has expired." : "Expires in ",
                        style: txStyle14,
                      ),
                      CountdownTimer(
                        endTime: endTime,
                        onEnd: () {
                          setState(() {
                            hasExpired = true;
                          });
                        },
                        widgetBuilder: (context, time) {
                          if (time == null) {
                            return Text(
                              ' Generate new one',
                              style: txStyle14.copyWith(color: kPrimaryColor),
                            );
                          }
                          return Text(
                              '${time.min == null ? 0 : time.min}:${time.sec}');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              CustomButton(onTap: () {
                Get.offAll(BottomNav());
              }, label: "Done"),
              vertical20
            ],
          ),
        ),
      ),
    );
  }
}
