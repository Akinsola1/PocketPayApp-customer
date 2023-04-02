import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/main/create_pin_screen.dart';
import 'package:pocket_pay_app/screens/customer/main/home_screen.dart';
import 'package:pocket_pay_app/screens/merchant/home/add_bank_screen.dart';
import 'package:pocket_pay_app/screens/merchant/home/identity_verification_screen.dart';
import 'package:pocket_pay_app/screens/merchant/home/merchant_add_contact_info_screen.dart';
import 'package:pocket_pay_app/screens/merchant/home/merchant_create_pin_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';

class MerchantCompleteProfileScreen extends StatefulWidget {
  const MerchantCompleteProfileScreen({super.key});

  @override
  State<MerchantCompleteProfileScreen> createState() =>
      _MerchantCompleteProfileScreenState();
}

class _MerchantCompleteProfileScreenState
    extends State<MerchantCompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile setup",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
        child: Column(
          children: [
            vertical20,
            todoWidget(
                completed: userProv.merchantProfileModel.data!.setPin!,
                onpressed: () {
                  Get.to(MerchantCreatePinScree());
                },
                title: "Create PIN",
                subtitle:
                    "Creeate a four(4) digit personal identification number"),
            vertical10,
            todoWidget(
                completed: userProv.merchantProfileModel.data!.addBank!,
                onpressed: () {
                  userProv.fetchBanks();
                  Get.to(AddBankScreen());
                },
                title: "Add bank account",
                subtitle: "Add multiple personal account for withdrawal"),
            vertical10,
            todoWidget(
                completed: userProv.merchantProfileModel.data!.kycVerified!,
                onpressed: () {
                  Get.to(IdentityVerificationScreen());
                },
                title: "Identity verification",
                subtitle:
                    "Provide necessary document to validate your identity"),
            vertical10,
            todoWidget(
                completed:
                    userProv.merchantProfileModel.data!.contactPersonAdded!,
                onpressed: () {
                  Get.to(MerchantAddContactScreen());
                },
                title: "Next of Kin",
                subtitle: "Provide necessary details about Next of Kin"),
          ],
        ),
      ),
    );
  }
}
