import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/main/success_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button_load.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/merchant_repository.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  const VerifyPhoneNumberScreen({super.key});

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  bool OTPsent = false;
  TextEditingController OTPController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Phone number verification",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(5)),
        child: ListView(
          children: [
            vertical20,
            !OTPsent
                ? Column(
                    children: [
                      Text(
                        "An OTP will be sent to ${userProv.merchantProfileModel.data?.phone}, click the 'send' button to proceed",
                        style: txStyle12.copyWith(color: Colors.grey),
                      ),
                      vertical20,
                      CustomButtonLoad(
                          userProv: userProv.state,
                          onTap: () async {
                            bool res = await userProv.sendOTP();
                            if (res) {
                              setState(() {
                                OTPsent = true;
                              });
                            }
                          },
                          label: "Send OTP"),
                    ],
                  )
                : OTPsent
                    ? Column(
                        children: [
                          CustomTextField(
                            labelText: "OTP code",
                            hintText: "00000",
                            controller: OTPController,
                          ),
                          vertical20,
                          CustomButtonLoad(
                              userProv: userProv.state,
                              onTap: () async {
                                bool res = await userProv
                                    .validateOTP(OTPController.text);
                                if (res) {
                                  Get.off(SuccessScreen(
                                      content: "Phone number verified",
                                      buttonText: "Go back",
                                      onTap: () {
                                        userProv.fetchMerchantProfile();
                                        Get.back();
                                      }));
                                }
                              },
                              label: "Verify OTP"),
                        ],
                      )
                    : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
