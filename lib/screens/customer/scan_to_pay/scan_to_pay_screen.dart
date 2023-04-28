import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/responsiveState/responsive_state.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/scan_to_pay/confirm_transaction_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:unicons/unicons.dart';

import '../../../api/repositories/user_repository.dart';

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({super.key});

  @override
  State<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool flashOn = false;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      resumeCamera();
    });
  }

  resumeCamera() async {
    await controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Scan QR code",
      ),
      body: ResponsiveState(
        state: userProv.state,
        busyWidget: SpinKitFadingCircle(color: Colors.black),
        idleWidget: Column(
          children: [
            Expanded(flex: 4, child: _buildQrView(context)),
            // CustomTextField(
            //   labelText: "temp",
            //   controller: textController,
            // ),
            // vertical10,
            // CustomButton(
            //     onTap: () async {
            //       bool u = await userProv.fetchQrCodeData(textController.text);
            //       if (u) {
            //         Get.to(ConfirmTransactionScreen(
            //           tx_ref: textController.text,
            //         ));
            //       }
            //     },
            //     label: "temp"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: appPrimaryColor,
                  ),
                  child: IconButton(
                      onPressed: () async {
                        await controller?.resumeCamera();
                      },
                      icon: Icon(
                        Icons.play_arrow_sharp,
                        color: Colors.white,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: appPrimaryColor,
                  ),
                  child: IconButton(
                      onPressed: () async {
                        await controller?.pauseCamera();
                      },
                      icon: Icon(
                        Icons.pause,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            vertical20,
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = SizeConfig.heightOf(30);
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: appPrimaryColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    final userProv = Provider.of<UserProvider>(context, listen: false);
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      result = scanData;
      log("data from qr code ${result?.code}");
      bool u = await userProv.fetchQrCodeData("${result?.code}");
      if (u) {
        Get.off(ConfirmTransactionScreen(
          tx_ref: "${result?.code}",
        ));
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
