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
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';

class MerchantQrCodeScreen extends StatefulWidget {
  final String amount;
  final String description;
  final String businessName;
  const MerchantQrCodeScreen(
      {super.key,
      required this.amount,
      required this.description,
      required this.businessName});

  @override
  State<MerchantQrCodeScreen> createState() => _MerchantQrCodeScreenState();
}

class _MerchantQrCodeScreenState extends State<MerchantQrCodeScreen> {
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
                      Text(
                        hasExpired ? "Qr code has expired." : "Expires in ",
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
                                // Get.close(2);
                                bool res = await userProv.generateQrCode(
                                    widget.amount,
                                    widget.description,
                                    widget.businessName);

                                if (res) {
                                  // userProv.fetchQrCodeTransactions();
                                  controller?.start();
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
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              CustomButton(
                  onTap: () {
                    Get.offAll(MerchantBottomNav());
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
