import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ViewQrCodeScreen extends StatelessWidget {
  final String tx_ref;
  const ViewQrCodeScreen({super.key, required this.tx_ref});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: PrettyQr(
                // image: AssetImage('images/twitter.png'),
                typeNumber: 3,
                size: SizeConfig.heightOf(30),
                data: tx_ref,
                errorCorrectLevel: QrErrorCorrectLevel.H,
                roundEdges: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
