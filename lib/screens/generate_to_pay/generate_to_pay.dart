import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:pocket_pay_app/constant/colors.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/generate_to_pay/pin_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button.dart';
import 'package:pocket_pay_app/widgets/custom_textfield.dart';
import 'package:pocket_pay_app/widgets/customer_appbar.dart';

import '../../constant/text_style.dart';

class GenerateToPayScreen extends StatefulWidget {
  const GenerateToPayScreen({super.key});

  @override
  State<GenerateToPayScreen> createState() => _GenerateToPayScreenState();
}

class _GenerateToPayScreenState extends State<GenerateToPayScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Generate QR CODE",
      ),
      body: Padding(
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
                        "Generate a unique QR code for merchant to scan",
                        style: txStyle14,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  vertical50,
                  Center(
                    child: Text(
                      "How much are you paying",
                      style: txStyle12,
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      SizedBox(
                        width: SizeConfig.widthOf(50),
                        child: TextField(
                          textAlign: TextAlign.center,
                          cursorColor: kPrimaryColor,
                          style: txStyle27Bold,
                          keyboardType: TextInputType.number,
                          controller: amountController,
                          inputFormatters: [ThousandsFormatter()],
                          decoration: InputDecoration(
                            prefixText: "₦",
                            hintText: '5000',
                            hintStyle: txStyle27Bold.copyWith(
                                color: kPrimaryColor.withOpacity(0.2),
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
                    hintText: "e.g, Car maintenance",
                    controller: descriptionController,
                  ),
                  vertical20,
                  CustomButton(
                      onTap: () {
                        Get.to(PinScreen(
                            amount: amountController.text,
                            description: descriptionController.text));
                      },
                      label: "Proceed")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
