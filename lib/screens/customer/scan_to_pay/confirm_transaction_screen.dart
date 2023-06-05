import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/scan_to_pay/pin_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/utils/utils.dart';
import 'package:pocket_pay_app/widgets/custom_imaga.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';

class ConfirmTransactionScreen extends StatelessWidget {
  final String tx_ref;
  const ConfirmTransactionScreen({super.key, required this.tx_ref});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Confirm Transaction",
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: Column(
            children: [
              CustomNetworkImage(
                  radius: 100,
                  imageUrl:
                      ""),
              vertical10,
              Text(
                "${userProv.merchantFetchQrCodeData.data?.customerName}",
                style: txStyle16Bold,
              ),
              Text(
                "customer@gmail.com",
                style: txStyle12,
              ),
              vertical50,
              Text(
                "You are paying",
                style: txStyle12,
              ),
              Text(
                convertStringToCurrency(
                    "${userProv.merchantFetchQrCodeData.data?.amount}"),
                style: txStyle27Bold.copyWith(color: appPrimaryColor),
              ),
              vertical20,
              CustomTextField(
                labelText: "Description",
                hintText: "e.g Car maintenance",
                controller: descriptionController,
              ),
              vertical20,
              CustomButton(
                  onTap: () async {
                    Get.to(PinScreen(
                        tx_ref: tx_ref,
                        amount: "${userProv.merchantFetchQrCodeData.data?.amount}",
                        description: descriptionController.text));
                  },
                  label: "Proceed")
            ],
          ),
        ),
      ),
    );
  }
}
