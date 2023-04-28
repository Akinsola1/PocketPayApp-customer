import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/utils/utils.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';

class FundingWalletBankTransferScreen extends StatelessWidget {
  const FundingWalletBankTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Fund Wallet",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthOf(5), vertical: 20),
        child: Column(
          children: [
            vertical30,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: appPrimaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${userProv.fundWalletBankTransferModel.response?.meta?.authorization?.transferAccount}",
                          style: txStyle15.copyWith(color: appPrimaryColor),
                        ),
                        horizontalx5,
                        InkWell(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                text:
                                    "${userProv.fundWalletBankTransferModel.response?.meta?.authorization?.transferAccount}"));
                            Fluttertoast.showToast(
                                msg: "Copied to clipboard",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            // copied successfully
                          },
                          child: Icon(
                            Icons.copy,
                            color: appPrimaryColor,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                    vertical5,
                    Text(
                      "${userProv.fundWalletBankTransferModel.response?.meta?.authorization?.transferBank}",
                      style: txStyle14.copyWith(color: appPrimaryColor),
                    ),
                    vertical20,
                    Text(
                      "Make a bank transfer of ${convertStringToCurrency("${userProv.fundWalletBankTransferModel.response?.meta?.authorization?.transferAmount}")} to above account. You will be notified shortly after the transaction is successful",
                      textAlign: TextAlign.center,
                      style: txStyle13.copyWith(
                          color: appPrimaryColor.withOpacity(0.5), height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            CustomButton(
                onTap: () {
                  userProv.fetchFlwTransactions();
                  userProv.fetchCustomerProfile();
                  Get.close(1);
                },
                label: "Done")
          ],
        ),
      ),
    );
  }
}
