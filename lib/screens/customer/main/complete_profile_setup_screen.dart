import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/main/add_contact_details.dart';
import 'package:pocket_pay_app/screens/customer/main/create_pin_screen.dart';
import 'package:pocket_pay_app/screens/customer/main/home_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);

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
                completed: userProv.userProfile.data!.setPin!,
                onpressed: () {
                  Get.to(CreatePinScree());
                },
                title: "Create PIN",
                subtitle:
                    "Creeate a four(4) digit personal identification number"),
            vertical10,
            todoWidget(
                completed: userProv.userProfile.data!.addCard!,
                onpressed: () {},
                title: "Add debit card",
                subtitle:
                    "Link your debit card to PocketPay to found your wallet easily"),
            vertical10,
            todoWidget(
                completed: userProv.userProfile.data!.setContactDetails!,
                onpressed: () {
                  Get.to(AddContactScreen());
                },
                title: "Next of Kin",
                subtitle: "Provide necessary details about Next of Kin"),
          ],
        ),
      ),
    );
  }
}
