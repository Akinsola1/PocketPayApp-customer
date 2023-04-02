import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/main/success_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_button_load.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/merchant_repository.dart';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({super.key});

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
  final ninController = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Identity verification",
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: ListView(
            children: [
              vertical20,
              Center(
                child: Text(
                  "The information requested are to verify the admin profile created",
                  style: txStyle12.copyWith(color: Colors.grey),
                ),
              ),
              vertical20,
              CustomTextField(
                labelText: "NIN(National Identification Number)",
                hintText: "****************",
                controller: ninController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => userProv.validateNIN(value!),
              ),
              vertical10,
              InkWell(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(type: FileType.image);
                  if (result != null) {
                    userProv.setImage(File(result.files.single.path!));
                  } else {
                    // User canceled the picker
                  }
                },
                child: Container(
                  height: 58,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffD5DDE0).withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: userProv.driverImage == null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Upload NIN slip image",
                                  style: txStyle13wt.copyWith(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                Icon(Icons.file_upload_outlined,
                                    color: Colors.black.withOpacity(0.5))
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                  userProv.tempNinPicture,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                InkWell(
                                  onTap: () {
                                    userProv.clearImage();
                                  },
                                  child: Icon(Icons.delete_forever,
                                      color: Colors.black.withOpacity(0.5)),
                                )
                              ],
                            )),
                ),
              ),
              vertical5,
              hasError
                  ? Text(
                      "Please provide image of NIN slip",
                      style: txStyle12.copyWith(color: Colors.red),
                    )
                  : SizedBox.shrink(),
              vertical30,
              CustomButtonLoad(
                  userProv: userProv.state,
                  onTap: () async {
                    if (!_key.currentState!.validate()) return;
                    if (userProv.tempNinPicture.isEmpty) {
                      setState(() {
                        hasError = true;
                      });
                      return;
                    }

                    bool u = await userProv.setMerchantNin(
                        ninController.text, userProv.tempNinPicture);

                    if (u) {
                      Get.off(SuccessScreen(
                          content:
                              "Identity verification completed! \n You will be notified it is approved",
                          onTap: () {
                            userProv.fetchMerchantProfile();
                            Get.back();
                          }));
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
