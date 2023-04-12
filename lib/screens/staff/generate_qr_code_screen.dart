import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/constant/colors.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/generate_to_pay/pin_screen.dart';
import 'package:pocket_pay_app/screens/staff/staff_qrCode_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button.dart';
import 'package:pocket_pay_app/widgets/customer_appbar.dart';
import 'package:provider/provider.dart';

class StaffGenerateQrCodeScreen extends StatefulWidget {
  const StaffGenerateQrCodeScreen({super.key});

  @override
  State<StaffGenerateQrCodeScreen> createState() =>
      _StaffGenerateQrCodeScreenState();
}

class _StaffGenerateQrCodeScreenState extends State<StaffGenerateQrCodeScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late FocusNode myFocusNode;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Generate QR CODE",
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      width: SizeConfig.widthOf(10),
                      child: Center(
                        child: Text(
                          "Generate a unique QR code for customer to scan",
                          style: txStyle14,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    vertical50,
                    Center(
                      child: Text(
                        "How much is the customer paying",
                        style: txStyle12,
                      ),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.widthOf(50),
                          child: TextFormField(
                            focusNode: myFocusNode,
                            textAlign: TextAlign.center,
                            cursorColor: appPrimaryColor,
                            style: txStyle27Bold,
                            keyboardType: TextInputType.number,
                            controller: amountController,
                            inputFormatters: [ThousandsFormatter()],
                            // validator: (value) =>
                            //     userProv.validateAmount(value!),

                            decoration: InputDecoration(
                              prefixText: "₦",
                              hintText: '5000',
                              hintStyle: txStyle27Bold.copyWith(
                                  color: appPrimaryColor.withOpacity(0.2),
                                  fontSize: 30),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    vertical20,
                    CustomButton(
                        onTap: () async {
                          if (!_key.currentState!.validate()) return;

                          bool u = await userProv.staffGenerateQrCode(
                              amount:
                                  amountController.text.replaceAll(',', ''));
                          if (u) {
                            Get.off(StaffQrCodeScreen(
                              amount: amountController.text.replaceAll(',', ''),
                            ));
                          }
                        },
                        label: "Proceed")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
