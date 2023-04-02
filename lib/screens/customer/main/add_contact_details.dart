import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/constant/size.dart';
import 'package:pocket_pay_app/screens/customer/main/success_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button_load.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);
    final _key = GlobalKey<FormState>();
    final _contactNameController = TextEditingController();
    final _contactPhoneController = TextEditingController();
    final _contactRelationshipController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(
        title: "Add contact information",
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: Column(
            children: [
              vertical20,
              CustomTextField(
                labelText: "Contact name",
                hintText: "John",
                controller: _contactNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => userProv.validateComment(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Contact Phone",
                hintText: "090***********",
                controller: _contactPhoneController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => userProv.validatePhoneNumber(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Contact Relationship",
                hintText: "Father",
                controller: _contactRelationshipController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => userProv.validateComment(value!),
              ),
              vertical30,
              CustomButtonLoad(
                  userProv: userProv.state,
                  onTap: () async {
                    if (!_key.currentState!.validate()) return;
                    bool res = await userProv.setContactDetails(
                        _contactNameController.text,
                        _contactPhoneController.text,
                        _contactRelationshipController.text);
                    if (res) {
                      Get.off(SuccessScreen(
                        content: "Contact information added",
                        onTap: () {
                          userProv.fetchCustomerProfile();
                          Get.back();
                        },
                      ));
                    }
                  },
                  label: "Submit")
            ],
          ),
        ),
      ),
    );
  }
}
