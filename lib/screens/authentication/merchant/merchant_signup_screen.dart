import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_create_password_screen.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../constant/colors.dart';
import '../../../constant/size.dart';
import '../../../constant/text_Style.dart';
import '../../../utils/sizeconfig.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/customer_appbar.dart';

class MerchantSignupScreen extends StatefulWidget {
  const MerchantSignupScreen({super.key});

  @override
  State<MerchantSignupScreen> createState() => _MerchantSignupScreenState();
}

class _MerchantSignupScreenState extends State<MerchantSignupScreen> {
  final _key = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _otherNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  File? file;
  String _filePath = "";
  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: ListView(
            children: [
              Text(
                "Business owner info",
                style: txStyle27Bold.copyWith(color: appPrimaryColor),
              ),
              Text(
                "Let's know about our CEO 🫡",
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
                "Upload your best picture 🤳",
                style: txStyle12,
              )),
              vertical10,
              CustomTextField(
                labelText: "First Name",
                hintText: "First Name",
                controller: _firstNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => authProv.validateName(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Last Name",
                hintText: "Last Name",
                controller: _lastNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => authProv.validateName(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Other Name",
                hintText: "Other Name",
                controller: _otherNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => authProv.validateName(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Email",
                hintText: "Email",
                controller: _emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => authProv.validateEmail(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Phone Number",
                hintText: "Phone Number",
                controller: _phoneController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => authProv.validatePhoneNumber(value!),
              ),
              vertical20,
              CustomButton(
                  onTap: () async {
                    if (!_key.currentState!.validate()) return;

                    Get.to(MerchantCreatePasswordScreen(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      otherName: _otherNameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                    ));
                  },
                  label: "Proceed")
            ],
          ),
        ),
      ),
    );
  }
}
