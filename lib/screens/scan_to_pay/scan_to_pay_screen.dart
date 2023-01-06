import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:unicons/unicons.dart';

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

  @override
  void initState() {
    super.initState();
    resumeCamera();
  }

  resumeCamera() async {
    await controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Scan QR code",
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
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
                  color: kPrimaryColor,
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
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = SizeConfig.heightOf(30);
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: kPrimaryColor,
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
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
