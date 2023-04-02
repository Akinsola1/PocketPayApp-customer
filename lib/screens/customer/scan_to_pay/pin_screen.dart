import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/constant/text_style.dart';
import 'package:pocket_pay_app/screens/customer/main/success_screen.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../widgets/custom_pin_widget.dart';
import '../../../widgets/customer_appbar.dart';
import '../main/bottom_nav_bar.dart';

class PinScreen extends StatefulWidget {
  final String amount;
  final String tx_ref;
  final String description;
  const PinScreen({
    Key? key,
    required this.amount,
    required this.description,
    required this.tx_ref,
  }) : super(key: key);

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);

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
            CustomButton(
                onTap: () async {
                  bool res1 =
                      await userProv.validateUserPin(otpController.text);
                  if (res1) {
                    bool u =
                        await userProv.completeScanQrCode("${widget.tx_ref}");
                    if (u) {
                      userProv.fetchQrCodeTransactions();
                      Get.to(SuccessScreen(
                        content: "Payment done successfully",
                        onTap: () {
                          userProv.fetchCustomerProfile();
                          userProv.fetchQrCodeTransactions();
                          Get.offAll(BottomNav());
                        },
                      ));
                    }
                  }
                },
                label: "Generate QR code"),
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
