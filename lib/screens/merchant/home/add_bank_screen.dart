import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/responsiveState/responsive_state.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/main/success_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button_load.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/merchant_repository.dart';

class AddBankScreen extends StatefulWidget {
  final bool isPartOfAProcess;
  const AddBankScreen({super.key, this.isPartOfAProcess = false});

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  final _accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Add bank",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(5)),
        child: ListView(
          children: [
            vertical20,
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    isDismissible: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    context: context,
                    builder: (context) => BanksSheet());
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffD5DDE0),
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userProv.selectedBank.name ?? "Select bank",
                          style: txStyle14,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            vertical20,
            CustomTextField(
              labelText: "Account number",
              hintText: "12345678",
              controller: _accountNumberController,
            ),
            vertical20,
            userProv.accountOwner.isNotEmpty
                ? Center(
                    child: Column(
                      children: [
                        Text(
                          userProv.accountOwner,
                          style: txStyle16.copyWith(color: appPrimaryColor),
                        ),
                        vertical20,
                        InkWell(
                          onTap: () {
                            _accountNumberController.clear();
                            userProv.clearBank();
                          },
                          child: Center(
                              child: Text(
                            "Clear",
                            style: txStyle16,
                          )),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            vertical30,
            CustomButtonLoad(
                userProv: userProv.state,
                onTap: () async {
                  if (userProv.accountOwner.isEmpty) {
                    userProv.verifyBank(_accountNumberController.text,
                        userProv.selectedBank.code!);
                  } else {
                    bool u = await userProv.addBank(
                        _accountNumberController.text,
                        userProv.selectedBank.code!,
                        userProv.accountOwner,
                        userProv.selectedBank.name!);
                    if (u) {
                      userProv.fetchMerchantBank();
                      widget.isPartOfAProcess
                          ? Get.off(SuccessScreen(
                              content: "Bank account added successfully",
                              buttonText: "Continue",
                              onTap: () {
                                Get.close(2);
                              }))
                          : Get.off(SuccessScreen(
                              content: "Bank account added successfully",
                              onTap: () {
                                Get.back();
                              }));
                    }
                  }
                },
                label: userProv.accountOwner.isEmpty
                    ? "Verify account"
                    : "Add bank")
          ],
        ),
      ),
    );
  }
}

class BanksSheet extends StatelessWidget {
  const BanksSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Container(
      height: SizeConfig.heightOf(80),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthOf(5), vertical: 20),
        child: ResponsiveState(
          state: userProv.state,
          busyWidget: SpinKitFadingCircle(color: Colors.black),
          idleWidget: ListView.builder(
            shrinkWrap: true,
            itemCount: userProv.allBankModel.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  userProv.clearBank();
                  userProv.setBank(userProv.allBankModel.elementAt(index));
                  Navigator.pop(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vertical10,
                    Text(
                      "${userProv.allBankModel.elementAt(index).name}",
                      style: txStyle14,
                    ),
                    vertical10,
                    Divider(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
