import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/api/responsiveState/responsive_state.dart';

import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/main/bottom_nav_bar.dart';
import 'package:pocket_pay_app/screens/customer/main/home_screen.dart';
import 'package:pocket_pay_app/screens/merchant/home/merchant_bottom_nav.dart';
import 'package:pocket_pay_app/screens/staff/staff_home_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';

class StaffQrCodeScreen extends StatefulWidget {
  final String amount;
  const StaffQrCodeScreen({
    super.key,
    required this.amount,
  });

  @override
  State<StaffQrCodeScreen> createState() => _StaffQrCodeScreenState();
}

class _StaffQrCodeScreenState extends State<StaffQrCodeScreen> {
  CountdownTimerController? controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
  bool hasExpired = false;

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime);
  }

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Make Payment",
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.close,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.heightOf(4),
            vertical: SizeConfig.heightOf(2)),
        child: Center(
          child: Column(
            children: [
              Text(
                "Display QR code for customer to scan",
                style: txStyle14,
              ),
              Spacer(),
              Column(
                children: [
                  ResponsiveState(
                    state: userProv.state,
                    busyWidget: Center(
                      child: SpinKitFadingCircle(color: Colors.black),
                    ),
                    idleWidget: PrettyQr(
                      // image: AssetImage('images/twitter.png'),
                      typeNumber: 3,
                      size: SizeConfig.heightOf(30),
                      data:
                          '${userProv.merchantGenerateQrcodeResponseModel.data?.txRef}',
                      errorCorrectLevel: QrErrorCorrectLevel.H,
                      roundEdges: true,
                    ),
                  ),
                  vertical30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      hasExpired
                          ? Text(
                              "Qr code has expired.",
                              style: txStyle14,
                            )
                          : Text(
                              "Expires in ",
                              style: txStyle14,
                            ),
                      CountdownTimer(
                        controller: controller,
                        endTime: endTime,
                        onEnd: () {
                          setState(() {
                            hasExpired = true;
                          });
                        },
                        widgetBuilder: (context, time) {
                          if (time == null) {
                            return InkWell(
                              onTap: () async {
                                bool res = await userProv.staffGenerateQrCode(
                                  amount: widget.amount,
                                );

                                if (res) {
                                  setState(() {
                                    hasExpired = false;
                                    controller?.start();
                                  });
                                  // userProv.fetchQrCodeTransactions();
                                }
                              },
                              child: Text(
                                ' Generate new one',
                                style:
                                    txStyle14.copyWith(color: appPrimaryColor),
                              ),
                            );
                          }
                          return Text(
                              '${time.min == null ? 0 : time.min}:${time.sec}');
                        },
                        endWidget: Text(
                          "Qr code has expired.",
                          style: txStyle14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              CustomButton(
                  onTap: () {
                    Get.offAll(StaffHomeScreen());
                  },
                  label: "Done"),
              vertical20
            ],
          ),
        ),
      ),
    );
  }
}
