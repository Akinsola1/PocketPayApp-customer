import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/constant/text_style.dart';
import 'package:pocket_pay_app/screens/customer/main/success_screen.dart';
import 'package:pocket_pay_app/widgets/custom_button_load.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../widgets/custom_pin_widget.dart';
import '../../../widgets/customer_appbar.dart';

class MerchantPinScreen extends StatefulWidget {
  final String amount;
  final String accountNumber;
  final String bankCode;

  const MerchantPinScreen({
    Key? key,
    required this.amount,
    required this.accountNumber,
    required this.bankCode,
  }) : super(key: key);

  @override
  State<MerchantPinScreen> createState() => _MerchantPinScreenState();
}

class _MerchantPinScreenState extends State<MerchantPinScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

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
            CustomButtonLoad(
                userProv: userProv.state,
                onTap: () async {
                  bool res1 =
                      await userProv.validateMerchantPIN(otpController.text);
                  if (res1) {
                    bool u = await userProv.tempWithdrawMethod(
                        widget.amount, widget.accountNumber, widget.bankCode);

                    if (u) {
                      userProv.fetchMerchantProfile();
                      userProv.fetchMerchantFlwTransactions();
                      Get.to(SuccessScreen(
                        content:
                            "Withdrawal Queued successfully. You will be\nnotified when withdrawal is successful.",
                        onTap: () {
                          
                          Get.close(3);
                        },
                      ));
                    }
                  }
                },
                label: "Withdraw Funds"),
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
