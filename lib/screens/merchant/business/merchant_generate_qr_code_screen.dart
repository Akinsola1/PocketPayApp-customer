import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/constant/colors.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/generate_to_pay/pin_screen.dart';
import 'package:pocket_pay_app/screens/merchant/business/merchant_qr_code_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button.dart';
import 'package:pocket_pay_app/widgets/custom_textfield.dart';
import 'package:pocket_pay_app/widgets/customer_appbar.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../constant/text_style.dart';

class MerchantGenerateQrCodeScreen extends StatefulWidget {
  final String businessId;
  const MerchantGenerateQrCodeScreen({super.key, required this.businessId});

  @override
  State<MerchantGenerateQrCodeScreen> createState() =>
      _MerchantGenerateQrCodeScreenState();
}

class _MerchantGenerateQrCodeScreenState
    extends State<MerchantGenerateQrCodeScreen> {
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
        title: "Generate QR Code",
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
                          "Generate a unique QR code for customers to scan",
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
                    CustomTextField(
                      labelText: "Description",
                      hintText: "e.g, Car maintenance, Airtime payment",
                      controller: descriptionController,
                    ),
                    vertical20,
                    CustomButton(
                        onTap: () async {
                          if (!_key.currentState!.validate()) return;
                          bool u = await userProv.generateQrCode(
                              amountController.text.replaceAll(",", ""),
                              descriptionController.text,
                              widget.businessId);

                          if (u) {
                            Get.off(MerchantQrCodeScreen(
                                amount:
                                    amountController.text.replaceAll(",", ""),
                                description: descriptionController.text,
                                businessName: widget.businessId));
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
