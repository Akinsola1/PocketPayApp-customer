import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/constant/text_style.dart';
import 'package:pocket_pay_app/screens/generate_to_pay/qr_code_screen.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';

import '../../widgets/custom_pin_widget.dart';
import '../../widgets/customer_appbar.dart';

class PinScreen extends StatefulWidget {
  final String amount;
  final String description;
  const PinScreen({
    Key? key,
    required this.amount,
    required this.description,
  }) : super(key: key);

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Enter wallet PIN',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            Text(
              "Enter your 4-digit transaction pin",
              style: txStyle14,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ 
                PINCodeInput(inputLenght: 4, controller: otpController),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            Spacer(),
            CustomButton(onTap: () {
              Get.to(QrCodeScreen());
            }, label: "Generate QR code"),
            const SizedBox(
              height: 20,
            ),
            // CustomButton(
            //     onTap: () {
            //     },
            //     label: 'Verify')
          ],
        ),
      ),
    );
  }
}
