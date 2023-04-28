import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/constant/colors.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/generate_to_pay/pin_screen.dart';
import 'package:pocket_pay_app/screens/merchant/business/merchant_qr_code_screen.dart';
import 'package:pocket_pay_app/screens/merchant/home/add_bank_screen.dart';
import 'package:pocket_pay_app/screens/merchant/merchant_wallet/merchant_validate_pin_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button.dart';
import 'package:pocket_pay_app/widgets/custom_textfield.dart';
import 'package:pocket_pay_app/widgets/customer_appbar.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../constant/text_style.dart';

class MerchantWithdrawFundsScreen extends StatefulWidget {
  const MerchantWithdrawFundsScreen({super.key});

  @override
  State<MerchantWithdrawFundsScreen> createState() =>
      _MerchantGenerateQrCodeScreenState();
}

class _MerchantGenerateQrCodeScreenState
    extends State<MerchantWithdrawFundsScreen> {
  final TextEditingController amountController = TextEditingController();
  late FocusNode myFocusNode;
  final _key = GlobalKey<FormState>();
  int? selectedRadio;
  String accountNumber = "";
  String bankCode = "";

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

  setSelectedRadio(val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Withdraw Funds",
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
                    vertical50,
                    Center(
                      child: Text(
                        "How much do you want to withdraw",
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
                            validator: (value) =>
                                userProv.validateAmount(value!),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                    Text(
                      "Select bank to withdraw to",
                      style: txStyle14Bold,
                    ),
                    vertical10,
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: userProv.merchantBanksModel.data?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.account_balance_outlined,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            title: Text(
                              "${userProv.merchantBanksModel.data?.elementAt(index).accName}",
                              style: txStyle14Bold,
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  "${userProv.merchantBanksModel.data?.elementAt(index).accNum}",
                                  style: txStyle12.copyWith(color: Colors.grey),
                                ),
                                Text(
                                  " • ${userProv.merchantBanksModel.data?.elementAt(index).bankName}",
                                  style: txStyle12.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                            trailing: Radio(
                              value: index,
                              groupValue: selectedRadio,
                              activeColor: appPrimaryColor,
                              onChanged: (val) async {
                                accountNumber =
                                    "${userProv.merchantBanksModel.data?.elementAt(index).accNum}";
                                bankCode =
                                    "${userProv.merchantBanksModel.data?.elementAt(index).bankCode}";
                                setSelectedRadio(val!);
                              },
                            ),
                          );
                        }),
                    // CustomTextField(
                    //   labelText: "Description",
                    //   hintText: "e.g, Car maintenance, Airtime payment",
                    //   controller: descriptionController,
                    // ),
                  ],
                ),
              ),
              vertical30,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(AddBankScreen());
                    },
                    child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: appPrimaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                              child: Text(
                            "Add Bank",
                            style: txStyle14.copyWith(color: appPrimaryColor),
                          )),
                        )),
                  ),
                ],
              ),
              vertical20,
              CustomButton(
                  onTap: () async {
                    if (!_key.currentState!.validate()) return;
                    if (selectedRadio == null) {
                      Fluttertoast.showToast(
                          msg: "Select a bank to proceed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    Get.to(MerchantPinScreen(
                        accountNumber: accountNumber,
                        bankCode: bankCode,
                        amount: amountController.text.replaceAll(",", "")));
                  },
                  label: "Proceed"),
              vertical30
            ],
          ),
        ),
      ),
    );
  }
}
