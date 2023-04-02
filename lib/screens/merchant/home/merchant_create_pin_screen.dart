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

class MerchantCreatePinScree extends StatelessWidget {
  const MerchantCreatePinScree({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);
    final _key = GlobalKey<FormState>();
    final _pinController = TextEditingController();
    final _confirmPincontroller = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(
        title: "Create PIN",
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: Column(
            children: [
              vertical20,
              CustomTextField(
                labelText: "PIN",
                hintText: "****",
                obscureText: true,
                controller: _pinController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => userProv.validatePin(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Confirm PIN",
                hintText: "****",
                obscureText: true,
                controller: _confirmPincontroller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => userProv.confirmPin(value!),
              ),
              vertical30,
              CustomButtonLoad(
                  userProv: userProv.state,
                  onTap: () async {
                    if (!_key.currentState!.validate()) return;
                    bool res =
                        await userProv.createMerchantPin(_pinController.text);
                    if (res) {
                      Get.off(SuccessScreen(
                        content: "PIN created successfully",
                        onTap: () {
                          userProv.fetchMerchantProfile();

                          Get.back();
                        },
                      ));
                    }
                  },
                  label: "Create PIN")
            ],
          ),
        ),
      ),
    );
  }
}
