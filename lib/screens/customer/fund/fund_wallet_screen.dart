import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:pocket_pay_app/screens/customer/fund/funding_account_screen.dart';
import 'package:pocket_pay_app/screens/customer/main/success_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button_load.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../constant/export_constant.dart';
import '../main/bottom_nav_bar.dart';

class FundWalletScreen extends StatefulWidget {
  const FundWalletScreen({super.key});

  @override
  State<FundWalletScreen> createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends State<FundWalletScreen> {
  late FocusNode myFocusNode;
  final _key = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();

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
    final userProv = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Fund wallet",
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(5)),
          child: ListView(
            children: [
              vertical20,
              Center(
                child: Text(
                  "How much do you want to fund your wallet with",
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
                      validator: (value) => userProv.validateAmount(value!),
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
              vertical50,
              CustomButtonLoad(
                  onTap: () async {
                    if (!_key.currentState!.validate()) return;

                    bool res = await userProv
                        .fundWallet(amountController.text.replaceAll(",", ""));
                    if (res) {
                      // userProv.fetchCustomerProfile();
                      Get.off(FundingWalletBankTransferScreen());
                    }
                  },
                  label: "Fund",
                  userProv: userProv.state)
            ],
          ),
        ),
      ),
    );
  }
}
