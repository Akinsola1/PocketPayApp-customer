import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/screens/authentication/customer/login_screen.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_login_screen.dart';
import 'package:pocket_pay_app/screens/customer/main/success_screen.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/merchant_repository.dart';
import '../../../api/repositories/user_repository.dart';
import '../../../constant/colors.dart';
import '../../../constant/size.dart';
import '../../../constant/text_Style.dart';
import '../../../utils/sizeconfig.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_button_load.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/customer_appbar.dart';

class MerchantCreateBusinessProfileScreen extends StatefulWidget {
  final bool isSignup;
  const MerchantCreateBusinessProfileScreen({super.key, this.isSignup = true});

  @override
  State<MerchantCreateBusinessProfileScreen> createState() =>
      _MerchantCreateBusinessProfileScreenState();
}

class _MerchantCreateBusinessProfileScreenState
    extends State<MerchantCreateBusinessProfileScreen> {
  final _key = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _businessDesriptionController = TextEditingController();
  final _businessRegNoController = TextEditingController();
  final _businessphoneController = TextEditingController();
  final _businessemailController = TextEditingController();
  File? file;
  String _filePath = "";

  @override
  Widget build(BuildContext context) {
    final merchantProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: ListView(
            children: [
              Text(
                "Business info",
                style: txStyle27Bold.copyWith(color: appPrimaryColor),
              ),
              Text(
                "Add a business profile",
                style: txStyle14,
              ),
              vertical20,
              Center(
                child: InkWell(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(type: FileType.image);
                    if (result != null) {
                      log(_filePath);
                      file = File(result.files.single.path!);
                      _filePath = result.files.single.path!;

                      setState(() {});
                    } else {
                      // User canceled the picker
                    }
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: appPrimaryColor)),
                    child: Center(
                        child: file == null
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                    color: Color(0xffFAFAFA),
                                    shape: BoxShape.circle),
                                child: const Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Color(0xff888888),
                                    size: 30,
                                  ),
                                ),
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    // color: appPrimaryColor,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: FileImage(
                                          file!,
                                        ),
                                        fit: BoxFit.cover)),
                              )),
                  ),
                ),
              ),
              vertical5,
              Center(
                  child: Text(
                "Upload business logo",
                style: txStyle12,
              )),
              vertical10,
              CustomTextField(
                labelText: "Business Name",
                hintText: "PocketPay",
                controller: _businessNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => merchantProv.validateName(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Business Description",
                hintText: "Fast and secure payment method",
                controller: _businessDesriptionController,
                autovalidateMode: AutovalidateMode.disabled,
                validator: (value) => merchantProv.validateComment(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Business phone number",
                hintText: "090*********",
                controller: _businessphoneController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => merchantProv.validatePhoneNumber(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Business Email",
                hintText: "pocketpay@gmail.com",
                controller: _businessemailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => merchantProv.validateEmail(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Business Reg Number",
                hintText: "111222333444",
                controller: _businessRegNoController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => merchantProv.validateRegNum(value!),
              ),
              vertical20,
              CustomButtonLoad(
                  userProv: merchantProv.state,
                  onTap: () async {
                    bool u = await merchantProv.createBusinessProfile(
                        businessName: _businessNameController.text,
                        businessEmail: _businessemailController.text,
                        businessDescription: _businessDesriptionController.text,
                        businessPhone: _businessphoneController.text,
                        businessRegNo: _businessRegNoController.text,
                        businessLogo: _filePath);

                    if (u) {
                      widget.isSignup?
                      Get.to(SuccessScreen(
                        content:
                            "Account created successfully!\nYou are good to go.",
                        onTap: () {
                          Get.offAll(MerchantLoginScreen());
                        },
                      )):Get.off(SuccessScreen(
                        content:
                            "Business profile created 🥳!\nStarts receiving payments 💰",
                        onTap: () {
                          merchantProv.fetchMerchantBusiness();
                          Get.back();
                        },
                      ));
                    }
                  },
                  label: "Finish")
            ],
          ),
        ),
      ),
    );
  }
}
