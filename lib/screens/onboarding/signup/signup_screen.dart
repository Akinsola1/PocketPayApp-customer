import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/auth_reository.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/onboarding/signup/create_password_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _otherNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String genderSelected = "";

  bool male = false;
  bool female = false;

  @override
  Widget build(BuildContext context) {
    final authRepository authRep = Get.put(authRepository());
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
        child: ListView(
          children: [
            Text(
              "Create Account",
              style: txStyle27Bold.copyWith(color: kPrimaryColor),
            ),
            Text(
              "Pay on the go with Pocket Pay! 🚀",
              style: txStyle14,
            ),
            vertical20,
            CustomTextField(
              labelText: "First Name",
              hintText: "First Name",
              controller: _firstNameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => authRep.validateName(value!),
            ),
            vertical10,
            CustomTextField(
              labelText: "Last Name",
              hintText: "Last Name",
              controller: _lastNameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => authRep.validateName(value!),
            ),
            vertical10,
            CustomTextField(
              labelText: "Other Name",
              hintText: "Other Name",
              controller: _otherNameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => authRep.validateName(value!),
            ),
            vertical10,
            CustomTextField(
              labelText: "Email",
              hintText: "Email",
              controller: _emailController,
              autovalidateMode: AutovalidateMode.disabled,
              validator: (value) => authRep.validateEmail(value!),
            ),
            vertical10,
            CustomTextField(
              labelText: "Phone Number",
              hintText: "Phone Number",
              controller: _phoneController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => authRep.validatePhoneNumber(value!),
            ),
            vertical20,
            CustomButton(onTap: () {
              Get.to(const CreatePasswordScreen());
            }, label: "Proceed")
          ],
        ),
      ),
    );
  }
}
