import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/constant/colors.dart';
import 'package:pocket_pay_app/screens/customer/main/success_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button_load.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../constant/export_constant.dart';

class AddStaffScreen extends StatefulWidget {
  final String businessId;
  const AddStaffScreen({super.key, required this.businessId});

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
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
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Add staff",
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(5)),
          child: ListView(
            children: [
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
                "Tap to upload staff image",
                style: txStyle12,
              )),
              vertical10,
              CustomTextField(
                labelText: "First Name",
                hintText: "First Name",
                controller: _firstNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => userProv.validateName(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Last Name",
                hintText: "Last Name",
                controller: _lastNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => userProv.validateName(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Other Name",
                hintText: "Other Name",
                controller: _otherNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => userProv.validateName(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Email",
                hintText: "Email",
                controller: _emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => userProv.validateEmail(value!),
              ),
              vertical10,
              CustomTextField(
                labelText: "Phone Number",
                hintText: "Phone Number",
                controller: _phoneController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => userProv.validatePhoneNumber(value!),
              ),
              vertical20,
              CustomButtonLoad(
                userProv: userProv.state,
                  onTap: () async {
                    if (!_key.currentState!.validate()) return;

                    bool u = await userProv.registerStaff(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        otherName: _otherNameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        businessId: widget.businessId,
                        profilePicture: _filePath,
                        );
                        
                    if (u) {
                      Get.off(SuccessScreen(
                          content: "User Profile created successfully 🥳🎉",
                          buttonText: "Finish",
                          onTap: () {
                            userProv.fetchBusinessStaffs(
                                businessId: widget.businessId);
                            Get.close(1);
                          }));
                    }
                  },
                  label: "Proceed")
            ],
          ),
        ),
      ),
    );
  }
}
